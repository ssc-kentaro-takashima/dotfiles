return {
  'stevearc/oil.nvim',
  opts = {
    view_options = {
      show_hidden = true,
    },
    keymaps = {
      ["<C-p>"] = { "actions.preview", opts = { split = "belowright" } },
    },
    float = {
      preview_split = "right",
    },
  },
  dependencies = { { "nvim-mini/mini.icons", opts = {} } },
}
