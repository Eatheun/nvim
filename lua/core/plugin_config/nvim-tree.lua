return {
	"nvim-tree/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		require("nvim-tree").setup {
			view = {
				width = 35,
				number = true,
				relativenumber = true,
			},
			git = {
				ignore = false,
			},
		}

		local keymap = vim.keymap

		keymap.set('n', '<leader>ee', ':NvimTreeToggle<CR>')
		keymap.set('n', '<leader>ef', ':NvimTreeFindFileToggle<CR>')
		keymap.set('n', '<leader>er', ':NvimTreeRefresh<CR>')
	end,
}
