local function neotree_config()
  vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal left<CR>', {})
  vim.keymap.set('n', '<S-n>', ':Neotree filesystem reveal float<CR>', {})
end

return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  config = neotree_config
}
