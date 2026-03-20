return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    -- Snippet Engine & its associated nvim-cmp source
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',

    -- Adds completion capabilities
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',

    -- Adds a number of user-friendly snippets
    'rafamadriz/friendly-snippets',

    -- Adds icons for completion kinds
    'onsails/lspkind.nvim',
  },
  config = function()
    -- See `:help cmp`
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    require('luasnip.loaders.from_vscode').lazy_load()
    luasnip.config.setup {}

    vim.api.nvim_set_hl(0, 'CmpBorder', { fg = '#665c54', bg = '#1d2021' })
    vim.api.nvim_set_hl(0, 'CmpDocBorder', { fg = '#665c54', bg = '#1d2021' })
    vim.api.nvim_set_hl(0, 'CmpPmenu', { bg = '#1d2021' })
    vim.api.nvim_set_hl(0, 'CmpDoc', { bg = '#1d2021' })
    vim.api.nvim_set_hl(0, 'CmpCursor', { bg = '#000000' })

    cmp.setup {
      window = {
        completion = cmp.config.window.bordered {
          border = 'rounded',
          side_padding = 0,
          col_offset = 0,
          winhighlight = 'Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:CmpCursor,Search:None',
        },
        documentation = cmp.config.window.bordered {
          border = 'rounded',
          winhighlight = 'Normal:CmpDoc,FloatBorder:CmpDocBorder,Search:None',
        },
      },
      formatting = {
        fields = { 'abbr', 'icon', 'menu' },
        format = require('lspkind').cmp_format {
          mode = 'symbol',
          maxwidth = 50,
          ellipsis_char = '...',
          before = function(_, vim_item)
            -- vim_item.abbr = " " .. vim_item.abbr .. "  "
            return vim_item
          end,
        },
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-h>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete {},
        ['<C-l>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        ['<Down>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<Up>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      },
      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
      },
    }
  end,
}
