return {
  "pmizio/typescript-tools.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "neovim/nvim-lspconfig",
  },
  opts = {},
  config = function()
    require("typescript-tools").setup({})

    -- Keymaps
    local keymap = vim.keymap
    keymap.set(
      "n",
      "<leader>tso",
      "<cmd> TSToolsOrganizeImports <CR>",
      { noremap = true, desc = "Organise and clean imports" }
    )
    keymap.set(
      "n",
      "<leader>tsa",
      "<cmd> TSToolsAddMissingImports <CR>",
      { noremap = true, desc = "Adds missing imports" }
    )
    keymap.set(
      "n",
      "<leader>tsr",
      "<cmd> TSToolsRenameFile <CR>",
      { noremap = true, desc = "Rename file and update other files" }
    )
    keymap.set(
      "n",
      "<leader>tsgd",
      "<cmd> TSToolsGoToSourceDefinition <CR>",
      { noremap = true, desc = "Get source definition" }
    )
    keymap.set(
      "n",
      "<leader>tsfr",
      "<cmd> TSToolsFileReferences <CR>",
      { noremap = true, desc = "Find files referencing current" }
    )
  end,
}
