vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

opt.number = true
opt.relativenumber = true

opt.wrap = true
opt.backspace = "indent,eol,start"
opt.showcmd = true
opt.laststatus = 2
opt.autowrite = true
opt.cursorline = true
opt.autoread = true

opt.termguicolors = true
opt.background = "light"
opt.signcolumn = "yes"

opt.clipboard:append("unnamedplus")

opt.splitright = true
opt.splitbelow = true

opt.scrolloff = 0 -- sets the minimum number of lines after cursor
