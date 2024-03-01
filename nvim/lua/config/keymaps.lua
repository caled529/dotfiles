vim.keymap.set("n", "<leader>fe", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "Q", "<nop>")

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
