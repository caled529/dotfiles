------------------------------- ON LOAD AUTOCMDS -------------------------------
local on_load_autocmds = vim.api.nvim_create_augroup("On-load auto-commands", { clear = true })

-- LOAD FOLDS ON LOAD
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	desc = "Open all folds on buffer load",
	callback = function()
		vim.cmd(":silent! :loadview")
	end,
	group = on_load_autocmds,
})

------------------------------- ON SAVE AUTOCMDS -------------------------------
local on_save_autocmds = vim.api.nvim_create_augroup("On-write auto-commands", { clear = true })

-- AUTO-FORMAT ON SAVE
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = { "*.c", "*.cpp", "*.java" },
	desc = "Auto-format files supported by clang-format after saving",
	callback = function()
		local fileName = vim.api.nvim_buf_get_name(0)
		vim.cmd(':silent :!clang-format -i "' .. fileName .. '"')
	end,
	group = on_save_autocmds,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = { "*.go" },
	desc = "Auto-format Go files after saving",
	callback = function()
		local fileName = vim.api.nvim_buf_get_name(0)
		vim.cmd(':silent :!gofmt -w "' .. fileName .. '"')
	end,
	group = on_save_autocmds,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = { "*.lua", "*.luau" },
	desc = "Auto-format Lua files after saving",
	callback = function()
		local fileName = vim.api.nvim_buf_get_name(0)
		vim.cmd(":silent :!stylua " .. fileName)
	end,
	group = on_save_autocmds,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = { "*.md" },
	desc = "Auto-format markdown files after saving",
	callback = function()
		local fileName = vim.api.nvim_buf_get_name(0)
		vim.cmd(":silent :!mdformat " .. fileName)
	end,
	group = on_save_autocmds,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = { "*.py" },
	desc = "Auto-format Python files after saving",
	callback = function()
		local fileName = vim.api.nvim_buf_get_name(0)
		vim.cmd(':silent :!black --preview -q "' .. fileName .. '"')
	end,
	group = on_save_autocmds,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = { "*.zig" },
	desc = "Auto-format Zig files after saving",
	callback = function()
		local fileName = vim.api.nvim_buf_get_name(0)
		vim.cmd(":silent :!zig fmt " .. fileName)
	end,
	group = on_save_autocmds,
})

------------------------------- ON EXIT AUTOCMDS -------------------------------
local on_close_autocmds = vim.api.nvim_create_augroup("On-close auto-commands", { clear = true })

-- SAVE FOLDS ON EXIT
vim.api.nvim_create_autocmd({ "BufWinLeave" }, {
	desc = "Save folds on buffer exit",
	callback = function()
		vim.cmd(":silent! :mkview")
	end,
	group = on_close_autocmds,
})
