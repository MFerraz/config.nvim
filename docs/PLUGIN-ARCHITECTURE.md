# Plugin Architecture & lazy.nvim

## Overview

This configuration uses `lazy.nvim` as the package manager. Understanding how it works is key to managing plugins effectively.

**File**: `lua/config/lazy.lua`

**Plugin**: lazy.nvim (by folke)

## What is lazy.nvim?

A modern plugin manager for Neovim that:
- **Lazy loads** plugins on-demand (fast startup)
- **Manages dependencies** between plugins
- **Version locks** plugins (lazy-lock.json)
- **Updates easily** (`:Lazy update`)
- **Cleans up** unused plugins (`:Lazy clean`)

## Plugin Structure

### Plugin Spec Format

All plugins follow this format:

```lua
return {
  "author/plugin-name",      -- GitHub repository

  -- When to load
  lazy = false,              -- false = load immediately
  event = "VeryLazy",        -- Load on event
  ft = "python",             -- Load for filetype
  cmd = "MyCommand",         -- Load on command
  keys = { ... },            -- Load on keypress

  -- Dependencies
  dependencies = {
    "dependency/plugin1",
    "dependency/plugin2",
  },

  -- Configuration
  config = function()
    -- Setup code runs after plugin loads
  end,

  -- Plugin-specific options
  opts = {
    -- Passed to setup()
  },
}
```

## Plugin Loading Events

### By Timing

| Event | When | Use Case |
|-------|------|----------|
| `VeryLazy` | After UI ready | Non-critical plugins |
| `LazyFile` | On file open | File utilities |
| `BufRead` | Buffer opened | Editor features |
| `BufNewFile` | New file created | New file tools |
| `InsertEnter` | Enter insert mode | Completion, snippets |
| `CmdlineEnter` | Enter command mode | Command tools |

### By Command

| Event | Syntax | Use Case |
|-------|--------|----------|
| `cmd` | `cmd = "MyCommand"` | Load on `:MyCommand` |
| `keys` | `keys = {{ ... }}` | Load on keypress |
| `ft` | `ft = "python"` | Load for filetype |

### Lazy vs Non-Lazy

```lua
-- Load immediately (no lazy loading)
lazy = false
-- OR (implicit)
-- No lazy/event/cmd specified

-- Lazy load (on-demand)
event = "VeryLazy"
cmd = "MyCommand"
ft = "python"
```

## Project Plugin Organization

### File Structure

```
lua/plugins/
├── init.lua           # Loads all plugins
├── ai/
│   └── sidekick.lua
├── core/
│   ├── lsp.lua
│   ├── completion.lua
│   ├── treesitter.lua
│   └── telescope.lua
├── ui/
│   ├── colorscheme.lua
│   ├── statusline.lua
│   ├── icons.lua
│   └── snacks.lua
├── git/
│   ├── gitsigns.lua
│   ├── fugitive.lua
│   └── conflicts.lua
├── editor/
│   ├── oil.lua
│   ├── comment.lua
│   └── which-key.lua
└── optional/
    ├── autoformat.lua
    └── debug.lua
```

### Main Plugin Loader

**File**: `lua/plugins/init.lua`

```lua
return {
  -- Load all plugins from subdirectories
  require("plugins.core.lsp"),
  require("plugins.core.completion"),
  -- ... etc
}
```

Lazy.nvim automatically:
1. Finds all plugin specs
2. Loads each according to rules (lazy, event, etc.)
3. Manages dependencies
4. Initializes on startup

## Dependencies Between Plugins

### Declaring Dependencies

If one plugin requires another:

```lua
return {
  "main/plugin",
  dependencies = {
    "dependency/one",
    "dependency/two",
  },
}
```

Lazy.nvim ensures dependencies load before the main plugin.

### Nested Dependencies

```lua
-- Plugin A depends on B
-- Plugin B depends on C
-- Lazy.nvim loads: C → B → A
```

### Optional Dependencies

Some plugins work better with others:

```lua
return {
  "main/plugin",
  dependencies = {
    {
      "optional/enhancement",
      optional = true,  -- Don't fail if missing
    }
  },
}
```

## Configuration Patterns

### Using `config` Function

```lua
return {
  "author/plugin",
  config = function()
    require("plugin").setup({
      option1 = true,
      option2 = "value",
    })
  end,
}
```

The config function runs after plugin loads.

### Using `opts` Table

Alternative syntax:

```lua
return {
  "author/plugin",
  opts = {
    option1 = true,
    option2 = "value",
  },
}
```

Lazy.nvim automatically calls `setup(opts)`.

### Merging Defaults

```lua
local defaults = { color = 'blue' }

return {
  "author/plugin",
  opts = function(_, opts)
    return vim.tbl_deep_extend("force", defaults, opts)
  end,
}
```

Merges user options with defaults.

## Keybindings in Plugins

### Load on Keypress

```lua
return {
  "author/plugin",
  keys = {
    { "<leader>xx", function() require("plugin").action() end, desc = "Do action" },
    { "<leader>xy", "<Cmd>MyCommand<CR>", desc = "Run command" },
  },
}
```

Plugin loads only when keypress triggers.

### Multiple Keybindings

```lua
keys = {
  { "<leader>a", function() -- action1 end, desc = "Action 1" },
  { "<leader>b", function() -- action2 end, desc = "Action 2" },
  { "<leader>c", "<Cmd>SomeCmd<CR>", desc = "Command" },
}
```

All keybindings registered, plugin lazy loads on first keypress.

## Managing Plugins

### View Plugin Status

```vim
:Lazy
```

Shows all plugins:
- Status (installed, loaded, not installed)
- Load event (VeryLazy, etc.)
- Recent commit
- Documentation

### Install Missing

```vim
:Lazy install
```

Or manually in `:Lazy` menu with `i` key.

### Update All

```vim
:Lazy update
```

Updates all plugins to latest versions.

### Update Specific Plugin

In `:Lazy` menu:
- Navigate to plugin
- Press `u` to update

### Clean Unused

```vim
:Lazy clean
```

Removes plugins no longer in config.

### Check for Issues

```vim
:Lazy check
```

Shows errors, warnings, deprecated plugins.

## Plugin Lock File

**File**: `lazy-lock.json`

Stores exact plugin versions:
- Tracks commit hashes
- Ensures reproducible installs
- Shared across team/machines

### Version Control

Commit `lazy-lock.json`:
```bash
git add lazy-lock.json
git commit -m "Update plugin versions"
```

Then teammates can update:
```bash
:Lazy restore
```

Restores exact versions from lock file.

### Lock/Unlock

Update and lock versions:
```vim
:Lazy update
:Lazy lock
```

Keep on specific version:
```vim
:Lazy lock plugin-name
```

## Performance Optimization

### Startup Time

Lazy loading improves startup:
1. Only critical plugins load immediately
2. Others load on-demand (lazy, event, etc.)
3. Faster Neovim startup

Check impact:
```vim
:StartupTime
```

Shows startup breakdown.

### Reducing Load Time

To load plugins faster:

1. **Increase lazy threshold**:
```lua
require("lazy").setup(plugins, {
  ui = { throttle = 20 },  -- ms between updates
})
```

2. **Reduce plugin count** - Remove unused plugins

3. **Profile plugins** - `:Lazy profile`

### Load Time Per Plugin

In `:Lazy` menu, press `P` to show profiling:
- Time taken for each plugin
- Helps identify slow plugins

## Common Plugin Commands

### In Neovim

| Command | Action |
|---------|--------|
| `:Lazy` | Open plugin manager |
| `:Lazy install` | Install missing plugins |
| `:Lazy update` | Update all plugins |
| `:Lazy clean` | Remove unused plugins |
| `:Lazy sync` | Install, update, clean |
| `:Lazy restore` | Restore locked versions |
| `:Lazy check` | Check for issues |
| `:Lazy profile` | Show timing breakdown |
| `:Lazy help` | Show help |

### Git Integration

Lazy.nvim uses git, so check:
```bash
git status              # See modified files
git log lazy-lock.json  # See version history
```

## Plugin Repositories

### GitHub Format

Most plugins are GitHub repos:
```lua
"author/repo-name"  → https://github.com/author/repo-name.git
```

### GitLab, Gitea, etc.

```lua
"gitlab:user/repo"
"gitea:user/repo"
```

### Local Plugins

For development:

```lua
{
  "/path/to/local/plugin",
  dev = true,  -- Development mode
}
```

Changes to local plugin immediately available.

## Troubleshooting Plugins

### Plugin not loading

1. Check if installed: `:Lazy`
2. Check configuration: Review config in plugin file
3. Check load event: `event`, `cmd`, `ft`
4. Manual load: `:Lazy load plugin-name`

### Plugin conflicts

Two plugins with conflicting keybindings:
```vim
:verbose map <key>
```

Shows which file defined binding. Change one.

### Dependency issues

Plugin A requires B but B isn't loading:
1. Ensure B is in config
2. Check B is valid (not typo)
3. May need explicit dependency declaration

### Performance degradation

If Neovim is slow after adding plugin:

```vim
:Lazy profile
```

Check which plugin takes most time. May need to:
- Lazy load the plugin
- Use different plugin
- Disable feature in plugin

## Advanced: Creating a Plugin

Minimal plugin structure:

```
my-plugin/
├── plugin/
│   └── my-plugin.vim
├── lua/
│   └── my-plugin.lua
└── README.md
```

Then use locally:

```lua
{
  "~/path/to/my-plugin",
  dev = true,
}
```

## Best Practices

1. **Lazy load when possible** - Improves startup
2. **Minimize dependencies** - Reduces complexity
3. **Version lock** - Commit lazy-lock.json
4. **Document setup** - Add comments explaining config
5. **Remove unused** - Regular cleanup
6. **Profile regularly** - Check startup time
7. **Keep organized** - One category per directory

## Resources

- [lazy.nvim Documentation](https://github.com/folke/lazy.nvim)
- [Plugin Specification](https://github.com/folke/lazy.nvim#-plugin-spec)
- [Neovim Plugin Development](https://neovim.io/doc/user/dev_plugin.html)

## Quick Reference

### Create New Plugin File

```lua
-- lua/plugins/category/myplugin.lua
return {
  "author/my-plugin",
  event = "VeryLazy",
  config = function()
    require("my-plugin").setup({})
  end,
  keys = {
    { "<leader>x", function() -- action end, desc = "Action" },
  },
}
```

### Add to Plugin Loader

Usually automatic if in proper directory. Or add to `lua/plugins/init.lua`:

```lua
return {
  require("plugins.category.myplugin"),
}
```

### Manage in Neovim

```vim
:Lazy              " Open manager
i                  " Install missing
u                  " Update all
p                  " Profile
?                  " Help
```

## Full Plugin Lifecycle

```
1. Define plugin spec (return {...})
2. Lazy.nvim reads configuration
3. On condition (lazy=false, event, cmd, key, ft):
   a. Resolve dependencies
   b. Download if missing
   c. Load plugin code
   d. Run config function
   e. Register keybindings
4. Plugin available for use
5. Repeat for remaining plugins
```

This asynchronous loading means startup is fast while having full features available.
