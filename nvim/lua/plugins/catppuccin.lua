local function catppuccin_config()
  vim.cmd.colorscheme("catppuccin-macchiato")
end

return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = catppuccin_config,
}
