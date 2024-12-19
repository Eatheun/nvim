return {
  "barrett-ruth/live-server.nvim",
  lazy = false,
  build = "npm install -g live-server",
  cmd = { "LiveServerStart", "LiveServerStop" },
  config = function()
    require("live-server").setup({})
  end,
}
