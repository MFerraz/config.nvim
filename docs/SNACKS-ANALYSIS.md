# Snacks.nvim Modules Analysis

Complete analysis of all 31 snacks modules with recommendations for your config.

**Currently Enabled**: 8 modules (bigfile, indent, input, notifier, quickfile, scope, statuscolumn, words)

---

## Summary Table

| Snack | Enabled | Existing Solution | Worth Enabling? | Reasoning |
|-------|---------|-------------------|-----------------|-----------|
| animate | ❌ | N/A | 🟡 Low Priority | Library component, used by other snacks |
| **bigfile** | ✅ | N/A | ✅ Excellent | Handles large files gracefully |
| **bufdelete** | ❌ | Built-in `:bdelete` | 🟡 Optional | Nice but not essential |
| **dashboard** | ❌ | None | 🟡 Optional | Startup screen (cosmetic) |
| **debug** | ❌ | Manual inspection | 🟡 Optional | Better error display |
| **dim** | ❌ | None | 🟡 Optional | Highlight active scope visually |
| **explorer** | ❌ | Oil.nvim | ❌ Skip | Oil is better for buffer-based workflow |
| **gh** | ❌ | Vim-rhubarb | 🟡 Optional | GitHub CLI integration (duplicates rhubarb) |
| **git** | ❌ | Fugitive, Gitsigns | 🟡 Optional | Git utilities (already covered) |
| **gitbrowse** | ❌ | Vim-rhubarb | ❌ Skip | Rhubarb already does this |
| **image** | ❌ | None | ❌ Skip | Terminal image display (niche) |
| **indent** | ✅ | None | ✅ Excellent | Smart indent guides |
| **input** | ✅ | Default vim.ui.input | ✅ Better | Enhanced input dialogs |
| **keymap** | ❌ | vim.keymap | 🟡 Optional | Extends keymap with extras |
| **layout** | ❌ | None | 🟡 Optional | Window layout management |
| **lazygit** | ❌ | Vim-fugitive | 🟡 Nice-to-have | Better git UI than fugitive |
| **notifier** | ✅ | Default vim.notify | ✅ Better | Styled notifications |
| **notify** | ❌ | Part of notifier | ⚪ Utility | Used by notifier internally |
| **picker** | ❌ | Telescope | ❌ Skip | Telescope is superior |
| **profiler** | ❌ | None | 🟡 Dev Only | Lua profiling (dev tool) |
| **quickfile** | ✅ | None | ✅ Excellent | Fast file rendering |
| **rename** | ❌ | LSP + Manual | 🟡 Nice-to-have | LSP-aware file renaming |
| **scope** | ✅ | Treesitter | ✅ Excellent | Scope detection + navigation |
| **scratch** | ❌ | None | 🟡 Optional | Temporary persistent buffers |
| **scroll** | ❌ | None | 🟡 Optional | Smooth scrolling |
| **statuscolumn** | ✅ | Gitsigns | ✅ Good | Better status column formatting |
| **terminal** | ❌ | None | 🟡 Optional | Floating/split terminals |
| **toggle** | ❌ | None | 🟡 Optional | Keymap toggles |
| **util** | ❌ | N/A | ⚪ Internal | Utility library for snacks |
| **win** | ❌ | N/A | ⚪ Internal | Window management for snacks |
| **words** | ✅ | None | ✅ Excellent | LSP reference highlighting |

---

## Detailed Analysis

### ✅ Already Enabled (Keep These)

#### 1. **bigfile** - Handles Large Files
- **Status**: ✅ Enabled
- **What**: Auto-disables slow features for 10k+ line files
- **Current Role**: Essential optimization
- **Worth Keeping**: YES
- **Notes**: Prevents lag on large files

#### 2. **indent** - Indent Guides
- **Status**: ✅ Enabled
- **What**: Shows indentation levels visually
- **Current Role**: Better than traditional indent plugins
- **Worth Keeping**: YES
- **Notes**: Lightweight, cleaner than alternatives

#### 3. **input** - Enhanced Input Dialog
- **Status**: ✅ Enabled
- **What**: Replaces `vim.ui.input` with styled dialog
- **Current Role**: Better UX for input prompts
- **Worth Keeping**: YES
- **Notes**: Used by LSP rename and other commands

#### 4. **notifier** - Styled Notifications
- **Status**: ✅ Enabled
- **What**: Replaces `vim.notify` with better UI
- **Current Role**: Better notification display
- **Worth Keeping**: YES
- **Notes**: Integrates with all plugins' notifications

#### 5. **quickfile** - Fast File Rendering
- **Status**: ✅ Enabled
- **What**: Renders files before plugins fully load
- **Current Role**: Faster perceived startup
- **Worth Keeping**: YES
- **Notes**: Makes Neovim feel snappier

#### 6. **scope** - Scope Detection & Navigation
- **Status**: ✅ Enabled
- **What**: Detects and highlights current scope (function, class)
- **Current Role**: Better code context awareness
- **Worth Keeping**: YES
- **Notes**: Works with Treesitter, adds text objects

#### 7. **statuscolumn** - Status Column Formatting
- **Status**: ✅ Enabled
- **What**: Unified status column (line numbers, git, diagnostics)
- **Current Role**: Better gutter formatting than defaults
- **Worth Keeping**: YES
- **Notes**: Combines multiple indicators

#### 8. **words** - LSP Reference Highlighting
- **Status**: ✅ Enabled
- **What**: Auto-highlights all references to word under cursor
- **Current Role**: Better than manual grep for finding usage
- **Worth Keeping**: YES
- **Notes**: Real-time LSP-aware highlighting

---

### 🟡 Consider Enabling (Optional)

#### 9. **dim** - Darken Inactive Scopes
- **Current**: None
- **What**: Darkens code outside current function/class
- **Replacement**: None (standalone feature)
- **Recommendation**: ⭐ CONSIDER
- **Why**: Nice UX for large functions, helps focus
- **Downside**: May feel cluttered in nested code
- **Try It**: `dim = { enabled = true }`

#### 10. **scroll** - Smooth Scrolling
- **Current**: None
- **What**: Smooth animation when scrolling (`<C-d>`, `<C-u>`, etc.)
- **Replacement**: None (standalone feature)
- **Recommendation**: 🟡 OPTIONAL
- **Why**: Eye candy, some find it helpful
- **Downside**: Performance cost on slow systems
- **Try It**: `scroll = { enabled = true }`

#### 11. **terminal** - Floating/Split Terminals
- **Current**: None
- **What**: Quick terminal spawning
- **Replacement**: None (but `:!` and tmux exist)
- **Recommendation**: 🟡 OPTIONAL
- **Why**: Convenient for quick commands
- **Downside**: Tmux is more powerful
- **Skip If**: You use tmux or terminal multiplexer

#### 12. **lazygit** - Better Git UI
- **Current**: Vim-fugitive
- **What**: LazyGit in floating window (if lazygit installed)
- **Replacement**: Vim-fugitive (less elegant)
- **Recommendation**: 🟡 CONSIDER
- **Why**: Much better git UI than fugitive
- **Downside**: Requires external `lazygit` tool
- **Try It**: If you have lazygit installed

#### 13. **rename** - LSP-Aware File Renaming
- **Current**: Manual file rename
- **What**: Rename files and update all imports
- **Replacement**: None (custom LSP)
- **Recommendation**: 🟡 NICE-TO-HAVE
- **Why**: Auto-updates imports when renaming
- **Downside**: Not essential, LSP handles imports
- **Try It**: `rename = { enabled = true }`

#### 14. **debug** - Better Error Display
- **Current**: Manual inspection
- **What**: Formatted backtrace and error output
- **Replacement**: None (dev utility)
- **Recommendation**: 🟡 DEV ONLY
- **Why**: Better error messages during debugging
- **Downside**: Only useful while developing plugins
- **Try It**: If developing Neovim plugins

#### 15. **bufdelete** - Delete Buffers Cleanly
- **Current**: Built-in `:bdelete`
- **What**: Remove buffers without closing windows
- **Replacement**: Built-in (less smooth)
- **Recommendation**: 🟡 MINOR IMPROVEMENT
- **Why**: Better window preservation
- **Downside**: Minor convenience, not essential
- **Try It**: `bufdelete = { enabled = true }`

#### 16. **toggle** - Keymap Toggles
- **Current**: Manual toggles
- **What**: Integrate toggles with which-key
- **Replacement**: None (convenience)
- **Recommendation**: 🟡 POLISH
- **Why**: Better UX for boolean options
- **Downside**: Requires extra configuration
- **Try It**: If you often toggle features

#### 17. **keymap** - Extended vim.keymap
- **Current**: vim.keymap
- **What**: Extend keymaps with filetype/LSP support
- **Replacement**: vim.keymap (less featured)
- **Recommendation**: 🟡 OPTIONAL
- **Why**: More powerful keymap definitions
- **Downside**: Learning curve, not essential
- **Try It**: If you need advanced keymap features

#### 18. **layout** - Window Layout Management
- **Current**: None
- **What**: Save/restore window layouts
- **Replacement**: None (standalone)
- **Recommendation**: 🟡 WORKFLOW
- **Why**: Useful for switching between project layouts
- **Downside**: Moderate complexity
- **Try It**: If you use multiple layout patterns

#### 19. **scratch** - Temporary Persistent Buffers
- **Current**: None
- **What**: Quick temporary files that persist
- **Replacement**: `:tabnew` or temporary files
- **Recommendation**: 🟡 NICE-TO-HAVE
- **Why**: Quick scratchpad for testing
- **Downside**: Niche use case
- **Try It**: If you use scratchpads often

#### 20. **dashboard** - Startup Screen
- **Current**: None
- **What**: Custom dashboard on startup
- **Replacement**: None (cosmetic)
- **Recommendation**: 🟡 COSMETIC
- **Why**: Nice visual, but not functional
- **Downside**: Pure cosmetics
- **Try It**: If you want a fancy startup screen

#### 21. **profiler** - Lua Profiling
- **Current**: None
- **What**: Profile Lua code performance
- **Replacement**: None (dev tool)
- **Recommendation**: 🟡 DEV ONLY
- **Why**: Useful for optimizing slow code
- **Downside**: Only useful during development
- **Try It**: If debugging performance issues

---

### ❌ Skip (Better Alternatives Exist)

#### 22. **picker** - Item Selection
- **Current**: Telescope (superior)
- **What**: Built-in picker interface
- **Replacement**: Telescope (more mature, better)
- **Recommendation**: ❌ SKIP
- **Why**: Telescope is best-in-class, more powerful
- **Alternative**: Keep Telescope
- **Note**: Only consider in 1-2 years if snacks catches up

#### 23. **explorer** - File Browser
- **Current**: Oil.nvim (superior)
- **What**: File explorer built on picker
- **Replacement**: Oil.nvim (buffer-based, more flexible)
- **Recommendation**: ❌ SKIP
- **Why**: Oil is better for your workflow
- **Alternative**: Keep Oil
- **Note**: Different philosophy; Oil wins for this config

#### 24. **gitbrowse** - Open in Browser
- **Current**: Vim-rhubarb (equivalent)
- **What**: Open files/commits on GitHub/GitLab
- **Replacement**: Vim-rhubarb (does same thing)
- **Recommendation**: ❌ SKIP
- **Why**: Rhubarb already handles this
- **Alternative**: Keep Rhubarb
- **Note**: Functional duplicate

#### 25. **gh** - GitHub CLI
- **Current**: Vim-rhubarb (sufficient)
- **What**: GitHub CLI integration
- **Replacement**: Vim-rhubarb (handles most use cases)
- **Recommendation**: ❌ SKIP
- **Why**: Rhubarb + fugitive cover GitHub needs
- **Alternative**: Keep current setup
- **Note**: Only useful if you heavily use GitHub API

#### 26. **git** - Git Utilities
- **Current**: Fugitive + Gitsigns (better)
- **What**: Git utilities module
- **Replacement**: Vim-fugitive + Gitsigns (more mature)
- **Recommendation**: ❌ SKIP
- **Why**: Current plugins are more mature
- **Alternative**: Keep current setup
- **Note**: Snacks git is still developing

#### 27. **image** - Image Display
- **Current**: None
- **What**: Display images in terminal
- **Replacement**: None (niche feature)
- **Recommendation**: ❌ SKIP
- **Why**: Requires Kitty/Wezterm/Ghostty, niche use case
- **Alternative**: Use external viewer
- **Note**: Only useful if previewing images in editor

---

### ⚪ Internal/Utility (Don't Enable Directly)

#### 28. **animate** - Animation Library
- **Status**: ⚪ Internal
- **What**: Provides easing functions for snacks animations
- **Action**: Don't enable (used internally)

#### 29. **util** - Utility Functions
- **Status**: ⚪ Internal
- **What**: Helper functions for snacks
- **Action**: Don't enable (used internally)

#### 30. **win** - Window Management
- **Status**: ⚪ Internal
- **What**: Floating window management for snacks
- **Action**: Don't enable (used internally)

#### 31. **notify** - Notification Utilities
- **Status**: ⚪ Internal
- **What**: Part of notifier module
- **Action**: Don't enable (notifier handles it)

---

## New Plugin: render-markdown.nvim

**Status**: Recently added
**Purpose**: Render markdown files with enhanced visual formatting
**Conflicts with Snacks**: ❌ None
**Conflicts with Other Plugins**: ❌ None

The new markdown rendering plugin works great with your config:
- ✅ Uses Treesitter (already installed)
- ✅ Uses nvim-web-devicons (already installed)
- ✅ No conflicts with snacks or other plugins
- ✅ Auto-applies to `.md` files
- ✅ Fully editable while rendering

See `docs/MARKDOWN-RENDERING.md` for details.

---

## Recommendations by Category

### 🟢 Essential (Keep Enabled)
- ✅ bigfile - Large file optimization
- ✅ indent - Visual indent guides
- ✅ input - Better input dialogs
- ✅ notifier - Styled notifications
- ✅ quickfile - Fast file rendering
- ✅ scope - Scope detection
- ✅ statuscolumn - Status column formatting
- ✅ words - LSP reference highlighting

### 🟡 Worth Considering (Optional Enhancements)
**High Impact**:
- `dim` - Scope dimming (visual focus)
- `lazygit` - Better git UI (if lazygit installed)
- `rename` - LSP file renaming (convenience)

**Medium Impact**:
- `scroll` - Smooth scrolling (cosmetic but nice)
- `terminal` - Quick terminals (less useful with tmux)
- `bufdelete` - Clean buffer deletion (minor)

**Low Impact (Niche)**:
- `layout` - Window layout management
- `toggle` - Toggle UX enhancement
- `scratch` - Scratchpad buffers
- `dashboard` - Startup screen
- `debug` - Error display (dev only)
- `profiler` - Lua profiling (dev only)
- `keymap` - Extended keymaps

### ❌ Skip (Don't Enable)
- picker (Telescope is better)
- explorer (Oil is better)
- gitbrowse (Rhubarb is equivalent)
- gh (Rhubarb is sufficient)
- git (Fugitive is better)
- image (Niche, requires specific terminal)

---

## My Recommendation: Next Steps

### Suggested Configuration Addition

Add these optional snacks for incremental improvement:

```lua
-- lua/plugins/ui/snacks.lua
opts = {
  -- Currently enabled
  bigfile = { enabled = true },
  indent = { enabled = true },
  input = { enabled = true },
  notifier = { enabled = true },
  quickfile = { enabled = true },
  scope = { enabled = true },
  statuscolumn = { enabled = true },
  words = { enabled = true },

  -- Consider adding (high-value)
  dim = { enabled = true },        -- Focus on current scope
  scroll = { enabled = true },     -- Smooth scrolling

  -- Consider if you use these workflows
  -- lazygit = { enabled = true },  -- Only if lazygit installed
  -- rename = { enabled = true },   -- For frequent file renames
}
```

### What to Keep

✅ Keep Telescope (best-in-class for fuzzy finding)
✅ Keep Oil.nvim (buffer-based file management)
✅ Keep Vim-fugitive (mature git integration)
✅ Keep Gitsigns (git gutter indicators)
✅ Keep Vim-rhubarb (GitHub integration)

### What Could Be Removed (Future)

If you want to consolidate, these are duplicates:
- `lazygit` could eventually replace `vim-fugitive` (better UI)
- But keep fugitive for now (more mature, better integration with other tools)

---

## Trial Configuration

Want to test new features? Add this temporarily:

```lua
opts = {
  -- ... existing config
  dim = { enabled = true },
  scroll = { enabled = true },
}
```

Then restart Neovim and see if you like them. If not, just remove.

---

## Summary

**Current Setup**: Excellent (8/31 snacks enabled)
**Recommendation**: Add `dim` and `scroll` for better UX
**Keep Everything Else**: Telescope, Oil, Fugitive are superior or equivalent
**Future Review**: Check snacks picker in 6-12 months

You have a well-balanced setup. Adding `dim` and `scroll` would be nice cosmetic improvements with no downside.
