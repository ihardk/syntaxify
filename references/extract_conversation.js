const fs = require('fs');
const path = 'MetaFlutter.md';
const outputPath = 'MetaFlutter_Clean.md';

try {
    const content = fs.readFileSync(path, 'utf8');

    // We will look for message blocks
    const roleRegex = /data-message-author-role="(user|assistant)"/g;
    let match;
    const messages = [];

    // Find all start indices
    const indices = [];
    while ((match = roleRegex.exec(content)) !== null) {
        indices.push({ role: match[1], index: match.index });
    }

    for (let i = 0; i < indices.length; i++) {
        const current = indices[i];
        const nextIndex = i + 1 < indices.length ? indices[i + 1].index : content.length;
        const chunk = content.substring(current.index, nextIndex);

        let text = "";

        if (current.role === 'user') {
            const userContentMatch = /<div class="whitespace-pre-wrap">(.*?)<\/div>/s.exec(chunk);
            if (userContentMatch) {
                text = userContentMatch[1];
                // basic plain text cleanup if needed, but user text is usually clean in these dumps
                text = text.replace(/<[^>]*>/g, '');
            }
        } else {
            // assistant
            // Assistant content is widely used in "markdown prose" class div
            // It might contain nested divs, so regex is fragile, but let's try to capture the main body.
            // Often it ends with some footer buttons like "copy", "good response" etc. which are in "flex" divs.
            // We'll look for the start of markdown prose and take content until we hit the next major structural div or end of chunk.

            // A more robust way for the specific format seen in view_file:
            // The content is usually within <div class="markdown prose ..."> ... </div>

            const startMarker = '<div class="markdown prose';
            const startIndex = chunk.indexOf(startMarker);
            if (startIndex !== -1) {
                // Find the closing div for this markdown prose. 
                // Since we don't have a DOM parser, we'll count braces manually or just regex extract until we suspect end.
                // However, regex with (.*?) might fail on nested divs.
                // Let's try a heuristic: extract until the "data-testid" buttons appear or "text-token-text-secondary" buttons.

                let bodyChunk = chunk.substring(startIndex);
                // Remove the start tag
                const tagEnd = bodyChunk.indexOf('>') + 1;
                bodyChunk = bodyChunk.substring(tagEnd);

                // Cut off at the footer
                const footerIndex = bodyChunk.indexOf('<div class="z-0 flex'); // common footer start in chatgpt html
                if (footerIndex !== -1) {
                    bodyChunk = bodyChunk.substring(0, footerIndex);
                }

                // Now clean up HTML to Markdown-ish text
                text = bodyChunk
                    .replace(/<h3>(.*?)<\/h3>/g, '\n### $1\n')
                    .replace(/<h2>(.*?)<\/h2>/g, '\n## $1\n')
                    .replace(/<h1>(.*?)<\/h1>/g, '\n# $1\n')
                    .replace(/<p[^>]*>(.*?)<\/p>/g, '\n$1\n')
                    .replace(/<li[^>]*>(.*?)<\/li>/g, '\n- $1')
                    .replace(/<pre[^>]*>[\s\S]*?<code[^>]*>([\s\S]*?)<\/code>[\s\S]*?<\/pre>/g, (m, code) => {
                        return '\n```\n' + code.replace(/<[^>]+>/g, '') + '\n```\n';
                    })
                    .replace(/<strong[^>]*>(.*?)<\/strong>/g, '**$1**')
                    .replace(/<em[^>]*>(.*?)<\/em>/g, '*$1*')
                    .replace(/<code[^>]*>(.*?)<\/code>/g, '`$1`')
                    .replace(/&lt;/g, '<')
                    .replace(/&gt;/g, '>')
                    .replace(/&amp;/g, '&')
                    .replace(/&quot;/g, '"');

                // Remove remaining tags
                text = text.replace(/<[^>]+>/g, '');
            }
        }

        if (text.trim()) {
            // Clean up extra newlines
            text = text.replace(/\n\s*\n/g, '\n\n').trim();
            messages.push(`## ${current.role.toUpperCase()}\n\n${text}\n\n---\n`);
        }
    }

    fs.writeFileSync(outputPath, "# Cleaned Conversation\n\n" + messages.join('\n'));
    console.log(`Successfully extracted ${messages.length} messages to ${outputPath}`);

} catch (e) {
    console.error("Error processing file:", e);
}
