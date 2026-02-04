# Markdown Rendering (render-markdown.nvim)

## Overview

This configuration includes `render-markdown.nvim`, a plugin that renders markdown files beautifully in Neovim with enhanced visual formatting.

**File**: `lua/plugins/ui/markdown.lua`

**Plugin**: render-markdown.nvim by MeanderingProgrammer

## What It Does

Renders markdown with enhanced formatting:
- **Headers**: Different colors and sizes for H1-H6
- **Code blocks**: Syntax highlighting with language detection
- **Lists**: Visual bullet points and indentation
- **Bold/Italic**: Text styling (bold, italic)
- **Links**: Clickable link rendering
- **Tables**: Formatted table display
- **Blockquotes**: Indented and colored quotes
- **Checkboxes**: Styled todo lists
- **Horizontal rules**: Visual dividers

## Key Features

### Visual Enhancements

**Headers**:
```markdown
# H1 - Large, primary color
## H2 - Medium, secondary color
### H3 - Smaller
```
Each header level has distinct styling for quick scanning.

**Code Blocks**:
```markdown
\`\`\`python
def hello():
    print("Syntax highlighted!")
\`\`\`
```
Language-specific syntax highlighting with background.

**Bold & Italic**:
```markdown
**bold text** - Rendered as bold
*italic text* - Rendered as italic
***bold italic***
```

**Lists**:
```markdown
- Item 1
- Item 2
  - Nested item
    - Deeper nested
```
Visual bullets with indentation indicators.

**Todo Lists**:
```markdown
- [x] Completed task
- [ ] Incomplete task
```
Checkboxes rendered with different styling.

**Tables**:
```markdown
| Header 1 | Header 2 |
|----------|----------|
| Cell 1   | Cell 2   |
```
Formatted with borders and alignment.

**Links**:
```markdown
[Link text](https://example.com)
```
Styled differently from regular text.

**Blockquotes**:
```markdown
> This is a quote
> It's indented and styled
```
Visual indentation and color.

## Configuration

Currently using default configuration:

```lua
return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
  opts = {},  -- Default settings
}
```

### Customizing Settings

To customize render-markdown, edit `opts`:

```lua
opts = {
  -- Render mode (e.g., 'markdown', 'latex')
  render_modes = { 'markdown' },

  -- File types to enable rendering
  file_types = { 'markdown' },

  -- Heading styles
  heading = {
    enabled = true,
    sign = false,  -- Don't show signs in gutter
  },

  -- Code blocks
  code = {
    enabled = true,
    sign = false,
    style = 'full',  -- 'full' or 'language'
    left_pad = 0,
  },

  -- Bullet lists
  bullet = {
    enabled = true,
  },

  -- Checkboxes
  checkbox = {
    enabled = true,
  },

  -- Horizontal rules
  hr = {
    enabled = true,
  },

  -- Links
  link = {
    enabled = true,
  },

  -- Tables
  table = {
    enabled = true,
  },
}
```

## Usage

### Automatic

- Open any `.md` file
- Markdown rendering is automatically applied
- Works seamlessly with editing

### Viewing Rendered Output

Just open the file:
```vim
:e README.md
```

Rendering applies automatically. Still fully editable.

### Toggling Rendering

Enable/disable rendering:
```vim
:RenderMarkdownToggle
```

Useful if you want to see raw markdown syntax.

## Keyboard Shortcuts

The plugin adds useful commands:

| Command | Action |
|---------|--------|
| `:RenderMarkdownToggle` | Toggle rendering on/off |
| `:RenderMarkdownReload` | Reload rendering |

Add keybindings in `lua/config/keymaps.lua`:

```lua
-- Toggle markdown rendering
vim.keymap.set('n', '<leader>tm', ':RenderMarkdownToggle<CR>', {
  noremap = true,
  silent = true,
  desc = 'Toggle markdown rendering'
})
```

## File Types Supported

By default, renders `.md` files. To enable for other formats:

```lua
opts = {
  file_types = { 'markdown', 'vimwiki', 'rmd' },  -- Add more types
}
```

## Integration with Other Plugins

### Works Well With

- **Treesitter**: Syntax highlighting for code blocks
- **nvim-web-devicons**: Icons in tables and lists
- **Telescope**: Search within markdown files
- **Oil.nvim**: Browse markdown files
- **Git**: View markdown in git diffs

### No Conflicts

Render-markdown doesn't conflict with:
- LSP (works on markdown files)
- Gitsigns (compatible with git status in gutter)
- Other UI plugins
- Editing functionality

## Use Cases

### Documentation Files

```markdown
# My Project

Rendering makes docs easier to read:
- **Bold** sections stand out
- Code blocks are highlighted
- Tables are formatted
```

### Markdown Notes

Quick note-taking with visual hierarchy:
```markdown
## Personal Notes

- [ ] Task 1
- [x] Task 2 (done)

### Project Ideas

> Great idea that came up
```

### README Files

Repository READMEs render beautifully:
```markdown
# Project Name

Large header, clear formatting, tables show nicely.
```

### Blog Posts

Writing markdown for blog platform:
```markdown
# Article Title

Paragraph formatting looks good.

## Section

Content is well-organized.
```

### Configuration Comments

Even markdown in code comments can be rendered (if enabled for that filetype).

## Performance

- **Lightweight**: Minimal performance impact
- **Lazy**: Only renders when needed
- **Smart**: Disables on large files (via bigfile)
- **Caching**: Efficient re-rendering

## Troubleshooting

### Rendering Not Showing

1. Ensure file has `.md` extension
2. Check file type: `:set filetype?` (should be `markdown`)
3. Try reload: `:RenderMarkdownReload`
4. Verify Treesitter parser installed: `:TSInstall markdown`

### Text Looks Wrong

- Rendering may be obscuring syntax
- Toggle off: `:RenderMarkdownToggle`
- Check if raw text is correct

### Performance Issues on Large Files

- Bigfile plugin auto-disables rendering for 10k+ line files
- Or manually: `:RenderMarkdownToggle`

### Checkbox Icons Not Showing

- Requires web-devicons
- Check installation: `:Lazy`
- Ensure file is markdown type

## Advanced Features

### Custom Colors

Customize colors by modifying highlight groups:

```lua
-- In lua/config/init.lua or custom file
vim.api.nvim_set_hl(0, '@markup.heading.1.markdown', { fg = '#ff6b6b' })
vim.api.nvim_set_hl(0, '@markup.heading.2.markdown', { fg = '#4ecdc4' })
```

Uses your colorscheme (gruvbox in this config).

### Render Specific Sections

Full rendering by default. To customize per-section:

```lua
opts = {
  heading = { enabled = true },
  code = { enabled = true },
  bullet = { enabled = true },
  checkbox = { enabled = true },
  -- Disable specific ones:
  -- table = { enabled = false },
}
```

### Language-Specific Code Block Styling

Code blocks use Treesitter for language highlighting:
- Python blocks highlighted as Python
- Lua blocks highlighted as Lua
- Bash blocks highlighted as Bash
- etc.

Automatic based on code fence language specifier.

## Editing Markdown

### While Rendering is Enabled

- You can still edit normally
- Rendering updates as you type
- No special editing mode needed

### Quick Edit Tips

1. Insert code block:
   ```markdown
   \`\`\`<language>
   code here
   \`\`\`
   ```

2. Insert table:
   ```markdown
   | Col1 | Col2 |
   |------|------|
   | A    | B    |
   ```

3. Create list:
   ```markdown
   - Item 1
   - Item 2
   - Item 3
   ```

## Integration with This Config

### Works With Your Setup

- ✅ Treesitter: Already installed
- ✅ nvim-web-devicons: Already installed
- ✅ No conflicts with other plugins
- ✅ Complements telescope for searching markdown

### Suggested Workflow

1. Open markdown file: `:e file.md`
2. Rendering auto-applies
3. View formatted output
4. Edit normally
5. Toggle if needed: `:RenderMarkdownToggle`

## Commands Reference

| Command | Effect |
|---------|--------|
| `:RenderMarkdownToggle` | Toggle rendering on/off |
| `:RenderMarkdownReload` | Reload rendering |

## Keyboard Mapping Example

Add to `lua/config/keymaps.lua`:

```lua
-- Markdown rendering toggle
vim.keymap.set('n', '<leader>md', ':RenderMarkdownToggle<CR>', {
  noremap = true,
  silent = true,
  desc = 'Toggle markdown rendering'
})
```

Then use `<leader>md` to toggle.

## Tips

1. **Large Documents**: Use `<leader>/` (telescope) to search within markdown
2. **Table Editing**: Numbers column helps align table content
3. **Code Blocks**: Syntax highlighting shows errors in code examples
4. **Navigation**: Treesitter text objects (af, ac) work in markdown too
5. **Copying Code**: Select and copy rendered code normally

## Resources

- [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim)
- [Markdown Syntax](https://www.markdownguide.org/)
- [Neovim Markdown Guide](https://neovim.io/doc/user/treesitter.html)

## Summary

**render-markdown.nvim** provides beautiful markdown rendering in Neovim:
- ✅ Auto-applies to `.md` files
- ✅ Syntax highlighting in code blocks
- ✅ Visual styling for headers, lists, tables
- ✅ Fully editable while rendering
- ✅ Toggle on/off as needed
- ✅ Zero performance impact on non-markdown files
- ✅ Integrates seamlessly with your config

No special setup needed - it works out of the box!
