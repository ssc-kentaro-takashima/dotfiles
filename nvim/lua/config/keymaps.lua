local utils = require("config.utils")

-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- ターミナル側のCTRL+wを有効にしたいのでオフ
local modes = { "n", "v", "x", "o", "i", "c", "s" }
for _, mode in ipairs(modes) do
  vim.keymap.set(mode, "<C-w>", "<Nop>", { noremap = true, silent = true })
end


-- sキーにペイン関連を割り当てる
vim.keymap.set({ "n" }, "s", "<Nop>")
vim.keymap.set({ "n" }, "sh", "<CMD>split<CR>", { desc = "ペイン横分割" })
vim.keymap.set({ "n" }, "sv", "<CMD>vsplit<CR>", { desc = "ペイン縦分割" })
vim.keymap.set({ "n" }, "sc", "<CMD>close<CR>", { desc = "ペインを閉じる" })
vim.keymap.set({ "n" }, "sa", "<C-w>h", { desc = "ペインを左に移動" })
vim.keymap.set({ "n" }, "<Leader>a", "<C-w>h", { desc = "ペインを左に移動" })
vim.keymap.set({ "n" }, "ss", "<C-w>j", { desc = "ペインを下に移動" })
vim.keymap.set({ "n" }, "sd", "<C-w>l", { desc = "ペインを右に移動" })
vim.keymap.set({ "n" }, "<Leader>d", "<C-w>l", { desc = "ペインを左に移動" })
vim.keymap.set({ "n" }, "sw", "<C-w>k", { desc = "ペインを上に移動" })

-- バッファ関連
vim.keymap.set({ "n" }, "<Leader>", "<Nop>")
vim.keymap.set({ "n" }, "<Leader>q", utils.safe_bdelete, { desc = "バッファ(タブ)削除" })
vim.keymap.set({ "n" }, "<Leader><TAB>", "<CMD>bn<CR>", { desc = "バッファ(タブ)移動" })

-- 拡張機能割り当て
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { remap = false })
vim.keymap.set("n", "<Leader>e", "<CMD>lua Snacks.explorer()<CR>", { remap = false, desc = "エクスプローラー起動"})
vim.keymap.set("n", "<Leader>f", "<CMD>lua Snacks.picker.files()<CR>", { remap = false, desc = "ファイル検索"})
vim.keymap.set("n", "<Leader>g", "<CMD>lua Snacks.picker.grep()<CR>", { remap = false, desc = "grep起動"})
vim.keymap.set("n", "<Leader>u", "<CMD>lua Snacks.picker.undo()<CR>", { remap = false, desc = "Undo"})
vim.keymap.set("n", "<Leader>t", "<CMD>lua Snacks.terminal()<CR>", { remap = false, desc = "ターミナル起動"})
vim.keymap.set("n", "<Leader>lg", "<CMD>LazyGit<CR>", { remap = false, desc = "LazyGit起動"})
vim.keymap.set('n', '<Leader>hi', function()
  vim.diagnostic.open_float(nil, { focusable = true })
end, { desc = 'ホバー中のメッセージに入る' })
vim.keymap.set({"v", "x"}, "<Leader>c", function()
  -- 選択範囲を確定させるために一度ノーマルモードへ戻す
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, false, true), "x", false)
  -- 確定した選択範囲を計算
  vim.schedule(require("config/func-calc").notify_sum_of_selection)
end, { remap = false, desc = "選択範囲の合計を取得"})
