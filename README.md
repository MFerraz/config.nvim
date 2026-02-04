# Neovim Configuration

A modern, modular Neovim configuration built on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) with extensions for AI-assisted development, comprehensive git integration, and professional language server support.

## Overview

This is a production-ready configuration designed for developers who want:
- **Modern development tools**: LSP, Treesitter, fuzzy finding
- **AI assistance**: Integrated sidekick.nvim for AI-powered workflows
- **Git-first workflow**: Full git integration with visual feedback
- **Minimal bloat**: Only essential plugins, optional features can be toggled
- **Mnemonic keybindings**: Organized, discoverable shortcuts with which-key

## Quick Start

### Requirements

- **Neovim** 0.9+ (latest stable/nightly recommended)
- **ripgrep**: Required for Telescope search
  ```sh
  # macOS
  brew install ripgrep
  # or use your system package manager
  ```

### Installation

Clone this repository:

```sh
git clone <your-repo-url> ~/.config/nvim
cd ~/.config/nvim
```

Start Neovim and plugins will auto-install:

```sh
nvim
```

Or manually sync plugins:

```sh
nvim --headless "+Lazy! sync" +qa
```

## Features & Organization

### Core Development Features

**Language Server Protocol (LSP)**
- Auto-completion with `nvim-cmp`
- Go to definition, references, rename, code actions
- Diagnostic floating windows with navigation
- Pre-configured for Lua, Go, Python, Rust, TypeScript, C/C++

**Fuzzy Finding & Search**
- `<leader>sf` - Find files
- `<leader>sg` - Live grep search
- `<leader>/` - Search in current buffer
- `<leader><space>` - Search open buffers
- Uses native FZF for speed

**Syntax Highlighting & Code Navigation**
- Treesitter for modern syntax highlighting
- Text objects for functions, classes, parameters
- Smart indentation guides via snacks.nvim

### Git Workflow

Comprehensive git integration with visual feedback:

**Navigation & Status** (`<leader>g`)
- `<leader>gs` - Open git file explorer
- `<leader>gl` - Browse git log history
- Git change indicators in the gutter (added/modified/deleted lines)

**Merge Conflicts** (`<leader>gc`)
- `<leader>gco` - Choose our version
- `<leader>gct` - Choose their version
- `<leader>gcq` - View all conflicts in quickfix

**Full Git Commands**
- Access via `:Git` (vim-fugitive)
- Staging, committing, branching, and more

### AI Integration

**Sidekick.nvim** - AI Assistant
- TMux backend enabled for multiple AI sessions
- Spawns isolated AI windows for focused work
- Integrates with development workflow

### UI & Appearance

**Gruvbox Theme**
- Warm, retro colorscheme with excellent readability
- Optimized for terminal and GUI usage

**Status Line & UI**
- Lualine status bar with file info, git branch, and diagnostics
- Which-key helper showing available keybindings
- File icons for better visual navigation
- Enhanced notifications and input dialogs

### File Management

**Oil.nvim** - Directory as Buffer
- Open parent directory with `-`
- Edit directories like buffers
- Shows git status and file details
- More powerful than traditional file trees

### Commenting

**Comment.nvim**
- `gcc` - Toggle comment on line
- `gc` + motion - Toggle comment on selection
- Smart comment handling for all languages

## Keyboard Shortcuts

### Leader Key: `<Space>`

**Search** (`<leader>s`)
- `/` - Fuzzy search current buffer
- `f` - Find files
- `g` - Live grep
- `h` - Search help
- `w` - Search word under cursor
- `d` - Search diagnostics
- `?` - Recent files
- `<space>` - Open buffers

**LSP** (Smart context-aware)
- `gd` - Go to definition
- `gr` - Find references
- `gI` - Go to implementation
- `<leader>D` - Type definition
- `<leader>rn` - Rename symbol
- `<leader>ca` - Code actions
- `K` - Hover documentation

**Git** (`<leader>g`)
- `s` - Git file explorer
- `l` - Git log
- `c` + `o/t/q` - Merge conflict helpers

**Buffer** (`<leader>b`)
- `d` - Close buffer
- `n` - Next buffer

**Git Hunks** (`<leader>h`)
- `p` - Preview hunk
- `[c` / `]c` - Navigate hunks

**Diagnostics**
- `[d` / `]d` - Previous/next diagnostic
- `<leader>e` - Show diagnostic
- `<leader>q` - Diagnostics list

**Other**
- `-` - Open parent directory (oil)
- `<leader>f` - Format buffer
- `<leader>v` - File explorer
- `<C-f>` - Open tmux-sessionizer

## Project Structure

```
lua/
├── config/          # Core Neovim configuration
│   ├── init.lua     # Settings and options
│   ├── keymaps.lua  # All custom keybindings
│   ├── autocmds.lua # Autocommands
│   └── lazy.lua     # Plugin manager setup
├── plugins/         # Plugin configurations (modular)
│   ├── ai/          # AI integration
│   ├── core/        # LSP, completion, treesitter, telescope
│   ├── ui/          # Colorscheme, statusline, icons
│   ├── git/         # Git integration
│   ├── editor/      # File management, commenting, keymaps
│   └── optional/    # Autoformat, debugging (toggleable)
└── utils/           # Helper functions
```

## Customization

### Adding Plugins

Create a new file in `lua/plugins/` with the plugin spec:

```lua
-- lua/plugins/myplugin.lua
return {
  "author/plugin-name",
  config = function()
    require("plugin-name").setup({})
  end,
}
```

The plugin will auto-load via lazy.nvim.

### Modifying Keybindings

Edit `lua/config/keymaps.lua` to add or change shortcuts. See which-key integration for discoverability.

### Changing Language Server Settings

Edit `lua/plugins/core/lsp.lua` to add servers or modify configurations.

### Enabling Optional Features

**Autoformatting**: Toggle with `:KickstartFormatToggle` or enable in `lua/plugins/optional/autoformat.lua`

**Debugging**: Enable in `lua/plugins/optional/debug.lua` for Go debugging with DAP

## Installed Plugins (33 total)

### Essential
- nvim-lspconfig, mason, nvim-cmp, nvim-treesitter
- telescope, plenary
- lualine, gruvbox, nvim-web-devicons, snacks

### Git & VCS
- vim-fugitive, vim-rhubarb, gitsigns, vim-flog, git-conflict

### Editor Tools
- comment.nvim, oil.nvim, which-key.nvim

### LSP & Completion
- LuaSnip, friendly-snippets, cmp-nvim-lsp, neodev

### Markdown & Documentation
- render-markdown.nvim (markdown rendering)

### Optional (Debugging)
- nvim-dap, nvim-dap-ui, mason-nvim-dap

### Specialized
- sidekick.nvim (AI), vim-sleuth (indentation)

## Tips & Best Practices

- **Use which-key**: Press `<leader>` and wait a moment to see all available commands
- **Search first**: Use `<leader>s` to find files/text rather than manual navigation
- **LSP navigation**: `gd`, `gr`, `gI` are faster than grep for code navigation
- **Git hunks**: Use `[c`/`]c` to review changes before staging
- **Oil.nvim**: Press `-` to open parent directory, edit like a normal buffer

## Troubleshooting

**Plugins not installing?**
- Run `:Lazy` and check for errors
- Ensure ripgrep is installed (`rg --version`)

**LSP not working?**
- Run `:Mason` and install servers for your languages
- Check `:LspInfo` to confirm servers are loaded

**Treesitter parse errors?**
- Run `:TSInstall <language>` to install language support

**Search not working?**
- Ensure ripgrep is installed: `brew install ripgrep`

## Configuration Philosophy

This configuration follows these principles:

1. **Productivity first** - Fast, mnemonic keybindings
2. **Convention over configuration** - Sensible defaults, minimal setup
3. **Modern tooling** - LSP, Treesitter, async completion
4. **Vim philosophy** - Respects traditional vim patterns
5. **Extensible** - Easy to customize without major refactoring
6. **Clean code** - Well-organized, documented structure

## License

Based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)

## Resources

- [Neovim documentation](https://neovim.io/doc/)
- [Kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
- [Lazy.nvim](https://github.com/folke/lazy.nvim)
- [LSP Guide](https://neovim.io/doc/user/lsp.html)
- [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
