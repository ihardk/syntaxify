# Syntaxify ⚡

**The Flutter UI Compiler. Define screens once, compile to any design system.**

[![pub package](https://img.shields.io/pub/v/syntaxify.svg)](https://pub.dev/packages/syntaxify)
[![GitHub stars](https://img.shields.io/github/stars/ihardk/syntaxify?style=social)](https://github.com/ihardk/syntaxify)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Buy Me A Coffee](https://img.shields.io/badge/Buy%20Me%20A%20Coffee-support-green.svg)](https://buymeacoffee.com/ihardik)

> 🚀 **Using Syntaxify?**
> Go to the **["Generator Package" (generator/README.md)](generator/README.md)** for installation instructions, API reference, and usage guides.

---

## 🌍 The Mission

Flutter developers have long struggled with the **"1:N Problem"**:
*   **One Codebase** (Dart/Flutter)
*   **Multiple Outputs** (Android Material, iOS Cupertino, Web, Custom Design System)

Traditionally, this meant writing `if (Platform.isIOS)` logic inside every single widget, or maintaining separate widget trees.

**Syntaxify solves this with a UI Compiler:**
1.  **Define Intent**: Declare *what* you want (e.g., "A Login screen with email input and submit button").
2.  **Compile**: The generator transforms your definition into production Flutter code.
3.  **Inject Style**: Switch your entire app between Material, Cupertino, or custom styles in one line.

---

## 🏗️ Architecture

Syntaxify is a **compile-time UI generator** that produces editable Flutter code from declarative definitions.

| Component     | Location                   | Purpose                                            |
| :------------ | :------------------------- | :------------------------------------------------- |
| **Generator** | [`generator/`](generator/) | CLI tool (`syntaxify build`), AST Parser, Emitter. |
| **Runtime**   | `package:syntaxify`        | Design system abstractions living in your app.     |
| **Agents**    | `.agent/`                  | AI Agent definitions for the "Agent-OS" workflow.  |

**Key Principle:** Syntaxify generates plain Dart/Flutter code. No runtime magic. You own everything it produces.

👉 **[Read the Architecture Guide](ARCHITECTURE.md)**

---

## 🗺️ Roadmap & Status

| Milestone  | Status       | Description                                                    |
| :--------- | :----------- | :------------------------------------------------------------- |
| **v0.1.0** | ✅ **Alpha**  | Core AST, 7 Components, 3 Design Styles, CLI.                  |
| **v0.2.0** | ✅ **Beta**   | Dynamic Design System, Convention-based DX, Custom Components. |
| **v1.0.0** | 🔮 **Future** | VS Code Extension, Theme Editor, Full Stability.               |

👉 **[View Full Roadmap](planning/ROADMAP.md)**

---

## 🤝 Contributing

*   **Issues**: Please file issues in this repository.
*   **Development**: See [`generator/docs/developer_manual.md`](generator/docs/developer_manual.md).

---

<div align="center">

**[📦 Get the Package on Pub.dev](generator/README.md)** • **[⭐ Star on GitHub](https://github.com/ihardk/syntaxify)** • **[☕ Support the Dev](https://buymeacoffee.com/ihardik)**

</div>
