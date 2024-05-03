local opt = vim.opt
local g = vim.g

opt.nu = true
opt.relativenumber = true

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

opt.smartindent = true

opt.wrap = false

opt.hlsearch = false
opt.incsearch = true

opt.termguicolors = true

opt.scrolloff = 8
opt.signcolumn = "yes"
opt.isfname:append("@-@")

opt.updatetime = 50

opt.colorcolumn = "80"

g.mapleader = " "
g.maplocalleader = " "

opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 20
function _G.BetterFoldText()
	return vim.fn.getline(vim.v.foldstart) .. "..." .. vim.fn.getline(vim.v.foldend):gsub("%s+", "")
end
opt.foldtext = "v:lua.BetterFoldText()"
vim.opt.fillchars:append({ fold = " " })

opt.undofile = true
