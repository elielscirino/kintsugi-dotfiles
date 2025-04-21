local function mason_config()
  require("mason").setup()
end

local function mason_lspconfig_config()
  require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "ts_ls", "eslint", "tailwindcss" },
  })
end

local function lspconfig_config()
  local capabilities = require("cmp_nvim_lsp").default_capabilities()
  local lspconfig = require("lspconfig")

  -- LSPs
  lspconfig.lua_ls.setup({
    capabilities = capabilities,
  })
  lspconfig.ts_ls.setup({
    capabilities = capabilities,
  })
  lspconfig.tailwindcss.setup({
    capabilities = capabilities,
    settings = {
      tailwindCSS = {
        classAttributes = { "class", "className", "classList", "addStyle" },
      },
    },
  })

  lspconfig.eslint.setup({
    on_attach = function(client, bufnr)
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        command = "EslintFixAll",
      })
    end,
  })

  local eslint_enabled = true

  local function toggle_eslint()
    eslint_enabled = not eslint_enabled
    local clients = vim.lsp.get_active_clients()

    for _, client in ipairs(clients) do
      if client.name == "eslint" then
        if eslint_enabled then
          vim.notify("ESLint Enabled", vim.log.levels.INFO)
        else
          vim.notify("ESLint Disabled", vim.log.levels.WARN)
          vim.lsp.stop_client(client.id)
        end
      end
    end
  end

  -- Shortcuts
  vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "[g]o to [d]efinition" })
  vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "[g]o to [r]eferences" })
  vim.keymap.set("n", "gv", function()
    vim.cmd("vsplit")      -- Open a vertical split
    vim.lsp.buf.definition() -- Go to the definition
  end, { desc = "[g]o to definition in [v]ertical split" })
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)

  vim.keymap.set('n', '<leader>c', function()
    local word = vim.fn.expand('<cword>')
    local replace = vim.fn.input('Replace "' .. word .. '" by? ')
    if replace == "" then return end
    vim.cmd(string.format('%%s/\\v<%s>/%s/g', word, replace))
  end, { noremap = true, silent = true })


    vim.api.nvim_set_keymap(
      "n",
      "<leader>d",
      "<cmd>lua vim.diagnostic.open_float()<CR>",
      { noremap = true, silent = true }
    )
    vim.api.nvim_create_user_command("ToggleEslint", toggle_eslint, {})
  end

return {
  {
    "williamboman/mason.nvim",
    config = mason_config,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = mason_lspconfig_config,
  },
  {
    "neovim/nvim-lspconfig",
    config = lspconfig_config,
  },
}
