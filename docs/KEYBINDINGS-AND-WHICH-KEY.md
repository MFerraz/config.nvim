# Keybindings and Which-Key Configuration

## Overview

This configuration uses organized, mnemonic keybindings with which-key for discoverability. The leader key is `<Space>`.

**File**: `lua/config/keymaps.lua` and `lua/plugins/editor/which-key.lua`

## Which-Key Integration

### What is Which-Key?

When you press `<leader>` (spacebar), which-key displays a menu showing all available commands after a short timeout (1 second). This helps discover keybindings without memorizing everything.

**Try it**: Press `<Space>` in normal mode and wait ~1 second. You'll see all available commands.

### Custom Keybinding Groups

Keybindings are organized into logical groups:
- `<leader>s` - Search commands
- `<leader>g` - Git commands
- `<leader>b` - Buffer commands
- `<leader>h` - Git hunk commands
- `<leader>c` - Merge conflict commands (nested under `<leader>g`)

Each group shows a descriptive label in which-key.

## Complete Keybinding Reference

### Navigation & Search (`<leader>s`)

| Binding | Action | Notes |
|---------|--------|-------|
| `<leader>sf` | Find files | Fuzzy search all files |
| `<leader>sg` | Live grep | Search file contents |
| `<leader>/` | Buffer search | Fuzzy search current buffer |
| `<leader>sh` | Search help | Find help tags |
| `<leader>sw` | Search word | Find word under cursor |
| `<leader>sd` | Search diagnostics | Find all LSP diagnostics |
| `<leader>sr` | Resume search | Resume last telescope search |
| `<leader>?` | Recent files | Find recently opened files |
| `<leader><space>` | Open buffers | Find open buffers |
| `<leader>gf` | Git files | Search git files only |

**How they work**:
- Most use Telescope (fuzzy finder)
- Live grep (`<leader>sg`) searches in real-time as you type
- Buffer search (`<leader>/`) searches only current file

### LSP & Code Navigation (No Leader)

| Binding | Action | Context |
|---------|--------|---------|
| `gd` | Go to definition | Jump to function/class definition |
| `gr` | Go to references | Find all usages |
| `gI` | Go to implementation | Jump to implementation |
| `gD` | Go to declaration | Jump to declaration |
| `K` | Hover | Show documentation popup |
| `<leader>D` | Type definition | Jump to type definition |
| `<leader>rn` | Rename | Rename symbol (LSP) |
| `<leader>ca` | Code actions | LSP quick fixes |
| `<leader>K` | Signature help | Show function signature |
| `<leader>ws` | Workspace symbols | Search project-wide symbols |

**Tips**:
- `gd` is the most used - jump to definition instantly
- `gr` + telescope allows searching across entire project
- `K` shows docstrings/type info without leaving editor
- Code actions often include imports, fixes, refactoring

### Git Integration (`<leader>g`)

**File Explorer & History**:
| Binding | Action |
|---------|--------|
| `<leader>gs` | Git file explorer (Neotree with git status) |
| `<leader>gl` | Git log browser (Flog tree view) |

**Merge Conflicts** (`<leader>gc`):
| Binding | Action | Use Case |
|---------|--------|----------|
| `<leader>gco` | Choose ours | Keep your version |
| `<leader>gct` | Choose theirs | Accept their version |
| `<leader>gcb` | Choose both | Keep both versions |
| `<leader>gcq` | Quick fix list | List all conflicts |

**Examples**:
- During merge: `<leader>gco` on a conflict keeps your code
- View all conflicts: `<leader>gcq` and navigate with `]c` / `[c`
- Full git commands via `:Git` (vim-fugitive)

### Git Hunks (`<leader>h`)

| Binding | Action | Stage-Preview Workflow |
|---------|--------|------------------------|
| `[c` | Previous hunk | Move up to previous change |
| `]c` | Next hunk | Move down to next change |
| `<leader>hp` | Preview hunk | Show diff of change |
| `<leader>hs` | Stage hunk | Add hunk to git (in gitsigns) |
| `<leader>hu` | Undo hunk | Revert hunk (in gitsigns) |

**Workflow**: Navigate with `[c`/`]c`, preview with `<leader>hp`, then decide to stage/undo

### Buffer Management (`<leader>b`)

| Binding | Action |
|---------|--------|
| `<leader>bd` | Delete buffer |
| `<leader>bn` | Next buffer |
| `<leader>bp` | Previous buffer (mapped in keymaps) |
| `<leader><space>` | Find buffer | (Also under search group) |

**Navigation Flow**: Use `<leader><space>` to quickly switch between buffers

### Diagnostics

| Binding | Action |
|---------|--------|
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |
| `<leader>e` | Show diagnostic | Floating window at cursor |
| `<leader>q` | List diagnostics | Quickfix list of all |

**Workflow**: Navigate with `[d`/`]d`, view with `<leader>e`, fix issues

### File Management

| Binding | Action |
|---------|--------|
| `-` | Open parent directory (Oil) |
| `<leader>v` | Neotree file explorer |

**Oil.nvim** (`-`):
- Opens parent directory as editable buffer
- Treats directory like a file you can edit
- Press `-` again to open parent directory's parent

### Formatting & Comments

| Binding | Action |
|---------|--------|
| `<leader>f` | Format buffer | LSP-based formatting |
| `gcc` | Toggle comment | Comment single line |
| `gc` + motion | Toggle comment | Comment selection |

**Comment Examples**:
- `gcc` - Toggle comment on current line
- `gc2j` - Toggle comment on next 2 lines
- `gcw` - Toggle comment on word
- `gci{` - Toggle comment inside braces

### Movement & Editing

| Binding | Action | Purpose |
|---------|--------|---------|
| `<C-d>` | Page down, center | Scroll and keep cursor centered |
| `<C-u>` | Page up, center | Scroll and keep cursor centered |
| `n` | Next match, center | Search navigation, centered |
| `N` | Previous match, center | Search navigation, centered |
| `J` | Move line down (V-mode) | Shift line down in visual |
| `K` | Move line up (V-mode) | Shift line up in visual |

**Design principle**: Common movements center the cursor for readability

### Register & Clipboard

| Binding | Action | Notes |
|---------|--------|-------|
| `<leader>y` | Yank to clipboard | Copy to system clipboard |
| `<leader>Y` | Yank line to clipboard | Full line to system clipboard |
| `<leader>d` | Delete to void | Delete without affecting registers |
| `<leader>p` | Paste without overwrite | Paste and keep register |

**Workflow**: Use `<leader>y` to copy to system (outside Neovim), `<leader>p` to paste and keep your yank buffer intact

### Quickfix & Location Lists

| Binding | Action |
|---------|--------|
| `<C-j>` | Next quickfix item |
| `<C-k>` | Previous quickfix item |
| `<leader>j` | Next location list |
| `<leader>k` | Previous location list |

**Use cases**:
- Quickfix: LSP diagnostics, grep results, build errors
- Location list: Navigation within buffer

### Tmux Integration

| Binding | Action |
|---------|--------|
| `<C-f>` | Open tmux-sessionizer |

Uses external tmux-sessionizer script to switch tmux sessions.

## Adding Custom Keybindings

### In `lua/config/keymaps.lua`

```lua
-- Simple mapping
vim.keymap.set('n', '<leader>xx', function()
  print("Hello!")
end, { noremap = true, silent = true })

-- With description (shows in which-key)
vim.keymap.set('n', '<leader>xx', ':Telescope builtin<CR>', {
  noremap = true,
  silent = true,
  desc = 'Telescope builtin'
})
```

### With Which-Key Group

Edit `lua/plugins/editor/which-key.lua`:

```lua
['<leader>x'] = { name = '+example', }
['<leader>xx'] = { '<Cmd>MyCommand<CR>', 'My description' }
```

## Keymap Mode Prefixes

- `n` - Normal mode
- `i` - Insert mode
- `v` - Visual mode
- `c` - Command-line mode
- `t` - Terminal mode
- `x` - Visual and select mode

## Common Keybinding Patterns

### Mnemonic Groups

The bindings follow Vi tradition with mnemonics:
- `<leader>s` = Search
- `<leader>g` = Git
- `<leader>b` = Buffer
- `<leader>h` = Hunk
- `<leader>d` = Delete/Diagnostics
- `<leader>c` = Conflict
- `<leader>f` = Format
- `<leader>w` = Workspace
- `<leader>r` = Rename/References

### Nested Keybindings

Multi-part keybindings use nested groups:
- `<leader>gc` + `o/t/b/q` for merge conflicts
- `<leader>g` + `s/l/c` for git operations

### No-Leader Bindings

Some bindings don't use leader (traditional Vim):
- `gd`, `gr`, `gI` - LSP navigation (Vi tradition)
- `[d`, `]d` - Diagnostic navigation
- `[c`, `]c` - Hunk navigation
- `K` - Hover (Vim standard)
- `gcc` - Comment (Vi tradition)
- `-` - File explorer (Vim tradition)

## Performance Tips

- Keybindings are loaded on startup
- Lazy-loaded plugins add their keybindings when loaded
- Which-key builds the menu dynamically (fast)
- Use `vim.keymap.set` instead of `vim.api.nvim_set_keymap` (cleaner)

## Debugging Keybindings

Check if a keybinding is mapped:
```vim
:verbose map <leader>f
```

Shows which file and line defined the mapping.

## Conflicting Keybindings

If a keybinding doesn't work:
1. Check for conflicts: `:verbose map <your-binding>`
2. Verify the mode (n/i/v) is correct
3. Check if plugin is loaded: `:Lazy`
4. LSP keybindings only work with `on_attach` in a buffer

## Resources

- [Which-Key.nvim](https://github.com/folke/which-key.nvim)
- [Vim Keybindings Cheatsheet](https://vim.rtorr.com/)
- [Neovim Keymaps Documentation](https://neovim.io/doc/user/map.html)
