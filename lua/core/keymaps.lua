local keymap = vim.keymap
keymap.set("n", "<leader>h", ":nohlsearch<CR>")

-- Tab commands
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to prev tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open tab with buffer" })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

-- Terminal commands
keymap.set("n", "<leader>nt", "<cmd>edit term://bash<CR>", { desc = "Open new terminal" })
keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

-- Java debugging
keymap.set("n", "<leader>co", "<Cmd>lua require'jdtls'.organize_imports()<CR>", { desc = "Organize Imports" })
keymap.set("n", "<leader>crv", "<Cmd>lua require('jdtls').extract_variable()<CR>", { desc = "Extract Variable" })
keymap.set(
	"v",
	"<leader>crv",
	"<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>",
	{ desc = "Extract Variable" }
)
keymap.set("n", "<leader>crc", "<Cmd>lua require('jdtls').extract_constant()<CR>", { desc = "Extract Constant" })
keymap.set(
	"v",
	"<leader>crc",
	"<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>",
	{ desc = "Extract Constant" }
)
keymap.set("v", "<leader>crm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", { desc = "Extract Method" })

-- Debugging
keymap.set("n", "<leader>jtc", "<Cmd> lua require'jdtls'.test_class()<CR>", { desc = "Test current class" })
keymap.set("n", "<leader>jtm", "<Cmd> lua require'jdtls'.test_nearest_method()<CR>", { desc = "Test nearest method" })
keymap.set("n", "<leader>b", "<Cmd> lua require('dap').toggle_breakpoint()<CR>")
