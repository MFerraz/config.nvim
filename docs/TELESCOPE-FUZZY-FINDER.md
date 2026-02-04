# Telescope: Fuzzy Finding & Search

## Overview

Telescope is a powerful fuzzy finder for searching files, content, and project symbols. It's optimized with native FZF for speed.

**File**: `lua/plugins/core/telescope.lua`

**Plugin**: telescope.nvim + telescope-fzf-native

## What is Telescope?

A fuzzy finder that:
- Searches files, buffers, text, symbols, and more
- Filters results as you type
- Shows preview of files/diffs
- Integrates with LSP and git
- Fast native FZF implementation

## Common Telescope Searches

### File Search

**Keybinding**: `<leader>sf`

Finds files in project:
```
search >|
telescope.nvim
  lua/...
  docs/...
  README.md
  ...
```

- Type to filter by filename
- `<C-j>/<C-k>` to select
- `<CR>` to open in editor
- `<C-x>` to open in split
- `<C-v>` to open in vsplit
- `<C-t>` to open in new tab

### Live Grep

**Keybinding**: `<leader>sg`

Searches file contents in real-time:
```
search >|
file_with_pattern.lua:42: function example()
another_file.lua:156: local example = ...
```

- Type search pattern
- Results update live as you type
- Shows line number and context
- Preview shows matching lines highlighted

### Fuzzy Search Current Buffer

**Keybinding**: `<leader>/`

Search only in current file:
- Useful for large files
- Lists all matching lines
- Preview shows context

### Search Open Buffers

**Keybinding**: `<leader><space>`

Switch between open files:
```
search >|
README.md
keymaps.lua
completion.lua
  ...
```

Type filename to filter, `<CR>` to switch.

### Search Word Under Cursor

**Keybinding**: `<leader>sw`

Grep for the word at cursor:
- Useful for finding variable usage
- Pre-fills search with selected word
- Searches across entire project

### Recent Files

**Keybinding**: `<leader>?`

List recently opened files:
- Quickly jump back to file you were working on
- Useful with projects you work on regularly

## Telescope with LSP

### Search Diagnostics

**Keybinding**: `<leader>sd`

Lists all LSP diagnostics (errors/warnings):
```
search >|
lua/config/init.lua:45: undefined variable x
lua/plugins/ui/statusline.lua:12: unused variable
...
```

- Shows file, line, and error message
- Jump to any error
- Press `<CR>` to go to location

### Go to References

**Keybinding**: `gr`

Find all references to symbol under cursor:
```
search >|
file1.lua:42: my_function()
file2.lua:156: my_function()
...
```

- Shows every place a function/variable is used
- Context lines shown in preview
- Jump to any reference

### Workspace Symbols

**Keybinding**: `<leader>ws`

Search symbols project-wide:
- Functions, classes, methods
- Type "function_name" to filter
- Jump to definition anywhere in project

### Document Symbols

Search symbols in current file (can add):
```lua
vim.keymap.set('n', '<leader>ss', telescope.builtin.lsp_document_symbols)
```

## Telescope with Git

### Git Files

**Keybinding**: `<leader>gf`

Search only tracked git files:
- Ignores `.gitignore` entries
- Faster than searching all files
- Useful in large repos with build artifacts

### Git Status

**Keybinding**: `<leader>gs`

Lists changed files with git status:
- Shows M (modified), A (added), D (deleted)
- Quick access to changed files
- Good for reviewing changes before committing

## Telescope Navigation

### In Results Window

| Key | Action |
|-----|--------|
| `<C-j>` / `<Down>` | Next result |
| `<C-k>` / `<Up>` | Previous result |
| `<C-n>` | Next in history |
| `<C-p>` | Previous in history |
| `<C-a>` | Toggle all (select multiple) |
| `<C-d>` | Delete selected (some pickers) |
| `<CR>` | Open selection |
| `<C-x>` | Open in horizontal split |
| `<C-v>` | Open in vertical split |
| `<C-t>` | Open in new tab |
| `<C-l>` | Send to quickfix |
| `?` | Show help |
| `<Esc>` | Exit |

### In Preview Window

| Key | Action |
|-----|--------|
| `<C-b>` | Scroll up |
| `<C-f>` | Scroll down |

## Advanced Telescope Features

### Multi-select

In most pickers, select multiple results:

1. Use `<C-a>` to toggle all
2. Or use `<Tab>` to select individual items
3. Press `<CR>` to open all selections

Useful for opening multiple files at once.

### Send to Quickfix

After searching, press `<C-l>` to send results to quickfix list:
- Navigate with `[c` / `]c`
- Useful for review/batch operations
- Integrates with LSP diagnostics

### Resume Last Search

**Keybinding**: `<leader>sr`

Re-opens the last Telescope search:
- Keep same filters and position
- Useful if you accidentally closed it
- Shows same results as before

## Telescope Help

**Keybinding**: `<leader>sh`

Search Neovim help documentation:
- Type to filter help topics
- Preview shows help text
- Press `<CR>` to open help page

## Customizing Telescope

### Search Patterns

Telescope uses regex for searching. Common patterns:

| Pattern | Matches |
|---------|---------|
| `foo` | Literal "foo" |
| `foo.*bar` | "foo" followed by "bar" |
| `^foo` | "foo" at start of line |
| `foo$` | "foo" at end of line |
| `[abc]` | a, b, or c |
| `foo\|bar` | "foo" or "bar" |

### Case Sensitivity

By default case-insensitive. Force case-sensitive:
- Prefix search with `'` (single quote)
- Example: `'MyFunction` searches case-sensitively

### Regex Mode

Enable advanced patterns:
- Prefix with `#` (hash)
- Example: `#^function.*end$` matches functions

## Telescope with Ripgrep

This config uses `telescope-fzf-native` which provides:
- Fast filtering via native FZF
- Better performance on large projects
- Requires: `ripgrep` (rg) installed

**Ripgrep syntax** (for live grep):

```
Common ripgrep flags:
-i              Ignore case
-w              Whole word match
-F              Literal string (no regex)
--type lua      Search only Lua files
--glob "*.js"   Search only JS files
```

Example: `<leader>sg` then type: `-i myfunction`

## Performance Tips

### Large Repositories

For projects with 10k+ files:

1. **Use git files**: `<leader>gf` (only tracked files)
2. **Limit by type**: In live grep, type: `--type lua`
3. **Ignore directories**:
   ```lua
   -- In telescope.lua config:
   vimgrep_arguments = {
     "rg",
     "--color=never",
     "--no-heading",
     "--with-filename",
     "--line-number",
     "--column",
     "--smart-case",
     "--glob=!node_modules",
     "--glob=!.git",
   },
   ```

### Exclude Patterns

Ripgrep respects `.gitignore`, but you can add more:

In project root, create `.rgignore`:
```
node_modules
.git
build/
dist/
*.o
```

Telescope will use these patterns automatically.

## Telescope Shortcuts

### Common Workflows

**Find and replace**:
1. `<leader>sg` - Live grep
2. Type search term
3. `<C-l>` - Send to quickfix
4. Use vim-qf plugin or manual `:cdo s/old/new/g`

**Open recently used file**:
1. `<leader>?` - Recent files
2. Type filename
3. `<CR>` - Open

**Jump to error**:
1. `<leader>sd` - Diagnostics
2. Navigate
3. `<CR>` - Jump

**Find all usages of function**:
1. Place cursor on function name
2. `gr` - Go to references
3. Navigate list
4. `<CR>` - Jump

## Troubleshooting

### Telescope slow with large files

1. Check ripgrep is installed: `rg --version`
2. Reduce result count in config
3. Use `--type` to filter results

### Results not showing

1. Ensure ripgrep is installed
2. Check current directory: `:pwd`
3. Verify file is not ignored by `.gitignore`

### Keybindings not working

Check if mapped:
```vim
:verbose map <leader>sf
```

### Preview not showing

Some files have preview disabled:
- Binary files
- Very large files
- Unsupported file types

### Selection not working in split

Different pickers have different behaviors:
- `<C-x>` for horizontal split
- `<C-v>` for vertical split
- `<C-t>` for new tab

## Advanced: Creating Custom Pickers

Create custom telescope searches by extending `lua/plugins/core/telescope.lua`:

```lua
local builtin = require('telescope.builtin')
local extensions = require('telescope').extensions

-- Custom picker for project todos
vim.keymap.set('n', '<leader>st', function()
  builtin.grep_string({ search = 'TODO|FIXME|BUG', use_regex = true })
end, { noremap = true })
```

This creates a new `<leader>st` keybinding to find all TODOs.

## Telescope vs Other Finders

### vim-fzf

Simpler but less integrated:
- Works without plugins
- Fewer integrations
- Good for simple file finding

### CtrlP

Older style file finder:
- Less powerful
- Slower on large projects
- Replaced by telescope in modern configs

### fzf.vim

Standalone fzf wrapper:
- Requires system fzf
- Simpler but less features
- Telescope is more Neovim-native

## Resources

- [Telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- [Telescope-fzf-native](https://github.com/nvim-telescope/telescope-fzf-native.nvim)
- [Ripgrep](https://github.com/BurntSushi/ripgrep)
- [FZF](https://github.com/junegunn/fzf)
- [Regex Guide](https://www.regular-expressions.info/)
