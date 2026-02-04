# Language Server Protocol (LSP) Configuration

## Overview

This configuration uses `nvim-lspconfig` with `mason` for automatic LSP installation and management. The setup is modular and extensible.

## Current Setup

**File**: `lua/plugins/core/lsp.lua`

### Pre-configured Languages

#### Lua (lua_ls)
The primary language with full configuration:
- **Settings**: Enhanced with neodev.nvim for Neovim API completions
- **Workspace libraries**: Configured to understand Neovim plugin APIs
- **Formatting**: Built-in with stylua

#### Available but Commented
To enable additional servers, uncomment in `lua/plugins/core/lsp.lua`:

```lua
-- clangd      (C/C++)
-- gopls       (Go)
-- pyright     (Python)
-- rust_analyzer (Rust)
-- tsserver    (TypeScript/JavaScript)
```

## Adding a New Language Server

### 1. Install via Mason

```vim
:Mason
```

Search and install the desired server (e.g., `pyright` for Python).

### 2. Configure in LSP Config

Edit `lua/plugins/core/lsp.lua` and add:

```lua
require('lspconfig').pyright.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = 'workspace',
      }
    }
  }
})
```

### 3. Verify It Loads

In Neovim, run:
```vim
:LspInfo
```

Should show the server as attached to the current buffer.

## On Attach Hook

The `on_attach` function (in `lua/plugins/core/lsp.lua`) runs when an LSP server attaches to a buffer. This sets up:
- LSP keybindings (gd, gr, gI, etc.)
- Document formatting
- Hover documentation
- Signature help

If you add custom keybindings or features, they should go in the `on_attach` function.

## LSP Commands

| Command | Action |
|---------|--------|
| `:LspInfo` | Show attached LSP servers for current buffer |
| `:Mason` | Open Mason installer UI |
| `:LspRestart` | Restart all LSP servers |
| `:LspStop` | Stop all LSP servers |
| `:LspStart` | Start LSP servers |

## Common LSP Issues

### Server Not Starting

1. Check if installed: `:Mason`
2. Verify it's configured in `lsp.lua`
3. Check language detection: filetype must match LSP config
4. Review error logs: `:LspInfo` shows diagnostics

### Slow Completions

- Check `:LspInfo` for performance warnings
- Some servers (tsserver) are slower; consider `denols` for TypeScript
- Disable unused language servers

### Conflicting Formatters

If multiple servers provide formatting, only the last configured one will be used. To prioritize:

```lua
-- In on_attach, disable formatting for some servers:
if client.name ~= 'tsserver' then
  client.server_capabilities.documentFormattingProvider = false
end
```

## Formatting Integration

LSP formatting is handled by `<leader>f` keymap (see `lua/config/keymaps.lua`):

```lua
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { noremap = true })
```

For autoformatting on save, enable `lua/plugins/optional/autoformat.lua`.

## Diagnostics Display

Diagnostics (errors, warnings) appear:
- **In the gutter**: Red/yellow squiggles with line numbers
- **On demand**: `<leader>e` shows floating window
- **In quickfix**: `<leader>q` lists all diagnostics

Customize diagnostic appearance in `lua/config/init.lua`:

```lua
vim.diagnostic.config({
  virtual_text = true,  -- Show inline
  signs = true,         -- Show in gutter
  underline = true,     -- Underline text
  update_in_insert = false,
  severity_sort = true,
})
```

## Completion Integration

LSP completions integrate with `nvim-cmp`:
- Source: `cmp_nvim_lsp` pulls from LSP servers
- Triggered with `<C-x><C-o>` or autocomplete
- Snippets (LuaSnip) expand LSP snippet placeholders

See `docs/COMPLETION-AND-SNIPPETS.md` for details.

## Neodev.nvim (Lua Enhancement)

For Lua development, `neodev.nvim` provides:
- Neovim API completions
- Vim standard library types
- Plugin typing information

Automatically configured for `.nvim/lua` directories.

## Workspace Diagnostics

Some servers support workspace-wide diagnostics (all files in project).

View with: `<leader>q` (loads into quickfix list)
Navigate with: `[d` / `]d` (previous/next)

## TypeScript/JavaScript Notes

The default is `tsserver`, but consider:
- **denols**: Faster, more standards-compliant Deno LSP
- **eslint**: Run eslint as LSP for linting
- **prettier**: Use format-on-save instead of LSP formatting

## Python Notes

**pyright** is recommended over pylsp:
- Faster
- Better type checking
- More accurate completions

Requires: `pip install pyright` or `npm install -g pyright`

## Go Notes

**gopls** is the official Go LSP:
- Required by Mason for Go support
- Includes formatting (gofmt)
- Runs all tests on file save (can be slow)

Disable test running:
```lua
require('lspconfig').gopls.setup({
  on_init = function(client)
    if not client.server_capabilities.semanticTokensProvider then
      client.server_capabilities.semanticTokensProvider = {
        legend = {
          tokenTypes = {},
          tokenModifiers = {},
        },
        range = true,
      }
    end
  end,
  settings = {
    gopls = {
      tests = false,  -- Don't run tests on every save
    }
  }
})
```

## Rust Notes

**rust-analyzer** (via Mason) + Cargo provide:
- Completion and diagnostics
- Inline type hints
- Macro expansion

Config example:
```lua
require('lspconfig').rust_analyzer.setup({
  settings = {
    ['rust-analyzer'] = {
      checkOnSave = {
        command = 'clippy',  -- Use clippy for lints
      }
    }
  }
})
```

## Language Detection

LSP servers attach based on `filetype`. Ensure your files have correct extensions:
- `.lua` → lua_ls
- `.py` → pyright
- `.go` → gopls
- `.rs` → rust_analyzer
- `.ts`/`.tsx`/`.js` → tsserver

If a filetype isn't recognized, manually set: `:set filetype=python`

## Advanced: Custom Configuration Per File

Some servers support per-project configuration:

**Go** (gopls): `.golangci.yml`, `go.mod`
**Rust**: `Cargo.toml`, `.rustfmt.toml`
**Python**: `pyproject.toml`, `setup.cfg`, `.pylintrc`
**TypeScript**: `tsconfig.json`, `prettier.config.js`

LSP servers automatically discover and use these files.

## Resources

- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- [Neovim LSP Docs](https://neovim.io/doc/user/lsp.html)
- [List of Servers](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md)
