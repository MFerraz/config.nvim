-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- Git related plugins
  'rbong/vim-flog',

  -- Auto complete
  'github/copilot.vim',

  -- Motion and QoL
  'ggandor/leap.nvim',

  -- Files
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require('neo-tree').setup({
        default_component_configs = {
          icon = {
            folder_closed = "",
            folder_open = "",
            default = "",
          },
        },
        window = {
          position = "float",
        }
      })
    end
  },
  'stevearc/oil.nvim',

  -- Markdown
  {
    "iamcco/markdown-preview.nvim",
    build = function() vim.fn["mkdp#util#install"]() end,
    init = function() vim.g.mkdp_filetypes = { "markdown" } end,
    ft = { "markdown" },
  },
}
