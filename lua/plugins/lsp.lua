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

      -- Add cmp_nvim_lsp capabilities settings as the base config for every server
      -- This should be executed before you configure any language server
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      vim.lsp.config("*", { capabilities = capabilities })

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

        html = {
          filetypes = { "html", "njk", "jinja" },
        },

        -- TypeScript/JavaScript handled by typescript-tools.nvim instead of
        -- ts_ls directly -- running both attaches two LSP clients per buffer.

        marksman = {
          filetypes = { "markdown", "markdown.mdx" },
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

        -- Python: pyright handles types/hover/goto, ruff handles lint + format
        ruff = {
          init_options = {
            settings = {
              hover = false, -- avoid duplicate hover popups with pyright
              lineLength = 120,
            },
          },
        },
      }

      local server_list = {
        "lua_ls",
        "cssls",
        "emmet_ls",
        "html",
        "marksman",
        "pyright",
        "ruff",
        "rust_analyzer",
        "tailwindcss",
      }

      -- apply per-server overrides (capabilities already set as the '*' base above)
      for server_name, cfg in pairs(servers) do
        vim.lsp.config(server_name, cfg)
      end

      require("mason-lspconfig").setup({
        ensure_installed = server_list,
        -- automatic_enable would auto-attach ANY mason-installed server
        -- matching the filetype, not just the ones in server_list above --
        -- caused a stale leftover pylsp install to silently race ruff for
        -- python formatting requests. We enable exactly server_list instead.
        automatic_enable = false,
      })

      vim.lsp.enable(server_list)
    end,
  },
}
