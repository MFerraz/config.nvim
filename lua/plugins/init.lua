-- Plugin loader - automatically loads all plugin modules
-- This file serves as the entry point for all plugin configurations

return {
  -- AI (auto complete and agents)
  require 'plugins.ai.opencode',
  require 'plugins.ai.neocodeium',

  -- Core plugins (essential functionality)
  require 'plugins.core.lsp',
  require 'plugins.core.completion',
  require 'plugins.core.treesitter',
  require 'plugins.core.telescope',

  -- UI plugins (appearance and interface)
  require 'plugins.ui.colorscheme',
  require 'plugins.ui.statusline',
  require 'plugins.ui.icons',
  require 'plugins.ui.snacks',
  require 'plugins.ui.markdown',
  require 'plugins.ui.noice',
  require 'plugins.ui.colorize',

  -- Git plugins (version control)
  require 'plugins.git.gitsigns',
  require 'plugins.git.fugitive',
  require 'plugins.git.conflicts',

  -- Editor plugins (editing enhancements)
  require 'plugins.editor.comment',
  require 'plugins.editor.which-key',
  require 'plugins.editor.vim-sleuth',

  -- Apps (additional functionality)
  require 'plugins.apps.oil', -- File manager
  require 'plugins.apps.dadbodgrip', -- Database viewer

  -- Optional plugins (can be commented out)
  -- require('plugins.optional.debug'), -- Debugging
  -- require('plugins.optional.autoformat'), -- Code formatting
  -- require('plugins.optional.cursor'), -- Cursor movement animation
}
