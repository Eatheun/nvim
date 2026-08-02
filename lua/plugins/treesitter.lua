local parsers = {
  "c",
  "json",
  "javascript",
  "typescript",
  "tsx",
  "html",
  "css",
  "lua",
  "markdown",
  "java",
  "python",
  "vim",
  "gitignore",
  "dockerfile",
  "bash",
}

local filetypes = {
  "c",
  "json",
  "javascript",
  "typescript",
  "typescriptreact",
  "html",
  "css",
  "lua",
  "markdown",
  "java",
  "python",
  "vim",
  "gitignore",
  "dockerfile",
  "sh",
}

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  lazy = false,
  config = function()
    require("nvim-treesitter").install(parsers)

    vim.api.nvim_create_autocmd("FileType", {
      pattern = filetypes,
      callback = function(args)
        vim.treesitter.start(args.buf)
      end,
    })
  end,
}
