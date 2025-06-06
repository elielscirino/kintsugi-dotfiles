local function fold_cofig()
  vim.keymap.set("n", "zR", require('ufo').openAllFolds, { desc = "Open All Folds" })
  vim.keymap.set("n", "zM", require('ufo').closeAllFolds, { desc = "Close All Folds" })
	vim.keymap.set("n", "zk", function()
		local windid = require("ufo").peekFoldedLinesUnderCursor()
		if not windid then
			vim.lsp.buf.hover()
		end
	end, { desc = "Peek Fold" })

	require("ufo").setup({
		provider_selector = function(bufnr, filetype, buftype)
			return { "lsp", "indent" }
		end,
    fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = (' 󰁂 [%d lines] '):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
        else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, {chunkText, hlGroup})
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, {suffix, 'MoreMsg'})
    return newVirtText
end
	})
end

return {
	"kevinhwang91/nvim-ufo",
	dependencies = { "kevinhwang91/promise-async" },
	config = fold_cofig,
}
