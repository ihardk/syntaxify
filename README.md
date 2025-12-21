# Syntaxify ⚡

**The Flutter UI Compiler. Define once, compile to any design system.**

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

**Syntaxify solves this by introducing a "UI Compiler" layer:**
1.  **Define Intent**: You declare *what* you want (e.g., "A Primary Button that submits the form").
2.  **Compile**: The engine transforms this intent into optimization Flutter code.
3.  **Inject Style**: The runtime injects the correct Design System (Material, Cupertino, or your own) at build time.

---

## 🏗️ Architecture

Syntaxify is built as a **Meta-Framework**. It sits *above* Flutter to manage architecture and consistency.

| Component     | Location                   | Purpose                                           |
| :------------ | :------------------------- | :------------------------------------------------ |
| **Generator** | [`generator/`](generator/) | The CLI tool (`syntaxify build`) and AST Parser.  |
| **Runtime**   | `package:syntaxify`        | The core library living in your app.              |
| **Agents**    | `.agent/`                  | AI Agent definitions for the "Agent-OS" workflow. |

👉 **[Read the Architecture Guide](ARCHITECTURE.md)**

---

## 🗺️ Roadmap & Status

| Milestone  | Status       | Description                                                   |
| :--------- | :----------- | :------------------------------------------------------------ |
| **v0.1.0** | ✅ **Alpha**  | Core AST, 7 Components, 3 Design Styles, CLI.                 |
| **v0.2.0** | 🔄 **Active** | Jetpack Compose Validation, Golden Tests, Error Improvements. |
| **v1.0.0** | 🔮 **Future** | VS Code Extension, Theme Editor, Full Stability.              |

👉 **[View Full Roadmap](planning/ROADMAP.md)**

---

## 🤝 Contributing

This is a monorepo-style workspace managed by the **Forge** team.
*   **Issues**: Please file issues in this repository.
*   **Development**: See [`generator/docs/developer_manual.md`](generator/docs/developer_manual.md).

---

<div align="center">

**[📦 Get the Package on Pub.dev](generator/README.md)** • **[⭐ Star on GitHub](https://github.com/ihardk/syntaxify)** • **[☕ Support the Dev](https://buymeacoffee.com/ihardik)**

</div>
