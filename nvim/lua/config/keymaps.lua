vim.keymap.set("n", "<leader>fe", "<Plug>VinegarUp")

vim.keymap.set("n", "<C-w>sh", ":Vex<CR>")
vim.keymap.set("n", "<C-w>sj", ":Hex<CR>")
vim.keymap.set("n", "<C-w>sk", ":Hex!<CR>")
vim.keymap.set("n", "<C-w>sl", ":Vex!<CR>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "Q", "<nop>")

-- yank to system clipboard
vim.keymap.set("n", "<leader>y", '"+y')

-- dap
local dap = require("dap")
vim.keymap.set("n", "<leader>dc", dap.continue)
vim.keymap.set("n", "<C-n>", dap.step_over)
vim.keymap.set("n", "<leader>dsi", dap.step_into)
vim.keymap.set("n", "<leader>dso", dap.step_out)
vim.keymap.set("n", "<leader>dt", dap.terminate)
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
vim.keymap.set("n", "<Leader>dr", dap.repl.open)
-- vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
-- vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)

-- vim-fugitive
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

-- lsp-zero
vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition)
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_next)
vim.keymap.set("n", "]d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>rf", vim.lsp.buf.references)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)

-- telescope
local builtin = require("telescope.builtin")

-- had to do this to get telescope to find better root directories
local find_root_dir = function()
	local root_dir
	-- ask active language server on current buffer for root_dir
	local cur_buffer_lsp_clients = vim.lsp.get_active_clients({ bufnr = vim.api.nvim_buf_get_number(0) })
	for _, _ in pairs(cur_buffer_lsp_clients) do -- check >=1 language server returned
		root_dir = cur_buffer_lsp_clients[1].config.root_dir
		break
	end
	-- if root_dir not obtained from the language server, look for it
	if root_dir == nil then
		-- files that indicate the root of a project
		local root_files = {
			".git",
			"mod.go",
			"build.zig",
		}
		local found_roots = vim.fs.find(root_files, {
			limit = 1, -- this is the default but this makes it clearer at a glance
			upward = true,
			stop = vim.loop.os_homedir(), -- projects should be living under home directory
			path = vim.fs.dirname(vim.api.nvim_buf_get_name(0)),
		})
		for _, _ in pairs(found_roots) do -- check >=1 root found
			root_dir = vim.fs.dirname(found_roots[1])
			break
		end
	end
	return root_dir
end

vim.keymap.set("n", "<leader>ff", function()
	local root_dir = find_root_dir()
	if root_dir ~= nil then
		builtin.find_files({
			cwd = root_dir,
		})
	else -- if root_dir cannot be found just let telescope figure it out
		builtin.find_files()
	end
end)
vim.keymap.set("n", "<leader>gf", builtin.git_files, {})
vim.keymap.set("n", "<leader>fs", function()
	local root_dir = find_root_dir()
	if root_dir ~= nil then
		builtin.live_grep({
			cwd = root_dir,
		})
	else -- if root_dir cannot be found just let telescope figure it out
		builtin.live_grep()
	end
end)

-- undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
