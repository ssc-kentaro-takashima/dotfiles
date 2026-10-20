vim.api.nvim_set_option('updatetime', 500)

-- CursorHold で diagnostic をフロート表示
vim.api.nvim_create_autocmd('CursorHold', {
  callback = function()
    vim.diagnostic.open_float(nil, {
      focusable = false,
      border = 'rounded',
      source = 'if_many',
      max_width = 80,
  })
  end,
})

return {
  "williamboman/mason-lspconfig.nvim",
  opts = {
    ensure_installed = {
      "ts_ls",
      "html",
      "cssls",
      "tailwindcss",
      "lua_ls",
      "pyright",
      "eslint",
      "csharp_ls",
    },
    automatic_setup = true,
  },
  dependencies = {
    {
      "williamboman/mason.nvim",
      opts = {
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "→",
            package_uninstalled = "✗",
          },
        },
      },
    },
    'neovim/nvim-lspconfig',
  },
}
