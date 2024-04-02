vim.keymap.set("n", "<leader>fe", "<Plug>VinegarUp")

vim.keymap.set("n", "<C-w>sh", ":Vex<CR>")
vim.keymap.set("n", "<C-w>sj", ":Hex<CR>")
vim.keymap.set("n", "<C-w>sk", ":Hex!<CR>")
vim.keymap.set("n", "<C-w>sl", ":Vex!<CR>")

vim.keymap.set("n", "<leader>tr", function()
	vim.cmd("term " .. vim.fn.input("Terminal > "))
	vim.cmd('call feedkeys("a")')
end)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "Q", "<nop>")

-- dap
vim.keymap.set("n", "<leader>dc", function()
	require("dap").continue()
end)
vim.keymap.set("n", "<C-n>", function()
	require("dap").step_over()
end)
vim.keymap.set("n", "<leader>dsi", function()
	require("dap").step_into()
end)
vim.keymap.set("n", "<leader>dso", function()
	require("dap").step_out()
end)
vim.keymap.set("n", "<leader>db", function()
	require("dap").toggle_breakpoint()
end)
-- vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
-- vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
-- vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)

-- vim-fugitive
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

-- lsp-zero
vim.keymap.set("n", "<leader>gd", function()
	vim.lsp.buf.definition()
end)
vim.keymap.set("n", "K", function()
	vim.lsp.buf.hover()
end)
vim.keymap.set("n", "<leader>vd", function()
	vim.diagnostic.open_float()
end)
vim.keymap.set("n", "[d", function()
	vim.diagnostic.goto_next()
end)
vim.keymap.set("n", "]d", function()
	vim.diagnostic.goto_prev()
end)
vim.keymap.set("n", "<leader>ca", function()
	vim.lsp.buf.code_action()
end)
vim.keymap.set("n", "<leader>rf", function()
	vim.lsp.buf.references()
end)
vim.keymap.set("n", "<leader>rn", function()
	vim.lsp.buf.rename()
end)

-- telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>gf", builtin.git_files, {})
vim.keymap.set("n", "<leader>fs", function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

-- undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
