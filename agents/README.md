---
description: Multi-agent system for Forge project
profile: forge
inherits_from: default
---

# Forge Multi-Agent System

> Specialized AI agents for different aspects of the Forge project.

## Agent Roster

| Agent | Role | Triggers |
|-------|------|----------|
| [Architect](./architect.md) | System Design | architecture, patterns, tradeoffs |
| [Engineer](./engineer.md) | Implementation | implement, build, CLI, fix |
| [Designer](./designer.md) | Design System | tokens, themes, colors |
| [QA](./qa.md) | Quality | test, benchmark, validate |
| [DevEx](./devex.md) | Developer Experience | docs, errors, debug |
| [Product](./product.md) | Product Strategy | roadmap, prioritize, metrics |

## Compatibility

These agent definitions work with:
- **Antigravity** - Read as context files
- **Claude Code** - Use as Skills with triggers
- **Agent-OS** - Profiles with YAML frontmatter

## YAML Frontmatter Schema

```yaml
---
name: AgentName
description: What this agent does
triggers:
  - keyword1
  - keyword2
primary_docs:
  - planning/doc1.md
  - planning/doc2.md
---
```

## How to Use

**Antigravity/Claude Code:**
> "Work as the Engineer agent on Phase 1"

**Agent-OS:**
The YAML frontmatter provides Skills metadata for automatic activation based on triggers.

## Agent Interaction Rules

1. **Single Owner** - Each task has ONE primary agent
2. **Consultation** - Agents can consult others
3. **Escalation** - Cross-cutting concerns → Architect
4. **Documentation** - All decisions reference planning docs
