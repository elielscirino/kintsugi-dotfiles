local function colorizer_config()
  require("colorizer").setup({
    user_default_options = {
      tailwind = true,
    }
  })
end

return {
  "catgoose/nvim-colorizer.lua",
  config = colorizer_config,

}
