local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

------------------------------- ON LOAD AUTOCMDS -------------------------------
local on_load_autocmds = augroup("On-load auto-commands", { clear = true })

autocmd({ "BufWinEnter" }, {
	desc = "Open all folds on buffer load",
	callback = function()
		vim.cmd(":silent! :loadview")
	end,
	group = on_load_autocmds,
})

------------------------------- ON SAVE AUTOCMDS -------------------------------
local on_save_autocmds = augroup("On-write auto-commands", { clear = true })

autocmd({ "BufWritePost" }, {
	pattern = { "*.c", "*.cpp", "*.java" },
	desc = "Auto-format files supported by clang-format after saving",
	callback = function()
		local fileName = vim.api.nvim_buf_get_name(0)
		vim.cmd(':silent :!clang-format -i "' .. fileName .. '"')
	end,
	group = on_save_autocmds,
})

autocmd({ "BufWritePost" }, {
	pattern = { "*.go" },
	desc = "Auto-format Go files after saving",
	callback = function()
		local fileName = vim.api.nvim_buf_get_name(0)
		vim.cmd(':silent :!gofmt -w "' .. fileName .. '"')
	end,
	group = on_save_autocmds,
})

autocmd({ "BufWritePost" }, {
	pattern = { "*.lua", "*.luau" },
	desc = "Auto-format Lua files after saving",
	callback = function()
		local fileName = vim.api.nvim_buf_get_name(0)
		vim.cmd(":silent :!stylua " .. fileName)
	end,
	group = on_save_autocmds,
})

autocmd({ "BufWritePost" }, {
	pattern = { "*.md" },
	desc = "Auto-format Markdown files after saving",
	callback = function()
		local fileName = vim.api.nvim_buf_get_name(0)
		vim.cmd(":silent :!mdformat " .. fileName)
	end,
	group = on_save_autocmds,
})

autocmd({ "BufWritePost" }, {
	pattern = { "*.nix" },
	desc = "Auto-format Nix files after saving",
	callback = function()
		local fileName = vim.api.nvim_buf_get_name(0)
		vim.cmd(":silent :!alejandra " .. fileName)
	end,
	group = on_save_autocmds,
})

autocmd({ "BufWritePost" }, {
	pattern = { "*.ml", "*.mli" },
	desc = "Auto-format OCaml files after saving",
	callback = function()
		local fileName = vim.api.nvim_buf_get_name(0)
		vim.cmd(":silent :!ocamlformat -i " .. fileName)
	end,
	group = on_save_autocmds,
})

autocmd({ "BufWritePost" }, {
	pattern = { "*.py" },
	desc = "Auto-format Python files after saving",
	callback = function()
		local fileName = vim.api.nvim_buf_get_name(0)
		vim.cmd(':silent :!black --preview -q "' .. fileName .. '"')
	end,
	group = on_save_autocmds,
})

autocmd({ "BufWritePost" }, {
	pattern = { "*.zig" },
	desc = "Auto-format Zig files after saving",
	callback = function()
		local fileName = vim.api.nvim_buf_get_name(0)
		vim.cmd(":silent :!zig fmt " .. fileName)
	end,
	group = on_save_autocmds,
})

------------------------------- ON EXIT AUTOCMDS -------------------------------
local on_close_autocmds = augroup("On-close auto-commands", { clear = true })

autocmd({ "BufWinLeave" }, {
	desc = "Save folds on buffer exit",
	callback = function()
		vim.cmd(":silent! :mkview")
	end,
	group = on_close_autocmds,
})

------------------------------------ OTHER -------------------------------------

autocmd({ "TextYankPost" }, {
	desc = "Briefly highlight yanked text",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 250 })
	end,
})
