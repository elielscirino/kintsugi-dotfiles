local function gitsigns_config()
	require("gitsigns").setup()

	-- Shortcuts
	vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", {})
  vim.keymap.set('n', "<leader>gb", ":Gitsigns blame_line<CR>", {})
end

return {
	{ "tpope/vim-fugitive" },
	{
		"lewis6991/gitsigns.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = gitsigns_config,
	},
}
