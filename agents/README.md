---
description: Multi-agent system for Syntaxify project
profile: syntaxify
inherits_from: default
---

# Syntaxify Multi-Agent System

> Specialized AI agents for the Syntaxify compile-time UI generator.

## Agent Roster

| Agent                       | Role                 | Focus                             |
| --------------------------- | -------------------- | --------------------------------- |
| [Architect](./architect.md) | System Design        | AST structure, compiler, emitters |
| [Engineer](./engineer.md)   | Implementation       | CLI, parsers, code emission       |
| [Designer](./designer.md)   | Semantics            | Node variants, icon names, tokens |
| [QA](./qa.md)               | Quality              | Golden tests, validation          |
| [DevEx](./devex.md)         | Developer Experience | Docs, errors, ARCHITECTURE.md     |
| [Product](./product.md)     | Product Strategy     | 5-stage roadmap, positioning      |

## Core Documents

All agents reference these authoritative docs:

- `planning/AST.md` — UI AST specification
- `planning/SPEC.md` — Core Syntaxify specification
- `planning/ROADMAP.md` — 5-stage development plan
- `planning/AST_EXAMPLES.md` — Reference examples

## How to Use

> "Work as the Engineer agent on Stage 2"

## Current Stage

**Stage 2: Lock Correctness & Narrative**

1. Fix callback → action identifier
2. Update README language
3. Add golden test
4. Write ARCHITECTURE.md
