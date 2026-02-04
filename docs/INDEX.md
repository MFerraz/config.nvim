# Documentation Index

Complete guide to this Neovim configuration. Choose a topic below or start with the README for a quick overview.

## Quick Start

- **[README.md](../README.md)** - Overview, installation, features quick reference

## Core Topics

### Development Tools

1. **[LSP and Language Servers](./LSP-AND-SERVERS.md)**
   - Language Server Protocol setup
   - Configuring language servers (Python, Go, Rust, TypeScript, etc.)
   - Diagnostics and error handling
   - Formatting and code actions
   - Adding new servers

2. **[Completion and Snippets](./COMPLETION-AND-SNIPPETS.md)**
   - Code completion with nvim-cmp
   - Snippet templates with LuaSnip
   - Creating custom snippets
   - Completion sources and prioritization
   - Troubleshooting slow completions

3. **[Telescope: Fuzzy Finding](./TELESCOPE-FUZZY-FINDER.md)**
   - File search and filtering
   - Live grep (content search)
   - LSP integration (diagnostics, references)
   - Git file search
   - Navigation and performance tips

4. **[Treesitter: Syntax and Navigation](./TREESITTER-AND-SYNTAX.md)**
   - Modern syntax highlighting
   - Code navigation with text objects
   - Selecting functions, classes, parameters
   - Navigating between functions
   - Swapping arguments

### Editor Features

5. **[Keybindings and Which-Key](./KEYBINDINGS-AND-WHICH-KEY.md)**
   - Complete keybinding reference
   - Organized by category (search, LSP, git, etc.)
   - Adding custom keybindings
   - Mnemonic patterns
   - Debugging keybindings

6. **[Git Workflow](./GIT-WORKFLOW.md)**
   - Git integration tools (fugitive, gitsigns, flog)
   - Visual git feedback
   - Hunk navigation and review
   - Merge conflict resolution
   - Common git workflows
   - Branch management

7. **[AI Integration](./AI-INTEGRATION.md)**
   - Sidekick.nvim setup
   - Using AI assistant in editor
   - Code review and explanation
   - Generating tests and documentation
   - Integration with development workflow

8. **[Markdown Rendering](./MARKDOWN-RENDERING.md)**
   - Render-markdown.nvim setup
   - Visual markdown formatting
   - Code block syntax highlighting
   - Configuring markdown rendering
   - Editing markdown with rendering enabled

### Infrastructure

9. **[Plugin Architecture](./PLUGIN-ARCHITECTURE.md)**
   - lazy.nvim package manager
   - Plugin specs and configuration
   - Lazy loading events
   - Managing dependencies
   - Plugin installation and updates
   - Performance optimization

10. **[Extending and Customizing](./EXTENDING-AND-CUSTOMIZING.md)**
    - Adding new plugins
    - Customizing settings and keybindings
    - Creating custom commands
    - Autocommands and file-type specific setup
    - Debugging customizations
    - Sharing your configuration

## Topic-Based Navigation

### If You Want To...

**Add a new language**
- Read: [LSP and Language Servers](./LSP-AND-SERVERS.md) → "Adding a New Language Server"
- Then: [Plugin Architecture](./PLUGIN-ARCHITECTURE.md) → Understand lazy.nvim

**Customize keybindings**
- Read: [Keybindings and Which-Key](./KEYBINDINGS-AND-WHICH-KEY.md) → "Adding Custom Keybindings"
- Reference: Same document → "Complete Keybinding Reference"

**Improve code search workflow**
- Read: [Telescope: Fuzzy Finding](./TELESCOPE-FUZZY-FINDER.md)
- Combine with: [Keybindings and Which-Key](./KEYBINDINGS-AND-WHICH-KEY.md) → `<leader>s` commands

**Use git more effectively**
- Read: [Git Workflow](./GIT-WORKFLOW.md) → "Common Workflows"
- Quick reference: Same document → "Git Keybindings"

**Speed up code completion**
- Read: [Completion and Snippets](./COMPLETION-AND-SNIPPETS.md) → "Performance"
- Also check: [LSP and Language Servers](./LSP-AND-SERVERS.md) → "LSP Issues"

**Navigate code faster**
- Read: [Treesitter: Syntax and Navigation](./TREESITTER-AND-SYNTAX.md)
- Combine with: [LSP and Language Servers](./LSP-AND-SERVERS.md) → "LSP navigation"

**Use AI to help with coding**
- Read: [AI Integration](./AI-INTEGRATION.md)
- Common workflows section shows practical examples

**Add a plugin**
- Read: [Extending and Customizing](./EXTENDING-AND-CUSTOMIZING.md) → "Adding Plugins"
- Background: [Plugin Architecture](./PLUGIN-ARCHITECTURE.md)

**Debug issues**
- Check: [Extending and Customizing](./EXTENDING-AND-CUSTOMIZING.md) → "Debugging Customizations"
- Specific issues: See "Troubleshooting" in relevant topic

## Keybinding Quick Links

- **Search commands**: [Keybindings](./KEYBINDINGS-AND-WHICH-KEY.md) → `<leader>s` group
- **LSP commands**: [Keybindings](./KEYBINDINGS-AND-WHICH-KEY.md) → "LSP & Code Navigation"
- **Git commands**: [Git Workflow](./GIT-WORKFLOW.md) → "Git Plugin Keybindings"
- **File management**: [Keybindings](./KEYBINDINGS-AND-WHICH-KEY.md) → "File Management"

## Configuration Files

### Core Configuration

- `lua/config/init.lua` - Global settings (tabs, colors, search, etc.)
- `lua/config/keymaps.lua` - All keybindings
- `lua/config/autocmds.lua` - Autocommands and hooks
- `lua/config/lazy.lua` - lazy.nvim setup

### Plugin Configuration

- `lua/plugins/core/lsp.lua` - Language servers
- `lua/plugins/core/completion.lua` - Code completion
- `lua/plugins/core/treesitter.lua` - Syntax highlighting
- `lua/plugins/core/telescope.lua` - Fuzzy finder
- `lua/plugins/git/` - All git integration
- `lua/plugins/ui/` - Visual appearance
- `lua/plugins/ai/sidekick.lua` - AI integration
- `lua/plugins/optional/` - Toggleable features

## Common Tasks & Docs

| Task | Documentation |
|------|---|
| Add Python support | [LSP and Language Servers](./LSP-AND-SERVERS.md) → Python Notes |
| Write better commits | [Git Workflow](./GIT-WORKFLOW.md) → Commit workflow |
| Find function usage | [Telescope](./TELESCOPE-FUZZY-FINDER.md) → Go to References |
| Select and modify function | [Treesitter](./TREESITTER-AND-SYNTAX.md) → Text Objects |
| Get code suggestions | [AI Integration](./AI-INTEGRATION.md) → Common Workflows |
| View rendered markdown | [Markdown Rendering](./MARKDOWN-RENDERING.md) → Usage |
| Speed up startup | [Plugin Architecture](./PLUGIN-ARCHITECTURE.md) → Performance Optimization |
| Change theme | [Extending and Customizing](./EXTENDING-AND-CUSTOMIZING.md) → Customizing Settings |
| Add status line info | [Extending and Customizing](./EXTENDING-AND-CUSTOMIZING.md) → Customizing Plugins |

## Troubleshooting Index

Quick solutions to common issues:

**Plugins won't load**
- Check: [Plugin Architecture](./PLUGIN-ARCHITECTURE.md) → "Troubleshooting Plugins"

**LSP not working**
- Check: [LSP and Language Servers](./LSP-AND-SERVERS.md) → "Common LSP Issues"

**Completion is slow**
- Check: [Completion and Snippets](./COMPLETION-AND-SNIPPETS.md) → "Troubleshooting"

**Search not working**
- Check: [Telescope](./TELESCOPE-FUZZY-FINDER.md) → "Troubleshooting"

**Syntax highlighting broken**
- Check: [Treesitter](./TREESITTER-AND-SYNTAX.md) → "Common Issues"

**Keybindings not working**
- Check: [Keybindings](./KEYBINDINGS-AND-WHICH-KEY.md) → "Debugging Keybindings"

**Git commands failing**
- Check: [Git Workflow](./GIT-WORKFLOW.md) → "Troubleshooting"

**Configuration won't load**
- Check: [Extending and Customizing](./EXTENDING-AND-CUSTOMIZING.md) → "Troubleshooting Customizations"

## Learning Path

### For Beginners

1. Start with: [README.md](../README.md)
2. Learn keybindings: [Keybindings and Which-Key](./KEYBINDINGS-AND-WHICH-KEY.md)
3. Understand search: [Telescope: Fuzzy Finding](./TELESCOPE-FUZZY-FINDER.md)
4. Setup your language: [LSP and Language Servers](./LSP-AND-SERVERS.md)
5. Explore git: [Git Workflow](./GIT-WORKFLOW.md)

### For Intermediate Users

1. Master code navigation: [Treesitter: Syntax and Navigation](./TREESITTER-AND-SYNTAX.md)
2. Optimize completion: [Completion and Snippets](./COMPLETION-AND-SNIPPETS.md)
3. Customize keybindings: [Extending and Customizing](./EXTENDING-AND-CUSTOMIZING.md)
4. Learn plugin system: [Plugin Architecture](./PLUGIN-ARCHITECTURE.md)

### For Advanced Users

1. Deep dive: [Plugin Architecture](./PLUGIN-ARCHITECTURE.md)
2. Advanced customization: [Extending and Customizing](./EXTENDING-AND-CUSTOMIZING.md)
3. Optimize performance: [Plugin Architecture](./PLUGIN-ARCHITECTURE.md) → Performance
4. Create integrations: All docs → integration sections

## Reference Tables

Key commands for quick lookup (also in respective docs):

### Essential Searches
```
<leader>sf  Find files
<leader>sg  Live grep
<leader>/   Search buffer
<leader>sd  Search diagnostics
```

### LSP Navigation
```
gd          Go to definition
gr          Find references
gI          Go to implementation
K           Show documentation
```

### Git Workflow
```
<leader>gs  Git file status
<leader>gl  Git log
[c / ]c     Navigate hunks
<leader>gc  Merge conflicts
```

### Code Navigation
```
vaf         Select function
]m / [m     Jump between functions
<leader>a   Swap arguments
```

## Tips

- **Use which-key**: Press `<leader>` and wait to see all commands
- **Search first**: `<leader>s` commands are faster than manual navigation
- **Text objects**: `vaf`, `dac` etc. are powerful once memorized
- **Snippets**: Write templates once, use many times
- **Git hunks**: Use `[c`/`]c` + `<leader>hp` to review before committing
- **AI help**: Use for code review, documentation, debugging

## Document Status

All documentation is up-to-date with the current configuration. Last updated: 2026-02-04

## Contributing Improvements

Found errors or want to improve docs?
1. Check current version in docs/
2. Propose improvements
3. Reference specific sections

## Snacks-Specific Guides

- **[SNACKS-ANALYSIS.md](./SNACKS-ANALYSIS.md)** - All 31 snacks modules evaluated
- **[SNACKS-CONFLICTS.md](./SNACKS-CONFLICTS.md)** - Potential conflicts with your plugins
- **[SNACKS-INTERNAL-MODULES.md](./SNACKS-INTERNAL-MODULES.md)** - Understanding internal modules (animate, util, win, notify)

## Additional Resources

- [Neovim Documentation](https://neovim.io/doc/)
- [vim Tips & Tricks](https://vim.rtorr.com/)
- [Lua Programming Manual](https://www.lua.org/manual/5.1/)

---

**Quick Start**: Not sure where to begin? Read [README.md](../README.md) then jump to a topic above. Use `<leader>` in editor to discover keybindings as you go!
