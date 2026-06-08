return {
  {
    "mason-org/mason.nvim",
    lazy = false,
    opts = {},
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    cmd = { "LspInfo", "LspInstall", "LspStart" },
    event = { "InsertEnter", "BufReadPre", "BufNewFile" },
    dependencies = {
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lsp-signature-help" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "mason-org/mason.nvim" },
      { "mason-org/mason-lspconfig.nvim" },
    },
    init = function()
      -- Reserve a space in the gutter
      -- This will avoid an annoying layout shift in the screen
      vim.opt.signcolumn = "yes"
    end,
    config = function()
      vim.filetype.add({
        extension = {
          jinja = "html",
          jinja2 = "html",
          j2 = "html",
          njk = "html",
          py = "python",
        },
      })

      local lsp_defaults = require("lspconfig").util.default_config

      -- Add cmp_nvim_lsp capabilities settings to lspconfig
      -- This should be executed before you configure any language server
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      lsp_defaults.capabilities = vim.tbl_deep_extend("force", lsp_defaults.capabilities, capabilities)

      -- LspAttach is where you enable features that only work
      -- if there is a language server active in the file
      local on_attach_func = function(event)
        local opts = { buffer = event.buf }

        vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
        vim.keymap.set("n", "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
        vim.keymap.set("n", "<leader>gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
        vim.keymap.set("n", "<leader>gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
        vim.keymap.set("n", "<leader>go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
        vim.keymap.set("n", "<leader>gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
        vim.keymap.set("n", "<leader>gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
        vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
        vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
        vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)

        -- i like hints (sometimes)
        vim.keymap.set(
          "n",
          "<leader>ld",
          "<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<cr>",
          opts
        )
      end
      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP actions",
        callback = on_attach_func,
      })

      -- Per-server overrides. Anything not listed uses the default config
      -- (on_attach + capabilities). capabilities is merged in for every server.
      local servers = {
        cssls = {
          filetypes = { "css", "sass", "scss", "less" },
        },

        emmet_ls = {
          filetypes = { "html", "typescriptreact", "javascript", "javascriptreact", "css", "sass", "scss", "less" },
        },

        lua_ls = {
          settings = {
            Lua = {
              -- make the language server recognize "vim" global
              diagnostics = { globals = { "vim" } },
              completion = { callSnippet = "Replace" },
            },
          },
        },

        -- Python: ignore E501 (line too long) from pycodestyle
        pylsp = {
          settings = {
            pylsp = {
              plugins = {
                pycodestyle = { ignore = { "E501" } },
              },
            },
          },
        },

        rust_analyzer = {
          filetypes = { "rs" },
        },

        tailwindcss = {
          init_options = {
            userLanguages = {
              njk = "html", -- Treat .njk files as html for Tailwind LSP
              jinja = "html", -- Treat .jinja files as html for Tailwind LSP
            },
          },
          filetypes = { "njk", "html", "css", "jinja" },
        },
      }

      require("mason-lspconfig").setup({
        ensure_installed = {
          "pylsp",
          "lua_ls",
          "cssls",
          "emmet_ls",
          "pyright",
          "rust_analyzer",
          "tailwindcss",
        },
        handlers = {
          -- default handler: applies to every server, merging any per-server override
          function(server_name)
            local config = vim.tbl_deep_extend("force", {
              on_attach = on_attach_func,
              capabilities = capabilities,
            }, servers[server_name] or {})
            vim.lsp.config[server_name].setup(config)
          end,
        },
      })
    end,
  },
}
