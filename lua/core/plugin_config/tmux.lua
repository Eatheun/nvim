return {
	{
		"aserowy/tmux.nvim",
		config = function() return require("tmux").setup() end
	},
	{ "christoomey/vim-tmux-navigator", }
}
