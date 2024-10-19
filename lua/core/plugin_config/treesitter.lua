return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	opts = {

		-- A list of parser name, or "all"
		ensure_installed = {
			"c",
			"json",
			"javascript",
			"typescript",
			"tsx",
			"html",
			"css",
			"lua",
			"java",
			"python",
			"vim",
			"gitignore",
		},

		-- Install parsers synchronously (only applied to `ensure_installed`)
		sync_install = false,
		auto_install = true,
		highlight = {
			enable = true,
		},
		indent = {
			enable = true,
		},
		autotag = {
			enable = true,
		},
	},
}
