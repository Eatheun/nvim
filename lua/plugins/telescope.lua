return {
  "nvim-telescope/telescope.nvim",
  version = "0.2.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "folke/snacks.nvim",
    {
      "nvim-telescope/telescope-live-grep-args.nvim",
      version = "^1.0.0",
    },
  },
  config = function()
    local telescope = require("telescope")
    local previewers = require("telescope.previewers")
    local default_file_previewer = previewers.buffer_previewer_maker

    -- Route image files through Snacks.image (Kitty graphics protocol) instead
    -- of Telescope's default text previewer, which just prints "Binary cannot
    -- be previewed" for anything non-text. Needs kitty >= 0.36 and tmux >= 3.4
    -- with allow-passthrough on, otherwise supports() is false and we fall back.
    local function image_aware_previewer_maker(filepath, bufnr, opts)
      if Snacks.image.supports(filepath) then
        Snacks.image.placement.new(bufnr, filepath, { auto_resize = true })
        if opts and opts.callback then
          opts.callback(bufnr)
        end
        return
      end
      default_file_previewer(filepath, bufnr, opts)
    end

    telescope.setup({
      defaults = {
        buffer_previewer_maker = image_aware_previewer_maker,
      },
    })
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
