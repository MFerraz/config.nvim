# Neovim Philosophy & Opinions

This document captures your neovim preferences and philosophy to guide configuration decisions.

## Core Philosophy

Your neovim setup is built around **friction reduction** and **productivity through skill mastery**. Every plugin must justify its existence by either:
1. Reducing friction in your workflow
2. Enabling faster movement, editing, or understanding of code
3. Providing meaningful quality-of-life improvements
4. Teaching a new skill that, when mastered, significantly increases productivity

## Primary Use Case

**Web Development (JavaScript/TypeScript/React)**

Your configuration is optimized for modern web development with:
- Strong JavaScript/TypeScript support
- React component understanding
- Frontend tooling integration
- Backend Node.js/API development

## Non-Negotiable Principles

### 1. **No Mouse-Driven UI**
- Forbid plugins that require mouse navigation
- No file trees, tabs, or other GUI elements
- Everything must be keyboard-navigable
- Reason: Mouse breaks your vim flow and introduces friction

### 2. **Keyboard-First Navigation**
- Pure vim motion-based navigation
- Custom keybindings via leader key where appropriate
- Terminal integration (tmux-compatible)
- Never compromise on keyboard efficiency for UI aesthetics

### 3. **Friction Minimization**
- Plugins must reduce keystrokes or decision time
- Avoid feature bloat
- Fast startup time is important
- Lazy-load plugins that aren't needed immediately

## Feature Priorities (in order)

1. **LSP & Intelligent Completion** - Core to modern development
2. **Fuzzy Finding** - Quick file/buffer/search navigation
3. **Formatting & Linting** - Code style enforcement
4. **Navigation & Movement** - Fast code traversal with vim motions
5. **Low-Friction QOL** - Small improvements that compound

## Keybinding Philosophy

**Mixed approach**: Combine vim motions with strategic leader key sequences.

- **Vim motions (hjkl, w/b, etc)**: Core navigation and text manipulation
- **Leader key sequences**: Custom commands that have no intuitive vim equivalent
- **Learning investment**: Accept new shortcuts only if mastered learning curve leads to friction reduction

**Principle**: A complex keybinding is only valid if it reduces overall friction by more than the learning cost.

## Plugin Selection Criteria

### ✅ Accept plugins that:
- Reduce friction (e.g., telescope for fuzzy finding)
- Enable faster understanding (e.g., treesitter for syntax understanding)
- Teach powerful shortcuts that become second nature
- Provide small, meaningful visual improvements
- Integrate seamlessly with vim philosophy

### ❌ Reject plugins that:
- Require mouse interaction
- Build competing UI systems (file trees, sidebars, tabs)
- Add complexity without friction reduction
- Require extensive learning for marginal gains
- Conflict with pure keyboard workflow

## Technology Stack Alignment

**Preferred plugin authors/ecosystems:**
- Telescope (fuzzy finding philosophy)
- nvim-lspconfig (native LSP)
- Treesitter (syntax understanding)
- Formatter integrations (conform.nvim style)
- Git integrations (fugitive/gitsigns - friction reducers)

**Avoid:**
- Sidebar file explorers (netrw, neo-tree, nvim-tree)
- Tab bar plugins (bufferline, harpoon tabs)
- IDE-like plugins that compete with terminal workflow

## Configuration Strategy

1. **Minimize startup time** - Use lazy loading effectively
2. **Teach through documentation** - Document why each plugin exists
3. **One shortcut per action** - No redundant keybindings
4. **Test learning curve** - New plugins must prove their friction reduction

## Web Development Specifics

Since you work in web development:
- LSP must support TypeScript/JavaScript excellently
- Formatting should use prettier or equivalent
- Testing integration helpful but not required
- Node.js debugging support is valuable
- Git workflow is critical (staged changes, diffs, blame)

## What Success Looks Like

- You rarely think about your editor, just code
- New navigation techniques become muscle memory quickly
- Friction decreases measurably over time
- Configuration is self-documenting through clear plugin choices
- Each keybinding has a clear, remembered purpose
