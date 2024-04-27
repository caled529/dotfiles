return {
	"nvim-lualine/lualine.nvim",
	config = function()
		vim.opt.showmode = false

		local function getActiveLspServerNames()
			local lspClients = vim.lsp.get_active_clients()
			local lspNames = "LSP: "
			for _, client in pairs(lspClients) do
				lspNames = lspNames .. client.name .. ", "
			end
			return string.sub(lspNames, 0, -3)
		end

		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "gruvbox-material",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = false,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				},
			},

			sections = {
				lualine_a = {
					{
						"mode",
					},
				},
				lualine_b = {
					{
						"branch",
						icon = "",
					},
				},
				lualine_c = {
					{
						"filename",
					},
				},
				lualine_x = {
					{
						"diagnostics",
					},
					{
						getActiveLspServerNames,
					},
				},
				lualine_y = {
					{
						"filetype",
						colored = false,
						icon_only = true,
					},
				},
				lualine_z = {
					{
						"location",
						icon = "󰳂",
					},
				},
			},

			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = {
					{
						"filetype",
						colored = false,
						icon_only = true,
					},
				},
				lualine_y = {},
				lualine_z = {},
			},

			tabline = {},

			winbar = {},

			inactive_winbar = {},

			extensions = {},
		})
	end,
}
