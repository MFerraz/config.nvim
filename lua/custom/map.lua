-- Toggle file tree
vim.keymap.set('n', '<leader>v', ':CHADopen<CR>', { desc = '[V] Toggle file tree' })

-- LSP
-- Format file
vim.keymap.set('n', '<leader>f', ':Format<CR>', { desc = '[F]ormat' })

-- QoL
-- Keep cursor at center of screen
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
-- Move lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- Paste without losing register
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = '[P]aste and keep register' })
-- Yank to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = '[Y]ank to system clipboard' })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = '[Y]ank to system clipboard' })
-- Delete to void
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = '[D]elete to void' })
-- Make Q do nothing
vim.keymap.set("n", "Q", "<Nop>")
-- Quickfix navigation
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = '[K] Next location' })
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = '[J] Previous location' })

-- tmux
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- Buffers
require('which-key').add({
  { '<leader>b', group = '[B]uffer' },
  { '<leader>b_', hidden = true },
})
vim.keymap.set("n", "<leader>bd", ":bd<CR>", { desc = '[B]uffer [D]etach' })
vim.keymap.set("n", "<leader>bn", ":bn<CR>", { desc = '[B]uffer [N]ext' })

-- Files
vim.keymap.set('n', '<leader>v', ':Neotree<CR>', { desc = '[V] Open tree explorer' })

-- Git
require('which-key').add({
  { '<leader>g', group = '[G]it' },
  { '<leader>g_', hidden = true },
  { '<leader>gc', group = '[G]it [C]onflict' },
  { '<leader>gc_', hidden = true },
})
vim.keymap.set('n', '<leader>gs', ':Neotree git_status<CR>', { desc = '[G]it [S]tatus on file explorer' })
vim.keymap.set('n', '<leader>gl', ':Flog<CR>', { desc = '[G]it [L]og' })
vim.keymap.set('n', '<leader>gco', ':GitConflictChooseOurs<CR>:GitConflictNextConflict<CR>', { desc = '[G]it [C]onflict Choose [O]urs' })
vim.keymap.set('n', '<leader>gct', ':GitConflictChooseTheirs<CR>:GitConflictNextConflict<CR>', { desc = '[G]it [C]onflict Choose [T]heirs' })
vim.keymap.set('n', '<leader>gcq', ':GitConflictListQf<CR>', { desc = '[G]it [C]onflict [Q]uickfix' })

-- Oil
vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory as buffer' })
