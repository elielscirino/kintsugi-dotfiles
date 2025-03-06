local function lualine_config()
	require("lualine").setup({
		options = {
			theme = "dracula",
		},
		sections = {
			lualine_c = {
				{
					"filename",
					path = 1,
					shorting_target = 40,
					symbols = { modified = " ●", newfile = " ", readonly = " ", unnamed = "[Sem Nome]" },
				},
			},
		},
	})
end

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = lualine_config,
}
