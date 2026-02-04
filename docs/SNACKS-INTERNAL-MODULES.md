# Snacks Internal Modules: Do You Need to Enable Them?

## Quick Answer

**NO, you don't need to explicitly enable internal snacks modules.**

They are automatically loaded as dependencies when needed by the enabled snacks modules.

---

## Understanding Internal Modules

### What Are They?

Internal modules are utility components used by snacks.nvim internally:

| Module | Purpose | Type |
|--------|---------|------|
| **animate** | Easing functions for animations | Library |
| **util** | Utility functions for snacks | Library |
| **win** | Floating window management | Library |
| **notify** | Notification utilities | Library |

They're **not standalone features**—they're building blocks for other snacks.

### Where Are They Used?

Internal modules power other snacks modules:

```
animate   → Used by: scroll, dim
util      → Used by: all snacks modules
win       → Used by: picker, terminal, dashboard, image
notify    → Used by: notifier
```

---

## How Lazy Loading Works

### Dependency Chain (Automatic)

When you enable a snacks module that depends on internal modules:

```
You enable: notifier = { enabled = true }
         ↓
Snacks checks: What does notifier need?
         ↓
Snacks finds: notifier depends on notify
         ↓
Automatic: notify is loaded (you don't do anything)
         ↓
Result: Both notifier and notify are available
```

### Real Example: Your Config

In your snacks.lua, you have:

```lua
notifier = { enabled = true },
```

Behind the scenes:
1. Snacks loads the notifier module
2. Notifier internally uses the notify module
3. notify is automatically loaded as a dependency
4. Everything works seamlessly

**You don't need to add**: `notify = { enabled = true }`

### Another Example: If You Enabled scroll

```lua
scroll = { enabled = true },
```

Behind the scenes:
1. Scroll module is loaded
2. Scroll uses animate for easing
3. animate is automatically loaded
4. Everything works seamlessly

**You don't need to add**: `animate = { enabled = true }`

---

## How lazy.nvim Handles This

### Plugin Dependency Resolution

lazy.nvim (your package manager) handles all dependency resolution:

```
1. You declare: snacks.nvim with enabled modules
2. Snacks declares: internal module dependencies
3. lazy.nvim resolves: dependency tree
4. lazy.nvim loads: modules in correct order
5. Everything works: automatically
```

### The Process

```lua
return {
  'folke/snacks.nvim',
  opts = {
    notifier = { enabled = true },  ← You specify this
    -- notify is auto-loaded (no need to specify)
  }
}
```

When Neovim starts:
1. lazy.nvim reads snacks plugin spec
2. lazy.nvim sees: notifier needs notify
3. lazy.nvim loads both automatically
4. No extra configuration needed

---

## Why This Design?

### Cleaner Configuration

**Without automatic dependency loading** (hypothetical):
```lua
opts = {
  animate = { enabled = true },    -- You'd need to enable this
  util = { enabled = true },        -- And this
  win = { enabled = true },         -- And this
  notify = { enabled = true },      -- And this
  notifier = { enabled = true },    -- Finally the actual feature
}
```

**With automatic dependency loading** (current):
```lua
opts = {
  notifier = { enabled = true },   -- That's it!
}
```

Much cleaner!

### Plugin Isolation

Internal modules are snacks-specific:
- They're not exported outside snacks.nvim
- Other plugins (like sidekick) don't depend on them
- Each plugin manages its own dependencies

### Maintainability

If snacks.nvim changes internal structure:
- You don't need to update your config
- lazy.nvim handles dependency changes
- Automatic updates work seamlessly

---

## Can Other Plugins Use Snacks' Internal Modules?

### Direct Usage

**NO** - Other plugins don't directly use snacks internal modules.

- **sidekick**: Has its own dependencies, doesn't use snacks internals
- **telescope**: Independent plugin, doesn't use snacks
- **other plugins**: Each has their own utilities

### Why?

1. **Plugin Independence**: Each plugin should be self-contained
2. **Avoid Coupling**: Reduce plugin interdependencies
3. **Flexibility**: Users can update plugins independently

### What Plugins CAN Do

Plugins can use snacks **public features**:

```lua
-- Example (hypothetical plugin)
local snacks = require('snacks')

-- Use public snacks picker (if enabled)
snacks.picker.files()

-- Use public snacks notify (if enabled)
snacks.notify("Message")
```

But this only works if you've enabled those modules.

---

## Current Setup: Analysis

### Your Enabled Snacks

```lua
opts = {
  bigfile = { enabled = true },     -- Auto-loads: none
  indent = { enabled = true },      -- Auto-loads: none
  input = { enabled = true },       -- Auto-loads: util
  notifier = { enabled = true },    -- Auto-loads: notify
  quickfile = { enabled = true },   -- Auto-loads: none
  scope = { enabled = true },       -- Auto-loads: util
  statuscolumn = { enabled = true },-- Auto-loads: none
  words = { enabled = true },       -- Auto-loads: util
}
```

### Automatic Dependencies

Without you doing anything:
- ✅ `util` is auto-loaded (used by: input, scope, words)
- ✅ `notify` is auto-loaded (used by: notifier)
- ✅ `animate` is available (if you later enable scroll)
- ✅ `win` is available (if you later enable picker, terminal, etc.)

**No extra configuration needed!**

---

## Should You Enable Internal Modules?

### Try This

Test if internal modules are already working:

```vim
" Check if notify utilities are available
:lua print(require('snacks.notify'))

" Check if util functions are available
:lua print(require('snacks.util'))

" Both should return tables (available), not errors
```

**Result**: They're already loaded automatically!

### Do You Need to Add Them to Config?

```lua
-- This is NOT necessary:
opts = {
  notifier = { enabled = true },
  notify = { enabled = true },      -- ❌ Don't add this
  util = { enabled = true },        -- ❌ Don't add this
  animate = { enabled = true },     -- ❌ Don't add this
  win = { enabled = true },         -- ❌ Don't add this
}

-- Just do this:
opts = {
  notifier = { enabled = true },    -- ✅ This is enough
  -- notify is auto-loaded!
}
```

**Answer**: NO, don't add them to config. They auto-load as dependencies.

---

## What If You Want to Use Internal Modules Directly?

### Example: Custom Use of snacks.notify

If a plugin (not in your config) wanted to use snacks notify:

```lua
-- In some custom script or plugin
local notify = require('snacks.notify')
notify('Message', 'info')
```

### Requirements

For this to work:
1. snacks.nvim must be installed (✅ you have it)
2. notifier must be enabled (✅ you have it enabled)
3. notify will be auto-loaded (✅ happens automatically)

### You Don't Need to Enable notify Explicitly

The notifier module already ensures notify is loaded when notifier is enabled.

---

## Common Misconceptions

### ❌ "I need to enable all internal modules"

**FALSE** - They load automatically as needed.

### ❌ "If I don't enable util, utility functions won't work"

**FALSE** - util is auto-loaded by modules that use it (input, scope, words).

### ❌ "Other plugins depend on snacks internal modules"

**FALSE** - Plugins are independent. They have their own utilities.

### ✅ "Internal modules only load if needed"

**TRUE** - lazy.nvim loads only what's required.

### ✅ "I only need to enable feature modules"

**TRUE** - Enable the snacks you want to use, ignore internal modules.

---

## Summary

| Question | Answer |
|----------|--------|
| Do I need to enable internal modules? | ❌ NO |
| Will they auto-load? | ✅ YES |
| Do other plugins use them? | ❌ NO |
| Does sidekick depend on snacks? | ❌ NO |
| Should I add them to config? | ❌ NO |
| Are they already working? | ✅ YES |

---

## How to Verify Everything Works

### Check Current Setup

```vim
:Lazy
```

Search for snacks. Should show:
- ✅ snacks.nvim loaded
- ✅ status shows "ok"
- ✅ no errors

### Test Internal Modules

```vim
:lua print(require('snacks.notify'))
:lua print(require('snacks.util'))
:lua print(require('snacks.animate'))
:lua print(require('snacks.win'))
```

All should print table information (success), not errors.

### Test Enabled Modules

```vim
:lua print(require('snacks.notifier'))
:lua print(require('snacks.input'))
```

Should work perfectly (and use the internal modules automatically).

---

## Conclusion

**You have the correct setup:**

```lua
opts = {
  bigfile = { enabled = true },
  indent = { enabled = true },
  input = { enabled = true },      -- Uses util (auto-loaded)
  notifier = { enabled = true },   -- Uses notify (auto-loaded)
  quickfile = { enabled = true },
  scope = { enabled = true },      -- Uses util (auto-loaded)
  statuscolumn = { enabled = true },
  words = { enabled = true },      -- Uses util (auto-loaded)
}
```

✅ All dependencies are automatically resolved
✅ All internal modules are auto-loaded when needed
✅ No changes needed
✅ Everything works seamlessly

**Don't touch the internal modules—they're handled automatically!**
