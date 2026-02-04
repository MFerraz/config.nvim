-- Plugin loader - automatically loads all plugin modules
-- This file serves as the entry point for all plugin configurations

return {
  -- AI (auto complete and agents)
  require('plugins.ai.sidekick'),

  -- Core plugins (essential functionality)
  require('plugins.core.lsp'),
  require('plugins.core.completion'),
  require('plugins.core.treesitter'),
  require('plugins.core.telescope'),

  -- UI plugins (appearance and interface)
  require('plugins.ui.colorscheme'),
  require('plugins.ui.statusline'),
  require('plugins.ui.icons'),
  require('plugins.ui.snacks'),
  require('plugins.ui.markdown'),

  -- Git plugins (version control)
  require('plugins.git.gitsigns'),
  require('plugins.git.fugitive'),
  require('plugins.git.conflicts'),

  -- Editor plugins (editing enhancements)
  require('plugins.editor.oil'),
  require('plugins.editor.comment'),
  require('plugins.editor.which-key'),

  -- Optional plugins (can be commented out)
  -- require('plugins.optional.debug'),
  -- require('plugins.optional.autoformat'),

  -- Basic plugins that don't need configuration
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
}
