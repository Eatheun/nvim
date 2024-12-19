-- Autocompletion
return {
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    keys = function()
      return {}
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.mapping = cmp.mapping({
        ["<Tab>"] = cmp.mapping.confirm({ select = true }),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-k>"] = cmp.mapping.select_prev_item(),
      })
    end,
    -- opts = function(_, opts)
    --   local cmp = require("cmp")
    --   opts.mapping = vim.tbl_deep_extend("force", opts.mapping, {
    --     ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    --     ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    --     ["<Tab>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    --   })
    -- end,
    event = "InsertEnter",
    enabled = true,
    -- config = function()
    --   local cmp = require("cmp")
    --   local luasnip = require("luasnip")
    --
    --   require("luasnip.loaders.from_vscode").lazy_load()
    --
    --   cmp.setup({
    --     snippet = {
    --       expand = function(args)
    --         luasnip.lsp_expand(args.body)
    --       end,
    --     },
    --
    --     opts = {
    --       mapping = cmp.mapping.preset.insert({
    --         ["<C-k>"] = cmp.mapping.select_prev_item(),
    --         ["<C-j>"] = cmp.mapping.select_next_item(),
    --         ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    --         ["<C-f>"] = cmp.mapping.scroll_docs(4),
    --         ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestion
    --         ["<C-e>"] = cmp.mapping.abort(), -- close completion window
    --         ["<Tab>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    --       }),
    --
    --       sources = cmp.config.sources({
    --         { name = "luasnip" },
    --         { name = "nvim_lua" },
    --         { name = "buffer" },
    --         { name = "path" },
    --       }),
    --     },
    --   })
    -- end,
  },
}
