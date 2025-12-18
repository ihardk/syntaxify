# Spec Requirements Document

> Spec: AST Nodes Complete Specification
> Created: 2025-12-18

---

## Overview

Define all AST nodes for the Syntax UI compiler, covering layout nodes, primitive component nodes, and the screen root. This specification establishes the complete node vocabulary that Syntax will support for cross-platform code generation.

---

## User Stories

### Comprehensive Node Vocabulary

As a Syntax user, I want a complete set of AST nodes, so that I can describe any standard UI layout.

Once implemented, I can define screens using a combination of layout nodes (Column, Row, Stack, List) and primitive nodes (Text, Button, TextField, Icon, Image, Toggle, Spacer) to compose complex UIs from simple building blocks.

---

## Spec Scope

1. **ScreenDefinition** - Root node representing one UI surface
2. **Layout Nodes** - ColumnNode, RowNode, StackNode, ListNode, WrapNode, ScrollNode
3. **Primitive Nodes** - TextNode, ButtonNode, TextFieldNode, IconNode, ImageNode, ToggleNode, SpacerNode, DividerNode
4. **Container Nodes** - CardNode, ContainerNode (for grouping with background/border)

---

## Out of Scope

- Domain-specific nodes (e.g., `UserProfileCard`, `TaskListItem`)
- Navigation nodes (handled by Intent Graph in future)
- Animation nodes (runtime concern)
- Platform-specific nodes (violates cross-platform guarantee)

---

## Expected Deliverable

1. All nodes can be instantiated with only primitives and semantic strings
2. AST validates at compile-time (no runtime types allowed)
3. Each node has a corresponding Flutter emitter
4. Golden test for a screen using all node types
