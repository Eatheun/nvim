return {
  "roobert/palette.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("util.palette_reload").apply()
  end,
}
