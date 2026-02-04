# Extending and Customizing the Configuration

## Overview

This configuration is designed to be modular and easy to customize. This guide covers how to extend it without breaking the core setup.

## Project Structure Review

```
lua/
├── config/              # Core configuration
│   ├── init.lua        # Settings (options, colors, etc.)
│   ├── keymaps.lua     # All keybindings
│   ├── autocmds.lua    # Autocommands (hooks)
│   └── lazy.lua        # lazy.nvim setup
├── plugins/            # Plugin specs (lazy-loaded)
│   ├── init.lua        # Plugin loader
│   ├── ai/             # AI plugins
│   ├── core/           # Essential features
│   ├── ui/             # UI enhancements
│   ├── git/            # Git integration
│   ├── editor/         # Editor tools
│   └── optional/       # Toggleable features
└── utils/              # Helper functions
    └── helpers.lua
```

## Adding Plugins

### Method 1: Create New Plugin File

For a new plugin, create a file in `lua/plugins/`:

```lua
-- lua/plugins/custom/my-plugin.lua
return {
  "author/my-plugin",
  event = "VeryLazy",  -- When to load
  config = function()
    require("my-plugin").setup({
      option1 = true,
      option2 = "value",
    })
  end,
  keys = {  -- Optional: keybindings
    { "<leader>x", function() require("my-plugin").action() end, desc = "My plugin action" }
  },
  dependencies = {
    "dependency/plugin",  -- If needed
  }
}
```

The plugin auto-loads via lazy.nvim.

### Method 2: Add to Existing Plugin File

For related plugins, add to existing category:

```lua
-- lua/plugins/editor/my-tool.lua
return {
  "author/plugin1",
  -- config...
}
```

Then import in `lua/plugins/init.lua`:

```lua
-- Add to file list or create new import
local function plugins()
  return {
    require('plugins.editor.my-tool'),
  }
end
```

### Plugin Loading Events

Plugins can load at different times for performance:

| Event | When | Use Case |
|-------|------|----------|
| `VeryLazy` | After startup | Non-essential plugins |
| `LazyFile` | On file open | File-dependent plugins |
| `BufRead` | On buffer read | Editor plugins |
| `InsertEnter` | On insert mode | Insert mode plugins |
| `CmdlineEnter` | On command mode | Command mode plugins |
| `VimEnter` | After init | Always-on plugins |

```lua
return {
  "author/plugin",
  event = "VeryLazy",  -- Loads after UI is ready
}
```

## Customizing Settings

### Global Options

Edit `lua/config/init.lua`:

```lua
-- Set tab width
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
```

### Colorscheme

Change colorscheme in `lua/config/init.lua`:

```lua
-- Current
vim.cmd.colorscheme('gruvbox')

-- Alternatives
vim.cmd.colorscheme('tokyonight')
vim.cmd.colorscheme('nord')
```

Or add new colorscheme plugin:

```lua
-- lua/plugins/ui/colorscheme.lua (new file)
return {
  "folke/tokyonight.nvim",
  config = function()
    vim.cmd.colorscheme('tokyonight-moon')
  end,
}
```

### Statusline Customization

Edit `lua/plugins/ui/statusline.lua` to customize lualine:

```lua
require('lualine').setup({
  options = {
    theme = 'gruvbox',
    icons_enabled = true,
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff' },
    lualine_c = { 'filename' },
  },
})
```

## Adding Keybindings

### Simple Keybinding

Edit `lua/config/keymaps.lua`:

```lua
vim.keymap.set('n', '<leader>xx', function()
  print("Hello!")
end, { noremap = true, silent = true, desc = 'Say hello' })
```

### With Which-Key Group

Edit `lua/plugins/editor/which-key.lua`:

```lua
-- Add group
['<leader>x'] = { name = '+example' }

-- Add binding
['<leader>xx'] = { '<Cmd>MyCommand<CR>', 'My command' }
```

### Plugin Keybinding

In plugin spec, use `keys`:

```lua
return {
  "author/plugin",
  keys = {
    { "<leader>ap", function() require("plugin").action() end, desc = "Plugin action" },
  },
}
```

## Customizing Plugins

### LSP Configuration

Add servers in `lua/plugins/core/lsp.lua`:

```lua
require('lspconfig').rust_analyzer.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    ['rust-analyzer'] = {
      checkOnSave = { command = 'clippy' },
    }
  }
})
```

### Telescope Configuration

Edit `lua/plugins/core/telescope.lua`:

```lua
require('telescope').setup({
  defaults = {
    vimgrep_arguments = {
      -- Add custom ripgrep arguments
      '--glob', '!node_modules',
      '--glob', '!.git',
    }
  }
})
```

### Treesitter Configuration

Edit `lua/plugins/core/treesitter.lua`:

```lua
require('nvim-treesitter.configs').setup({
  ensure_installed = { 'lua', 'python', 'go' },  -- Add languages
  highlight = { enable = true },
})
```

### Gitsigns Configuration

Edit `lua/plugins/git/gitsigns.lua`:

```lua
require('gitsigns').setup({
  signs = {
    add = { text = '│' },  -- Change symbols
    change = { text = '│' },
    delete = { text = '_' },
  }
})
```

## Creating Custom Commands

### Simple Command

```lua
-- lua/config/keymaps.lua or new file
vim.api.nvim_create_user_command('MyCommand', function(opts)
  print("Command executed with args: " .. opts.args)
end, { nargs = '*' })
```

Usage: `:MyCommand arg1 arg2`

### Command with Logic

```lua
vim.api.nvim_create_user_command('FormatJSON', function()
  vim.cmd('%!jq .')
end, {})
```

Usage: `:FormatJSON` (formats entire file as JSON)

### Command with Callbacks

```lua
vim.api.nvim_create_user_command('RunTests', function()
  local job = require('plenary.job'):new({
    command = 'go',
    args = { 'test', './...' },
    on_exit = function(j, return_code)
      if return_code == 0 then
        vim.notify("Tests passed!", vim.log.levels.INFO)
      else
        vim.notify("Tests failed!", vim.log.levels.ERROR)
      end
    end,
  })
  job:start()
end, {})
```

## Autocommands

Add in `lua/config/autocmds.lua`:

```lua
-- Auto-format on save
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.lua',
  callback = function()
    vim.lsp.buf.format()
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Treat .test.js files as JavaScript
vim.api.nvim_create_autocmd('BufNewFile,BufRead', {
  pattern = '*.test.js',
  callback = function()
    vim.opt.filetype = 'javascript'
  end,
})
```

## File Type Specific Settings

### Per-filetype Options

```lua
-- lua/config/init.lua or new file
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  callback = function()
    vim.opt.tabstop = 4
    vim.opt.shiftwidth = 4
  end,
})
```

### Per-filetype Keybindings

```lua
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'go',
  callback = function()
    vim.keymap.set('n', '<leader>tr', ':!go test<CR>', { buffer = true })
  end,
})
```

## Disabling Features

### Disable Plugin

In `lua/plugins/`, rename or comment out:

```lua
-- lua/plugins/optional/autoformat.lua
-- return { ... }  -- Entire file commented out
```

Or don't load in `lua/plugins/init.lua`.

### Disable Feature

Comment out in config files:

```lua
-- lua/config/init.lua
-- vim.opt.relativenumber = true  -- Disable relative line numbers
```

### Disable Keybinding

Comment out in `lua/config/keymaps.lua`:

```lua
-- vim.keymap.set('n', '<leader>xx', ...)
```

## Creating a Custom Module

### Helper Module

Create `lua/utils/custom.lua`:

```lua
local M = {}

function M.my_helper(arg)
  return "Result: " .. arg
end

function M.my_action()
  vim.notify("Action executed")
end

return M
```

### Use in Config

```lua
-- In any config file
local custom = require('utils.custom')
custom.my_action()
```

## Performance Optimization

### Lazy Load More

Plugins load on-demand. To be more aggressive:

```lua
-- lua/plugins/ui/statusline.lua
return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",  -- Load later
  config = function()
    -- ...
  end,
}
```

### Reduce Loaded Plugins

List all plugins: `:Lazy`

Disable unused: comment out in `lua/plugins/`

### Profile Startup

Check startup time:
```vim
:StartupTime
```

Shows which plugins take longest.

## Debugging Customizations

### Check Loaded Plugins

```vim
:Lazy
```

Shows all plugins and load status.

### Check Keybindings

```vim
:verbose map <leader>x
```

Shows which file defined keybinding.

### Test Lua Code

```vim
:lua print("Test")
:luafile lua/test.lua
```

### View Configuration

```vim
:echo vim.opt.tabstop
:echo vim.g.some_var
```

## Backup Before Major Changes

Before making big changes:

```bash
git add .
git commit -m "Before customizations"
```

Then revert if needed: `git revert HEAD`

## Testing Changes

### Reload Configuration

```vim
:source $MYVIMRC
```

Or:
```vim
:luafile ~/.config/nvim/init.lua
```

### Test in Scratch Buffer

```vim
:new
" Test code here
:wq
```

## Sharing Customizations

### Export Configuration

Keep personal config in separate branch:

```bash
git checkout -b my-custom-config
git push origin my-custom-config
```

### Create Public Fork

Create fork on GitHub with your customizations:
1. Fork repository
2. Add your customizations
3. Share with others

### Distribution

Create tar archive for sharing:
```bash
tar czf my-nvim-config.tar.gz lua/ init.lua
```

## Troubleshooting Customizations

### Plugin conflicts

Two plugins using same keybinding:
```vim
:verbose map <key>
```

Remove/change conflicting keybinding.

### Broken configuration

Neovim won't start:
```bash
nvim --noplugin -u NONE
```

Loads with no config. Then debug step-by-step.

### Syntax errors

Lua errors show in `:Lazy` or `:messages`:
```vim
:messages
```

Shows recent errors with line numbers.

## Tips for Clean Customizations

1. **Separate concerns**: Keep settings, keybindings, plugins separate
2. **Comment clearly**: Explain why non-obvious customizations exist
3. **Don't over-customize**: Keep changes minimal
4. **Version control**: Track changes in git
5. **Document**: Comment what you changed and why
6. **Test**: Verify changes don't break existing features

## Resources

- [lazy.nvim Documentation](https://github.com/folke/lazy.nvim)
- [Neovim API](https://neovim.io/doc/user/api.html)
- [Lua Guide](https://www.lua.org/manual/5.1/)
- [Vim Script Reference](https://vimdoc.sourceforge.net/)

## Quick Customization Template

New customization file:

```lua
-- lua/plugins/custom/my-feature.lua
return {
  "author/plugin",

  -- When to load
  event = "VeryLazy",

  -- Dependencies
  dependencies = {},

  -- Configuration
  config = function()
    require("plugin").setup({
      -- options
    })
  end,

  -- Keybindings
  keys = {
    { "<leader>x", function() -- action end, desc = "Action" },
  },
}
```

Copy and modify as needed.
