return {
  "nvim-java/nvim-java",
  config = false,
  dependencies = {
    {
      "neovim/nvim-lspconfig",
      opts = {
        servers = {
          jdtls = {
            handlers = {
              -- By assigning an empty function, you can remove the notifications
              -- printed to the cmd
              ["$/progress"] = function(_, result, ctx) end,
            },
          },
        },
        setup = {
          jdtls = function()
            require("java").setup({})
          end,
        },
      },
    },
  },
}
