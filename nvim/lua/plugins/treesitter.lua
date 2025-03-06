local function treesitter_config()
  local configs = require("nvim-treesitter.configs")

  configs.setup({
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true }
  })
end

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = treesitter_config,
}
