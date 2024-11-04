return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hint = { enable = false },
    servers = {
      jdtls = {
        -- your jdtls configuration goes here
        handlers = {
          -- By assigning an empty function, you can remove the notifications
          -- printed to the cmd
          ["$/progress"] = function(_, result, ctx) end,
        },
      },
    },
    setup = {
      jdtls = function()
        require("java").setup({
          -- your nvim-java configuration goes here
        })
      end,
    },
  },
}
