return {
  "OXY2DEV/markview.nvim",
  ft = { "markdown", "markdown.mdx", "quarto", "rmd" },
  opts = {
    preview = {
      filetypes = { "markdown", "markdown.mdx", "quarto", "rmd" },
      modes = { "n", "v" }, -- render in normal and visual mode
      hybrid_modes = { "n" }, -- render + edit in normal mode, plain source in insert
      icon_provider = "devicons", -- match nvim-web-devicons used elsewhere (bufferline)
    },
  },
}
