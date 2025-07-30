-- Set <space> as the leader key
-- See `:help mapleader`
-- NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Load configuration modules
require('config.lazy')      -- Package manager setup
require('config.init')      -- Core Neovim settings  
require('config.keymaps')   -- All keymaps
require('config.autocmds')  -- Autocommands

-- Load plugins (auto-discovers all plugin files)
-- This is handled by lazy.nvim setup in config.lazy