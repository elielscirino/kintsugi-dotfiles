local function none_ls_config()
	local null_ls = require("null-ls")

	null_ls.setup({
		sources = {
			null_ls.builtins.formatting.stylua,
		},
	})

	-- Shortcuts
	vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  vim.keymap.set("n", "<leader>ef", "<cmd>EslintFixAll<CR>", { noremap = true, silent = true })
end

return {
	"nvimtools/none-ls.nvim",
	config = none_ls_config,
}
