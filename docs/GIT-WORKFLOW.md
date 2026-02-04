# Git Workflow & Integration

## Overview

This configuration provides comprehensive git integration with visual feedback and efficient workflows. It combines multiple git tools for a seamless experience.

**Files**:
- `lua/plugins/git/` - All git-related plugins
- `lua/config/keymaps.lua` - Git keybindings

## Git Plugins

### 1. vim-fugitive
**Purpose**: Full-featured Git wrapper within Neovim

**Main command**: `:Git` (or `:G`)

```vim
:Git status        " Show git status
:Git add %         " Stage current file
:Git commit        " Open commit editor
:Git push          " Push to remote
:Git pull          " Pull from remote
:Git log           " Show git history
:Git diff          " Show diffs
```

**In diff view**:
- `do` - Get from ours
- `dt` - Get from theirs
- `dp` - Put to other file

### 2. vim-rhubarb
**Purpose**: GitHub integration for fugitive

**Usage**:
```vim
:GBrowse    " Open current file on GitHub
:GBrowse!   " Copy GitHub URL to clipboard
```

In visual mode, opens the selection on GitHub.

### 3. gitsigns.nvim
**Purpose**: Git change indicators (added/modified/deleted lines)

**Visual Feedback**:
- Green bar on left = Added lines
- Yellow bar on left = Modified lines
- Red bar on left = Deleted lines
- Line numbers with git symbols in gutter

**Keybindings** (`<leader>h`):
```
[c / ]c         Navigate hunks
<leader>hp      Preview hunk (shows diff)
<leader>hs      Stage hunk (in gitsigns config)
<leader>hu      Undo hunk (in gitsigns config)
```

### 4. vim-flog
**Purpose**: Interactive git log browser with tree view

**Open with**: `<leader>gl`

**In Flog view**:
- `q` - Quit
- `<CR>` - Open commit
- `a` - Author filter
- `d` - Date range filter
- `g` - Graph toggle
- `p` - Patch view

Visual display of branch history and commits.

### 5. git-conflict.nvim
**Purpose**: Merge conflict resolution tools

**When conflicts occur**:
- Conflict markers automatically highlighted
- Keybindings to choose versions

**Keybindings** (`<leader>gc`):
```
<leader>gco     Choose ours (your version)
<leader>gct     Choose theirs (their version)
<leader>gcb     Choose both (keep both)
<leader>gcq     Quickfix list of all conflicts
```

**Example conflict**:
```
<<<<<<< HEAD
  your changes
=======
  their changes
>>>>>>> branch-name
```

Press `<leader>gco` to keep only your changes, `<leader>gct` to keep theirs.

## Git Workflow Patterns

### Pattern 1: Review Before Staging

```vim
1. Press [c / ]c to navigate hunks
2. Press <leader>hp to preview each change
3. Decide if it should be staged
4. Stage hunks or entire file
```

### Pattern 2: View Git Status & History

```vim
1. Press <leader>gs to open git file explorer
   (Shows all changed files with git indicators)
2. Navigate to file you're interested in
3. Press <leader>gl to see git history of file
4. Navigate history tree to see changes over time
```

### Pattern 3: Handle Merge Conflicts

```vim
1. During merge, conflicts appear with markers
2. Navigate to conflict with [c / ]c
3. Use <leader>gc[o/t/b] to choose version
4. Or use <leader>gcq to list all conflicts
5. Fix remaining issues and commit
```

### Pattern 4: Create Commits

```vim
1. Stage changes (via git add or UI)
2. Run :Git commit (opens commit message editor)
3. Write commit message
4. :wq to commit
```

## Git Status in File Explorer

The file explorer (Oil.nvim or Neotree) shows git status:
- `M` - Modified files (yellow)
- `A` - Added files (green)
- `D` - Deleted files (red)
- `?` - Untracked files (gray)

Open with `<leader>gs` to view all changes.

## Hunk Navigation

**What's a hunk?**: A contiguous block of changed lines.

```vim
[c  Navigate to previous hunk
]c  Navigate to next hunk
<leader>hp  Preview the hunk (shows diff)
```

**Use case**: Review changes before staging them:
1. `]c` to next hunk
2. `<leader>hp` to see the diff
3. Decide if it's correct
4. Repeat for all hunks

## Branch Navigation

**View branches**:
```vim
:Git branch         " List local branches
:Git branch -a      " List all branches
:Git checkout <name> " Switch branch
```

In Flog (`<leader>gl`), navigate commits and branches visually.

## Stashing Changes

Keep uncommitted changes temporary:

```vim
:Git stash          " Save changes
:Git stash list     " See stashed changes
:Git stash pop      " Restore latest stash
:Git stash show     " Show latest stash diff
```

Useful for:
- Switching branches with uncommitted work
- Saving "work in progress" temporarily

## Remote Operations

### Push

```vim
:Git push           " Push current branch
:Git push origin <branch>  " Push specific branch
```

With vim-rhubarb, you can also:
- `:GBrowse` - Open GitHub PR page
- `:GBrowse!` - Copy GitHub URL

### Pull

```vim
:Git pull           " Pull current branch
:Git fetch          " Fetch without merging
```

### Rebase

```vim
:Git rebase main    " Rebase on main
:Git rebase -i HEAD~5  " Interactive rebase last 5 commits
```

## Viewing Diffs

### Current buffer vs staged

```vim
:Git diff %         " Diff current file
:Git diff           " Diff all changes
:Git diff --cached  " Diff staged changes
```

### Between branches

```vim
:Git diff main      " Diff current branch vs main
:Git diff <branch1> <branch2>  " Diff any two branches
```

In diff view:
- `do` - Get from left (original)
- `dp` - Put to right (modified)
- `[c` / `]c` - Navigate diff hunks

## Commit History

### View log

```vim
:Git log            " Show git log
:Git log --graph    " Show with branch graph
:Git log -p         " Show with patches (diffs)
```

### In Flog view

Press `<leader>gl` for interactive history browser:
- Navigate commits with arrow keys
- View commit details
- See branch graph
- `<CR>` to open commit
- `q` to quit

## Blaming (Who Changed What)

```vim
:Git blame          " Show blame for current file
```

Shows commit hash and author for each line.

## Cherry-pick Commits

```vim
:Git cherry-pick <commit>   " Apply commit from another branch
:Git cherry-pick -n <commit> " Apply without auto-committing
```

Useful for:
- Applying hotfixes from one branch to another
- Selectively applying commits

## Worktrees (Advanced)

Work on multiple branches simultaneously:

```vim
:Git worktree add <path> <branch>   " Create worktree
:Git worktree list                   " List worktrees
:Git worktree remove <path>          " Remove worktree
```

Creates a separate directory for each branch so you can work on multiple branches at once.

## Tags

```vim
:Git tag <tagname>              " Create tag
:Git tag -d <tagname>           " Delete tag
:Git push origin <tagname>      " Push tag
:Git show <tagname>             " Show tagged commit
```

## Debugging Git Operations

### See all commands executed

```vim
:verbose Git <command>
```

Shows details of what's happening.

### Check git config

```vim
:Git config --list         " Show all config
:Git config user.name      " Show specific setting
```

## Integration with LSP

Git changes are shown in gutter alongside LSP diagnostics:
- Green/yellow/red bars = Git changes
- Red X = LSP error
- Orange ! = LSP warning
- Cyan = LSP info

Both integrate seamlessly in the gutter.

## Tips & Tricks

### 1. Stage entire file

```vim
:Git add %              " Stage current file
:Git add .              " Stage all changes
```

### 2. Unstage changes

```vim
:Git reset %            " Unstage current file
:Git reset HEAD         " Unstage all
```

### 3. Undo last commit (keep changes)

```vim
:Git reset --soft HEAD~ " Undo commit, keep staged
:Git reset --mixed HEAD~ " Undo commit, unstage
```

### 4. View what you're about to commit

```vim
:Git diff --cached      " Show staged changes
```

### 5. Amend last commit

```vim
:Git commit --amend     " Add to last commit
```

### 6. Force push (dangerous!)

```vim
:Git push --force       " Overwrite remote (use with caution)
```

## Common Workflows

### Feature Branch Workflow

```vim
1. :Git checkout -b feature/my-feature
2. Make changes...
3. [c / ]c to navigate changes
4. <leader>hp to review hunks
5. :Git add <files>
6. :Git commit
7. :Git push origin feature/my-feature
8. Open PR on GitHub via :GBrowse
```

### Hotfix Workflow

```vim
1. :Git checkout main
2. :Git checkout -b hotfix/critical-bug
3. Fix the bug...
4. :Git add .
5. :Git commit -m "Fix: critical bug"
6. :Git push origin hotfix/critical-bug
7. :Git checkout main
8. :Git merge hotfix/critical-bug
9. :Git push origin main
```

### Interactive Rebase for Clean History

```vim
1. :Git rebase -i HEAD~5    " Last 5 commits
2. Edit interactive rebase:
   - squash commits together
   - reword commit messages
   - drop unwanted commits
3. Resolve any conflicts
4. :Git push --force        " Update remote
```

## Performance Notes

- Gitsigns updates in real-time (may slow down on huge repos)
- Flog is performant but large histories can be slow
- Fugitive is instant (no background processes)

For large repositories, consider:
- Disabling gitsigns signs (keep hunks)
- Using fuzzy git log instead of Flog

## Troubleshooting

### Git not found

Check git is installed:
```vim
:!git --version
```

### Conflicts not showing

Ensure git-conflict.nvim is loaded:
```vim
:Lazy
```

Search for git-conflict.

### Flog not working

Requires at least one commit. If you're on a new repo:
```vim
:Git add .
:Git commit -m "Initial commit"
:Git log
```

### Slow git operations

Check git config:
```vim
:Git gc
```

Garbage collects and optimizes git repository.

## Resources

- [vim-fugitive](https://github.com/tpope/vim-fugitive)
- [vim-rhubarb](https://github.com/tpope/vim-rhubarb)
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
- [vim-flog](https://github.com/rbong/vim-flog)
- [git-conflict.nvim](https://github.com/akinsho/git-conflict.nvim)
- [Official Git Book](https://git-scm.com/book/en/v2)
