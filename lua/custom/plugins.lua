-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- Git related plugins
  'rbong/vim-flog',
  {'akinsho/git-conflict.nvim', version = "*", config = true},

  -- Auto complete
  'github/copilot.vim',

  -- Files
  'stevearc/oil.nvim',
}
