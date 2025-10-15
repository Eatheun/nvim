return {
  {
    "williamboman/mason.nvim",
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
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
    },
    init = function()
      -- Reserve a space in the gutter
      -- This will avoid an annoying layout shift in the screen
      vim.opt.signcolumn = "yes"
    end,
    config = function()
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
      end
      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP actions",
        callback = on_attach_func,
      })

      require("mason-lspconfig").setup({
        ensure_installed = {
          "ts_ls",
          "pylsp",
          "lua_ls",
          "cssls",
          "graphql",
          "emmet_ls",
          "pyright",
          "clangd",
          "rust_analyzer",
        },
        handlers = {
          -- this first function is the "default handler"
          -- it applies to every language server without a "custom handler"
          function(server_name)
            require("lspconfig")[server_name].setup({
              on_attach = on_attach_func,
              capabilities = capabilities,
            })
          end,

          ["graphql"] = function()
            -- configure graphql language server
            require("lspconfig")["graphql"].setup({
              capabilities = capabilities,
              filetypes = { "graphql", "gql", "typescriptreact", "javascript", "javascriptreact" },
            })
          end,

          ["emmet_ls"] = function()
            -- configure emmet language server
            require("lspconfig")["emmet_ls"].setup({
              capabilities = capabilities,
              filetypes = { "html", "typescriptreact", "javascript", "javascriptreact", "css", "sass", "scss", "less" },
            })
          end,

          ["clangd"] = function()
            require("lspconfig")["clangd"].setup({
              capabilities = capabilities,
              filetypes = { "c", "cpp" },
            })
          end,

          ["lua_ls"] = function()
            -- configure lua server (with special settings)
            require("lspconfig")["lua_ls"].setup({
              capabilities = capabilities,
              settings = {
                Lua = {
                  -- make the language server recognize "vim" global
                  diagnostics = {
                    globals = { "vim" },
                  },
                  completion = {
                    callSnippet = "Replace",
                  },
                },
              },
            })
          end,

          ["rust_analyzer"] = function()
            require("lspconfig")["rust_analyzer"].setup({
              capabilities = capabilities,
              filetypes = { "rs" },
            })
          end,
        },
      })
    end,
  },
}
