return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			-- A list of parser names, or "all"
			ensure_installed = { "c", "go", "java", "lua", "python", "rust", "vim", "vimdoc", "query" },

			-- Install parsers synchronously (only applied to `ensure_installed`)
			sync_install = false,

			-- Automatically install missing parsers when entering buffer
			auto_install = true,

			highlight = {
				enable = true,
				disable = { "latex" },

				additional_vim_regex_highlighting = false,
			},
		})
	end,
}
