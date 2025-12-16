import re
import os
from html.parser import HTMLParser

class ChatGPTParser(HTMLParser):
    def __init__(self):
        super().__init__()
        self.recording = False
        self.current_role = None
        self.messages = []
        self.current_message = []
        self.in_message_block = False
        self.div_depth = 0
        self.target_depth = -1

    def handle_starttag(self, tag, attrs):
        attrs_dict = dict(attrs)
        
        if tag == 'div':
            if 'data-message-author-role' in attrs_dict:
                self.current_role = attrs_dict['data-message-author-role']
                self.in_message_block = True
                self.div_depth = 0
                self.target_depth = 0 # We are at the root of the message block
            
            if self.in_message_block:
                self.div_depth += 1

    def handle_endtag(self, tag):
        if tag == 'div' and self.in_message_block:
            self.div_depth -= 1
            if self.div_depth == 0:
                # End of message block
                full_text = "".join(self.current_message).strip()
                if full_text:
                    self.messages.append((self.current_role, full_text))
                self.current_message = []
                self.in_message_block = False
                self.current_role = None

    def handle_data(self, data):
        if self.in_message_block:
            # We want to capture text, but maybe avoid some metadata clutter.
            # Ideally we'd preserve code blocks formatting, but simple stripping is a start.
            text = data
            if text.strip():
                self.current_message.append(text)

def clean_text(text):
    # Basic cleanup of excessive whitespace
    return re.sub(r'\n\s*\n', '\n\n', text)

def extract_from_file(file_path):
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()

    # The file has a lot of JS and CSS. We mostly care about the conversation parts.
    # The structure observed:
    # <div data-message-author-role="user" ...> ... <div class="whitespace-pre-wrap">TEXT</div> ... </div>
    # <div data-message-author-role="assistant" ...> ... <div class="markdown prose ...">HTML CONTENT</div> ... </div>
    
    # Since writing a robust streaming parser for this specific structure might be tricky with just HTMLParser
    # due to nested divs and classes, let's try a regex approach first which is often robust enough for 
    # structured exports like this.
    
    messages = []
    
    # Pattern to find message blocks. 
    # This is a heuristic: assuming the attribute data-message-author-role starts the block.
    # We will grab everything until the next message block or end of file, then clean it up.
    
    # Actually, a better approach with standard lib might be just parsing the whole thing 
    # but only printing text when we are inside a relevant div.
    
    parser = ChatGPTParser()
    parser.feed(content)
    
    return parser.messages

def refined_extraction(file_path):
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()

    # Regex approach for specific blocks which seems more reliable for this specific file dump
    # User messages usually in: <div class="whitespace-pre-wrap">CONTENTS</div>
    # Assistant messages usually in: <div class="markdown prose ...">CONTENTS</div>
    
    # Let's try to iterate through the file finding roles and then extracting the immediate text content.
    
    output_lines = []
    
    # Split by the role attribute to get chunks
    chunks = re.split(r'data-message-author-role="', content)
    
    # Skip the first chunk (header)
    for chunk in chunks[1:]:
        role = chunk.split('"')[0] # 'user' or 'assistant'
        
        # Now find the content. 
        # For user: <div class="whitespace-pre-wrap">Content</div>
        # For assistant: <div class="markdown prose ...">Content</div>
        
        text_content = ""
        
        if role == "user":
            match = re.search(r'<div class="whitespace-pre-wrap">(.*?)</div>', chunk, re.DOTALL)
            if match:
                text_content = match.group(1)
                # Remove HTML tags if any (user input is usually plain text but wrapped)
                text_content = re.sub(r'<[^>]+>', '', text_content)
        
        elif role == "assistant":
            # Assistant content is more complex HTML.
            # We look for the markdown prose div
            match = re.search(r'<div class="markdown prose[^>]*">(.*?)</div>\s*</div>\s*</div>', chunk, re.DOTALL)
            if not match:
                 # Fallback: sometimes it might be slightly different, try generic end of the message bubble
                 # The detailed HTML structure makes regex hard. 
                 # Let's try to extract text from the start of the chunk until we see some footer or options indicators.
                 pass
            
            if match:
                raw_html = match.group(1)
                # Convert common HTML to Markdown-ish text
                raw_html = re.sub(r'<h3>(.*?)</h3>', r'### \1\n', raw_html)
                raw_html = re.sub(r'<h2>(.*?)</h2>', r'## \1\n', raw_html)
                raw_html = re.sub(r'<h1>(.*?)</h1>', r'# \1\n', raw_html)
                raw_html = re.sub(r'<strong>(.*?)</strong>', r'**\1**', raw_html)
                raw_html = re.sub(r'<em>(.*?)</em>', r'*\1*', raw_html)
                raw_html = re.sub(r'<code[^>]*>(.*?)</code>', r'`\1`', raw_html)
                raw_html = re.sub(r'<pre[^>]*><div[^>]*><div[^>]*>([a-z]*)</div>.*?<code[^>]*>(.*?)</code>.*?</pre>', r'```\1\n\2\n```', raw_html, flags=re.DOTALL)
                # Provide spacing for lists
                raw_html = re.sub(r'<li>', r'\n- ', raw_html)
                raw_html = re.sub(r'</li>', r'', raw_html)
                # Paragraphs
                raw_html = re.sub(r'<p[^>]*>', r'\n\n', raw_html)
                raw_html = re.sub(r'</p>', r'', raw_html)
                
                # Remove remaining tags
                text_content = re.sub(r'<[^>]+>', '', raw_html)
                
                # Fix html entities
                text_content = text_content.replace('&lt;', '<').replace('&gt;', '>').replace('&amp;', '&').replace('&quot;', '"')

        if text_content.strip():
            output_lines.append(f"## {role.upper()}\n\n{text_content.strip()}\n\n---\n")

    return "".join(output_lines)

if __name__ == "__main__":
    input_path = r"d:\Workspace\forge\MetaFlutter.md"
    output_path = r"d:\Workspace\forge\MetaFlutter_Clean.md"
    
    cleaned_text = refined_extraction(input_path)
    
    with open(output_path, "w", encoding="utf-8") as f:
        f.write("# Cleaned Conversation\n\n")
        f.write(cleaned_text)
    
    print(f"Successfully created {output_path}")
