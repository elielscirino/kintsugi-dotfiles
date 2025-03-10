local function catppuccin_config()
  vim.cmd.colorscheme("catppuccin")
end

return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = catppuccin_config,
}
