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

-- Buffers
require('which-key').register({
  ['<leader>b'] = { name = '[B]uffer', _ = 'which_key_ignore' },
})
vim.keymap.set("n", "<leader>bd", ":bd<CR>", { desc = '[B]uffer [D]etach' })
vim.keymap.set("n", "<leader>bn", ":bn<CR>", { desc = '[B]uffer [N]ext' })

-- Leap
require('leap').add_default_mappings()

-- Files
vim.keymap.set('n', '<leader>v', ':Neotree<CR>', { desc = '[V] Open tree explorer' })

-- Git
vim.keymap.set('n', '<leader>gs', ':Neotree git_status<CR>', { desc = '[G]it [S]tatus on file explorer' })
vim.keymap.set('n', '<leader>gl', ':Flog<CR>', { desc = '[G]it [L]og' })
