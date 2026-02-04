# Completion and Snippets

## Overview

This configuration provides intelligent code completion powered by LSP and snippets for rapid code generation.

**Files**:
- `lua/plugins/core/completion.lua` - nvim-cmp configuration
- `lua/plugins/core/lsp.lua` - LSP integration with completion

## Completion Engine (nvim-cmp)

### What is nvim-cmp?

An autocomplete engine that:
- Pulls suggestions from multiple sources (LSP, snippets, buffers, paths)
- Filters as you type
- Shows detailed information about each suggestion
- Integrates with LSP for type information

### Triggering Completion

**Automatic**:
- Triggers on typing (after 1 character from most sources)
- After `.` for member access
- After `::` for namespaced access

**Manual**:
- `<C-x><C-o>` - Force LSP completion (vim standard)
- `<C-n>` - Next source
- `<C-p>` - Previous source (see table below)

### Completion Popup

When completion triggers, you see:

```
┌─────────────────────────────────┐
│ function_name      [Function]  │  ← Suggestion with kind
│ another_func       [Function]  │
│ my_variable        [Variable]  │
└─────────────────────────────────┘
```

### Completion Menu Navigation

| Key | Action |
|-----|--------|
| `<C-n>` | Next suggestion |
| `<C-p>` | Previous suggestion |
| `<C-b>` | Scroll docs up |
| `<C-f>` | Scroll docs down |
| `<CR>` | Confirm selection |
| `<Tab>` | Confirm or next snippet placeholder |
| `<S-Tab>` | Previous snippet placeholder |
| `<C-e>` | Close menu |

### Confirming Completions

**Standard**: Press `<CR>` to accept

**With snippets**: Press `<Tab>` to:
1. Accept completion
2. Jump to first placeholder
3. If in snippet, move to next placeholder

**Escape**: Press `<C-e>` to close without selecting

## Completion Sources

Completion draws from multiple sources, in this order:

### 1. LSP (Highest Priority)
- Function names
- Class names
- Type information
- Imported symbols
- Variable names from same scope

**Requires**: Language server running (`<leader>ca` should work)

### 2. Snippets (LuaSnip)
- Code templates
- Common patterns
- Requires trigger word

### 3. Buffer
- Words from open buffers
- Useful for variable names already typed

### 4. Path
- File paths (when typing path strings)
- Useful for imports

## LuaSnip - Snippet Engine

### What are Snippets?

Templates that expand to code, with placeholders for customization.

**Example snippet**:
```lua
function $1($2)
  $3
end
```

When you expand it, `$1` is the function name, `$2` parameters, `$3` body.

### Using Snippets

#### Trigger-based (Recommended)

Type the trigger word and press `<Tab>` or `<C-y>`:

```
Type: for
Press: <Tab>
Expands to: for i = 1, #$1 do
              $2
            end
(Cursor at $1, ready to type variable name)
```

#### Browse Snippets

No built-in browser, but you can:
1. Check installed snippets: `friendly-snippets`
2. Look at plugin docs for your language
3. Type partial word and see suggestions

### Available Snippet Languages

From `friendly-snippets` library:
- Lua
- Python
- Go
- Rust
- JavaScript/TypeScript
- C/C++
- HTML/CSS
- Markdown
- SQL
- And many more

### Creating Custom Snippets

Snippets are stored in `~/.config/nvim/snippets/` or in plugin directories.

**Creating a custom Lua snippet**:

1. Create file: `~/.config/nvim/snippets/lua.json` or `~/.config/nvim/snippets/lua.lua`

2. JSON format (recommended for beginners):

```json
{
  "function": {
    "prefix": "fn",
    "body": [
      "function ${1:name}(${2:args})",
      "  ${3:body}",
      "end"
    ],
    "description": "Create a function"
  }
}
```

3. Usage: Type `fn`, press `<Tab>`, fill in placeholders

**Variables in snippets**:
- `$1, $2, $3...` - Placeholder positions
- `${1:default}` - Placeholder with default value
- `$0` - Final cursor position
- `${TM_FILENAME}` - Current filename
- `${TM_DATE}` - Current date

### Snippet Navigation

When a snippet is active:

| Key | Action |
|-----|--------|
| `<Tab>` | Next placeholder |
| `<S-Tab>` | Previous placeholder |
| `<C-e>` | Jump out of snippet |

**Example**:
```lua
Type: fn
Press: <Tab>
Result: function |name|(args)  ← Cursor at name
Press: <Tab>
Result: function name|(args)   ← Cursor at args
Press: <Tab>
Result: function name(args)
         |body              ← Cursor at body
```

### Nested Placeholders

Snippets can have nested fields:

```
Trigger: ifn (if new)
Result:  if ${1:condition} then
           ${2:body}
         end

Cursor starts at condition
Type condition, press <Tab> to move to body
```

## Completion and Snippets Together

### Workflow

1. **Start typing** - Completion suggestions appear
2. **See snippet** - Notice trigger word with `[Snippet]` label
3. **Select snippet** - Use `<C-n>`/`<C-p>` to highlight
4. **Press `<Tab>`** - Snippet expands with placeholders
5. **Fill in placeholders** - Type and `<Tab>` through them
6. **Done** - Snippet filled, ready to continue

### Example: Python Function

```python
# Type and see completions:
def|

# Type more:
def my_func|

# Select snippet "function" from menu and press <Tab>:
def my_func($1):
    $2
    return $3

# Now filling in:
# <Tab> takes you to $1 (parameters)
def my_func(|):

# Type parameters and <Tab> again:
def my_func(x, y):
    |
    return $3
```

## LSP Snippet Integration

Some LSP servers provide snippet completions automatically:

**Example**: In TypeScript, completing `useState` might suggest:

```typescript
const [${1:state}, ${2:setState}] = useState(${3:initialValue})
```

With placeholders pre-positioned.

## Completion Sources Configuration

### Enabling/Disabling Sources

In `lua/plugins/core/completion.lua`, modify the `sources` table:

```lua
sources = cmp.config.sources({
  { name = 'nvim_lsp' },      -- LSP (always on)
  { name = 'luasnip' },       -- Snippets
  { name = 'buffer' },        -- Current buffer
  { name = 'path' },          -- File paths
})
```

To disable buffer completions:
```lua
-- { name = 'buffer' },  -- Commented out
```

### Prioritizing Sources

Order matters - sources earlier have higher priority.

To prefer snippets over LSP:
```lua
sources = cmp.config.sources({
  { name = 'luasnip' },  -- Snippets first
  { name = 'nvim_lsp' }, -- LSP second
})
```

## Advanced: Filtering Completions

### By file type

In completion.lua, before the `sources`:

```lua
if vim.bo.filetype == 'markdown' then
  sources = cmp.config.sources({
    { name = 'buffer' },
  })
else
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  })
end
```

### By completion context

Only show completions in comments:

```lua
if require('cmp.context').in_comment() then
  -- different sources
end
```

## Completion Highlighting

Completion items are color-coded by kind:

| Kind | Appearance | Source |
|------|-----------|--------|
| Function | `[Function]` | LSP |
| Variable | `[Variable]` | LSP |
| Keyword | `[Keyword]` | LSP |
| Snippet | `[Snippet]` | LuaSnip |
| Text | `[Text]` | Buffer |
| File | `[File]` | Path |

Colors based on current colorscheme (gruvbox in this config).

## Performance

### Completion Lag

If completions are slow:

1. **Check LSP server**: Some servers are slow
   ```vim
   :LspInfo
   ```

2. **Disable slow sources**:
   ```lua
   -- Comment out in completion.lua
   -- { name = 'buffer' },
   ```

3. **Increase debounce time**:
   ```lua
   completion = {
     autocomplete = {
       vim.CompletionItemInsertTextMode.AsIs,
     },
   },
   ```

### Large Buffers

For very large files (10k+ lines), completion might be slow:

```lua
-- In completion.lua, limit buffer completion:
{ name = 'buffer', option = { get_bufnrs = function()
  return { vim.api.nvim_get_current_buf() }
end } }
```

## Word Boundaries

Completion respects word boundaries:
- After `.` (member access): includes all members
- After space: starts new word
- Mid-word: filters existing word

## Snippet Placeholders (Advanced)

### Tab stops

`$1`, `$2` etc. are tab stops - where your cursor jumps.

### Default values

```
${1:default_value}  ← Placeholder with default
```

If you just press `<Tab>`, default is used. Type to override.

### Variable interpolation

```
${1:function_name}(${2:args}) {
  // TODO: Implement ${1}
}
```

`${1}` is mirrored - typing in first placeholder auto-fills here.

### Transformations

```
${1/(.*)/${1:/upcase}/}  ← Transform first placeholder to uppercase
```

Advanced feature for complex templates.

## Troubleshooting

### Completions not appearing

1. Check LSP is running: `:LspInfo`
2. Verify file type: `:set filetype?`
3. Manual trigger: `<C-x><C-o>`

### Snippets not expanding

1. Ensure LuaSnip is loaded: `:Lazy`
2. Check trigger word is correct
3. Try `<C-y>` to confirm instead of `<Tab>`

### Completion too aggressive

In `lua/plugins/core/completion.lua`:
```lua
vim.opt.pumheight = 10  -- Limit menu height
```

Or disable auto-trigger:
```lua
autocomplete = false
```

Then manually trigger with `<C-x><C-o>`.

### Snippets overlapping with autocomplete

If completions interfere with snippets:
```lua
-- In completion.lua, map <Tab> differently:
mapping = cmp.mapping.preset.insert({
  ['<Tab>'] = cmp.mapping.select_next_item(),
  ['<S-Tab>'] = cmp.mapping.select_prev_item(),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
})
```

Then use `<C-y>` to confirm instead of `<Tab>`.

## Resources

- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- [LuaSnip](https://github.com/L3MON4D3/LuaSnip)
- [friendly-snippets](https://github.com/rafamadriz/friendly-snippets)
- [Snippet Syntax Reference](https://code.visualstudio.com/docs/editor/userdefinedsnippets)
