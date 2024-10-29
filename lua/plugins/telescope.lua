return {
  "nvim-telescope/telescope.nvim",
  version = "0.1.8",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-live-grep-args.nvim",
      version = "^1.0.0",
    },
  },
  config = function()
    local telescope = require("telescope")
    telescope.setup({})
    telescope.load_extension("live_grep_args")

    local builtin = require("telescope.builtin")
    local keymap = vim.keymap

    keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
    keymap.set("n", "<Space><Space>", builtin.oldfiles, { desc = "Find old files" })
    keymap.set(
      "n",
      "<leader>fg",
      "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
      { desc = "Live grep" }
    )
    keymap.set(
      "n",
      "<leader>gw",
      require("telescope-live-grep-args.shortcuts").grep_word_under_cursor,
      { desc = "grep word under cursor" }
    )
    keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
  end,
}
