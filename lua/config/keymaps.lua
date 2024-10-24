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

-- Java tools
keymap.set("n", "<leader>jr", "<cmd> JavaRunnerRunMain <CR>", { desc = "Run Java main" })
keymap.set("n", "<leader>jdc", "<cmd> JavaTestDebugCurrentClass <CR>", { desc = "Debug Java class" })
keymap.set("n", "<leader>jdm", "<cmd> JavaTestDebugCurrentMethod <CR>", { desc = "Debug Java method" })
keymap.set("n", "<leader>jtc", "<cmd> JavaTestRunCurrentClass <CR>", { desc = "Test Java class" })
keymap.set("n", "<leader>jtm", "<cmd> JavaTestRunCurrentMethod <CR>", { desc = "Test Java method" })
keymap.set("n", "<leader>jtv", "<cmd> JavaTestViewLastReport <CR>", { desc = "View last Java test" })

-- Debugging
keymap.set("n", "<F5>", function()
  require("dap").continue()
end)
keymap.set("n", "<F10>", function()
  require("dap").step_over()
end)
keymap.set("n", "<F11>", function()
  require("dap").step_into()
end)
keymap.set("n", "<F12>", function()
  require("dap").step_out()
end)
keymap.set("n", "<leader>b", function()
  require("dap").toggle_breakpoint()
end)
