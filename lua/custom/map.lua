-- Toggle file tree
vim.keymap.set('n', '<leader>v', ':CHADopen<CR>', { desc = '[V] Toggle file tree' })

-- LSP 
-- Format file
vim.keymap.set('n','<leader>f', ':Format<CR>', {desc = '[F]ormat'})

-- QoL
-- Keep cursor at center of screen
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Leap
require('leap').add_default_mappings()
