return {
	"VonHeikemen/lsp-zero.nvim",
	branch = "v3.x",
	dependencies = {
		{ "williamboman/mason.nvim" },
		{ "williamboman/mason-lspconfig.nvim" },
		-- LSP Support
		{ "neovim/nvim-lspconfig" },
		-- Autocomplete
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/nvim-cmp" },
		{ "L3MON4D3/LuaSnip" },
	},
	config = function()
		local lsp_zero = require("lsp-zero")

		require("mason").setup({})
		require("mason-lspconfig").setup({
			handlers = {
				lsp_zero.default_setup,
				lua_ls = function()
					local lua_opts = lsp_zero.nvim_lua_ls()
					require("lspconfig").lua_ls.setup(lua_opts)
				end,
			},
		})

		require("lspconfig").ocamllsp.setup({})
		require("lspconfig").pyright.setup({})

		local cmp = require("cmp")
		local cmp_action = lsp_zero.cmp_action()

		cmp.setup({
			sources = {
				{ name = "path" },
				{ name = "nvim_lsp" },
				{ name = "nvim_lua" },
				{ name = "luasnip", keyword_length = 2 },
				{ name = "buffer", keyword_length = 3 },
			},
			formatting = lsp_zero.cmp_format(),
			mapping = cmp.mapping.preset.insert({
				["<Tab>"] = cmp_action.tab_complete(),
				["<S-Tab>"] = cmp_action.select_prev_or_fallback(),
				["<S-Enter>"] = cmp.mapping.confirm({ select = false }),
			}),
		})
	end,
}
