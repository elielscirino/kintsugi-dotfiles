local function gitsigns_config()
	require("gitsigns").setup()
end

return {
	"lewis6991/gitsigns.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = gitsigns_config,
}
