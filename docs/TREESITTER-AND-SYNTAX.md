# Treesitter: Syntax Highlighting & Code Navigation

## Overview

Treesitter provides modern, incremental syntax highlighting and powerful code navigation through abstract syntax trees (ASTs).

**File**: `lua/plugins/core/treesitter.lua`

**Plugin**: nvim-treesitter + nvim-treesitter-textobjects

## What is Treesitter?

A parsing library that:
- Builds abstract syntax trees (ASTs) for code
- Provides precise syntax highlighting
- Enables text objects (functions, classes, etc.)
- Powers incremental updates (fast)
- Supports context-aware navigation

Traditional regex-based syntax (in vim) is limited and slow on large files. Treesitter is more powerful.

## Installed Languages

Current configuration includes parsers for:
- Go
- Lua
- Python
- TSX (React)
- Svelte
- JavaScript
- TypeScript
- Vimdoc
- Vim

## Installing Parsers

### Via Mason

```vim
:Mason
```

Search for the language parser (e.g., "python-lsp") and install.

### Via Treesitter

```vim
:TSInstall python
:TSInstall rust
:TSInstall javascript
```

### Install Multiple

```vim
:TSInstall python rust javascript typescript
```

### Update All

```vim
:TSUpdate
```

### Check Status

```vim
:TSStatus
```

Shows which parsers are installed and their versions.

## Syntax Highlighting

### Colors

Treesitter uses color scheme's highlight groups:
- `@function` → Function names
- `@variable` → Variable names
- `@keyword` → Keywords
- `@string` → String literals
- `@comment` → Comments

The gruvbox colorscheme in this config colors these appropriately.

### Highlighting Issues

If syntax looks wrong:

1. Ensure parser is installed: `:TSInstall <language>`
2. Check if file type is correct: `:set filetype?`
3. Force update: `:edit` (reload file)
4. Fallback to regex (if needed): `:set conceallevel=0`

### Disabling Highlighting

To disable Treesitter highlighting for a file type:

```vim
:set syntax=vim  " Fall back to traditional syntax
```

Or in config:
```lua
require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
    disable = function(lang, buf)
      if lang == 'typescript' then
        return true  -- Disable for TS
      end
      return false
    end,
  }
})
```

## Text Objects

Treesitter enables intelligent text objects. These are ranges of code (functions, classes, parameters) you can select and operate on.

### Function Text Objects

**Selecting functions**:

```lua
af  " Around function (includes newlines)
if  " Inside function (just the body)
```

**Example**:
```lua
function my_func(a, b)
  return a + b
end
```

- Cursor on function name
- `vaf` to select entire function (v for visual)
- `dif` to delete function body
- `yaf` to yank function

### Class Text Objects

```lua
ac  " Around class
ic  " Inside class
```

Navigate with `[[` and `]]` to jump between classes.

### Function Parameter Text Objects

```lua
aa  " Around parameter
ia  " Inside parameter
```

**Example**:
```lua
function process(name, age, email)
                 ^
```

- Cursor on `name`
- `vaa` selects entire `name` parameter
- `via` selects just the word
- `daa` deletes parameter (including comma)

## Text Object Navigation

### Jump Between Functions

| Keybinding | Action |
|------------|--------|
| `[m` | Previous function start |
| `]m` | Next function start |
| `[M` | Previous function end |
| `]M` | Next function end |

**Example workflow**:
```lua
function first() end
function second() end  ← Cursor here
function third() end

]m  ← Jump to third function
```

### Jump Between Classes

| Keybinding | Action |
|------------|--------|
| `[[` | Previous class start |
| `]]` | Next class start |
| `[C` | Previous class end |
| `]C` | Next class end |

## Text Object Combinations

### Select and Delete

- `daf` - Delete function
- `dac` - Delete class
- `daa` - Delete parameter
- `dis` - Delete statement

### Select and Copy

- `yaf` - Copy function
- `yac` - Copy class
- `yip` - Copy parameter

### Change (Delete and Insert)

- `cif` - Change inside function body
- `caa` - Change parameter

### Visual Selection

- `vaf` - Select function (visual mode)
- `vac` - Select class
- `via` - Select parameter

## Swapping Arguments

With Treesitter text objects, you can swap parameters:

```vim
<leader>a  " Swap with next argument
<leader>A  " Swap with previous argument
```

**Example**:
```lua
function process(name, age)
                        ^
                      cursor

<leader>a  ← Swap age with next parameter (if exists)
<leader>A  ← Swap age with name
```

Results in: `process(age, name)`

## Incremental Selection

Gradually expand selection:

```vim
<CR>       " Expand selection
<BS>       " Shrink selection
```

Starting from cursor:
1. First `<CR>` selects word
2. Second `<CR>` selects expression
3. Third `<CR>` selects statement
4. Fourth `<CR>` selects function, etc.

Useful for visual operations without specifying exact text objects.

## Context Information

Some plugins show context (current function/class) at top of screen. Treesitter powers this:

```
lua/config/keymaps.lua
  nvim_keymaps()
    for k, v in pairs(keybindings) do
      ← You're here
```

Helps when working in deeply nested code.

## Folding with Treesitter

Enable code folding based on syntax:

```vim
:set foldmethod=expr
:set foldexpr=nvim_treesitter#foldexpr()
```

Then use:
```vim
zo   " Open fold
zc   " Close fold
zM   " Close all folds
zR   " Open all folds
```

**Disable in this config**: Folds aren't enabled by default as they can be slow.

## Indentation

Treesitter can provide smart indentation (understands code structure):

```lua
require('nvim-treesitter.configs').setup({
  indent = { enable = true },
})
```

This makes `<` and `>` (indent) understand code blocks better.

## Parsing Performance

### Parsing Large Files

For files with 10k+ lines:
- Treesitter may be slower
- Can disable highlighting: `:set syntax=vim`
- Or disable specific features

### Background Parsing

Treesitter parses incrementally:
- Updates happen in background
- Won't block typing
- Fast on modern systems

### Memory Usage

Syntax trees take memory:
- Small files: negligible
- Large projects: 50-100MB typical
- Can disable for huge files

## Parser Conflicts

If traditional regex syntax conflicts with Treesitter:

Priority order (highest to lowest):
1. Treesitter highlights (if enabled)
2. Regex highlights
3. Manual syntax definitions

To prefer regex for a filetype:
```lua
disable = { 'python' }  -- In treesitter config
```

## Debugging Treesitter

### Check What Syntax is Applied

```vim
:Inspect
```

Shows the highlight group under cursor and Treesitter info.

### View Syntax Tree

```vim
:InspectTree
```

Opens buffer showing the parse tree for current file. Useful for understanding how Treesitter sees your code.

### Rebuild Parser

If highlighting is broken:

```vim
:TSUninstall <language>
:TSInstall <language>
```

## Language-Specific Notes

### Python

- Smart indentation based on code blocks
- Recognizes class and function definitions
- Text objects work well

### JavaScript/TypeScript

- JSX/TSX support included
- Arrow functions recognized as text objects
- Destructuring handled well

### Go

- Interface and struct text objects
- Method definitions recognized
- Good incremental highlighting

### Rust

- Trait and impl blocks
- Complex generics handled
- Lifetime annotations highlighted

### Lua

- Configured for Neovim development
- Plugin APIs understood
- Great for configuration editing

## Common Issues

### "Parser not found" Error

1. Check parser installed: `:TSStatus`
2. Install missing parser: `:TSInstall <language>`
3. Restart Neovim if newly installed

### Syntax Looks Wrong

1. Check file type: `:set filetype?`
2. Force reload: `:e`
3. Check parser version: `:TSStatus`
4. Try fallback: `:set syntax=<language>`

### Text Objects Not Working

1. Verify parser installed for language
2. Ensure enabled in config: `enable = true`
3. Cursor must be on/in the object

### Performance Issues

1. Disable highlighting for large files automatically
2. Use `:set syntax=vim` for file
3. Check RAM usage: `:!ps aux | grep nvim`

## Advanced: Custom Queries

Treesitter uses queries to identify syntax elements. You can create custom queries for your language.

Create: `~/.config/nvim/queries/<language>/highlights.scm`

Example for custom function highlighting:

```scheme
(function_declaration name: (identifier) @function.custom)
```

Then define highlight color for `@function.custom`.

## Resources

- [Treesitter](https://tree-sitter.github.io/)
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- [Treesitter Text Objects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)
- [Query Syntax](https://tree-sitter.github.io/tree-sitter/queries)
- [Language Grammars](https://tree-sitter.github.io/tree-sitter/syntax-highlighting)

## Quick Reference

| Feature | Command/Binding |
|---------|-----------------|
| Install parser | `:TSInstall <language>` |
| Update all | `:TSUpdate` |
| Check status | `:TSStatus` |
| Inspect syntax | `:Inspect` |
| View AST | `:InspectTree` |
| Select function | `vaf` |
| Jump to function | `]m` |
| Navigate parameters | `aa` / `ia` |
| Swap arguments | `<leader>a` / `<leader>A` |
