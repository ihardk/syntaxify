# Welcome to Syntaxify! 🎓

**A Complete Learning Guide for Contributors**

Welcome! This learning guide will help you understand Syntaxify from the ground up, even if you're a junior Flutter developer. By the end, you'll know how everything works and be ready to contribute.

---

## 📚 Table of Contents

### Core Concepts (Start Here!)

1. **[What is Syntaxify?](01-what-is-syntaxify.md)** ⭐ START HERE
   - The problem it solves
   - Core idea in 5 minutes
   - Real-world example

2. **[Architecture Overview](02-architecture-overview.md)** ⭐ READ SECOND
   - High-level architecture
   - How data flows
   - Directory structure

3. **[The AST System](03-ast-system.md)** 📝
   - What is an AST?
   - How Syntaxify uses AST
   - Creating screen definitions

4. **[The Renderer Pattern](04-renderer-pattern.md)** 🎨
   - WHAT vs HOW separation
   - How styles work
   - Switching between Material/Cupertino/Custom

5. **[Code Generation Explained](05-code-generation.md)** ⚙️
   - How code is generated
   - From meta file → Dart code
   - Using code_builder

### Deep Dives

6. **[Parser Deep Dive](06-parser-deep-dive.md)** 🔍
   - How meta files are parsed
   - AST node parsing
   - Screen definition parsing

7. **[Generator Deep Dive](07-generator-deep-dive.md)** 🏗️
   - Component generators
   - Screen generators
   - Code emission

8. **[Design System Deep Dive](08-design-system-deep-dive.md)** 🎨
   - Foundation Tokens architecture
   - TokenGenerator and smart mapping
   - Creating custom design systems

### Practical Guides

9. **[Adding a New Component](09-adding-new-component.md)** ✨
   - Step-by-step guide
   - Example: Adding a Card component
   - Checklist

10. **[Adding a New Style](10-adding-new-style.md)** 🎭
    - Step-by-step guide
    - Example: Adding GlassmorphismStyle
    - Checklist

11. **[Debugging Guide](11-debugging-guide.md)** 🐛
    - Common issues
    - How to debug
    - Troubleshooting tips

### Reference

12. **[File Reference](12-file-reference.md)** 📁
    - Every important file explained
    - What it does, when to modify it

13. **[API Reference](13-api-reference.md)** 📖
    - Key classes and methods
    - Usage examples

14. **[Contributing Guide](14-contributing.md)** 🤝
    - Setting up dev environment
    - Running tests
    - Submitting PRs

---

## 🎯 Learning Paths

### Path 1: "I want to understand how it works"
```
01 → 02 → 03 → 04 → 05 → 12
```
**Time:** 1-2 hours

### Path 2: "I want to add a component"
```
01 → 02 → 03 → 04 → 09
```
**Time:** 45 minutes

### Path 3: "I want to add a custom design style"
```
01 → 02 → 04 → 08 → 10
```
**Time:** 1 hour

### Path 4: "I want to understand code generation"
```
01 → 02 → 05 → 06 → 07
```
**Time:** 1.5 hours

### Path 5: "I want to contribute code"
```
01 → 02 → 03 → 04 → 05 → 14
```
**Time:** 2 hours

---

## 🚀 Quick Start (5 Minutes)

**Want to see it in action first?**

1. **Clone the repo:**
   ```bash
   git clone https://github.com/ihardk/syntaxify.git
   cd syntaxify/generator
   ```

2. **Run the example:**
   ```bash
   cd example
   flutter run
   ```

3. **See the magic:**
   - Look at `example/meta/login.screen.dart` (INPUT)
   - Run `dart run syntaxify build`
   - Look at `example/lib/screens/login_screen.dart` (OUTPUT)
   - See how a simple definition became a full Flutter screen!

4. **Enable Watch Mode:** 🆕
   ```bash
   dart run syntaxify build --watch
   ```
   - Edit any `.meta.dart` file
   - Syntaxify auto-rebuilds on save!
   - Press Ctrl+C to stop

5. **Toggle styles:**
   - Open `example/lib/main.dart`
   - Change `MaterialStyle()` to `CupertinoStyle()`
   - Hot reload
   - Watch the entire app change to iOS style! 🎉

Now you're ready to dive deeper. Start with [01-what-is-syntaxify.md](01-what-is-syntaxify.md)!

---

## 💡 Learning Tips

### For Visual Learners 👀
- Each document has diagrams showing data flow
- Look at code examples side-by-side with explanations
- Run the example app while reading

### For Hands-On Learners ✋
- Try modifying examples as you read
- Break things and see what happens
- Rebuild after each change

### For Conceptual Learners 🧠
- Start with architecture overview
- Draw your own diagrams
- Explain concepts back to yourself

---

## 🎓 Prerequisites

**Required Knowledge:**
- ✅ Basic Flutter (StatelessWidget, StatefulWidget)
- ✅ Basic Dart (classes, functions)
- ✅ Command line basics

**Nice to Have (but not required):**
- ⭐ InheritedWidget
- ⭐ Code generation concepts
- ⭐ Design patterns (Strategy pattern)

**Don't know these yet?** That's OK! We'll explain as we go.

---

## 📝 Document Conventions

Throughout these documents, you'll see:

**💡 TIP:** Helpful hints and best practices

**⚠️ WARNING:** Common pitfalls to avoid

**🔍 DEEP DIVE:** Optional advanced topics

**✏️ EXERCISE:** Try it yourself

**🎯 KEY CONCEPT:** Important ideas to remember

---

## 🤔 Getting Help

**Stuck? Confused? Questions?**

1. Check the [Debugging Guide](11-debugging-guide.md)
2. Search [existing issues](https://github.com/ihardk/syntaxify/issues)
3. Ask in [GitHub Discussions](https://github.com/ihardk/syntaxify/discussions)
4. Open a new issue with the `question` label

**Found a mistake in the docs?**
Please open an issue or PR! We want these docs to be perfect.

---

## 🎉 Ready to Begin?

Start with **[01-what-is-syntaxify.md](01-what-is-syntaxify.md)** to understand what Syntaxify is and why it exists.

**Happy Learning! 🚀**

---

## 📊 Progress Tracker

Mark off each document as you complete it:

- [ ] 01 - What is Syntaxify?
- [ ] 02 - Architecture Overview
- [ ] 03 - The AST System
- [ ] 04 - The Renderer Pattern
- [ ] 05 - Code Generation Explained
- [ ] 06 - Parser Deep Dive
- [ ] 07 - Generator Deep Dive
- [ ] 08 - Design System Deep Dive
- [ ] 09 - Adding a New Component
- [ ] 10 - Adding a New Style
- [ ] 11 - Debugging Guide
- [ ] 12 - File Reference
- [ ] 13 - API Reference
- [ ] 14 - Contributing Guide

**Completed all?** You're now a Syntaxify expert! 🎓✨
