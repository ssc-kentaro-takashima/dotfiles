require("config.lazy")
require("config.keymaps")
require("config.autocmds")

-- カラーテーマ
vim.cmd([[colorscheme kanagawa-dragon]])

vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.opt.number = true             -- 行番号表示
vim.opt.relativenumber = false    -- 相対行番号の場合はtrue
vim.opt.wrap = false              -- 行末で折り返す場合はtrue
vim.opt.ignorecase = true         -- 検索時大文字小文字無視
vim.opt.smartcase = false         -- 検索時スマートケース
vim.opt.clipboard = "unnamedplus" -- クリップボード共有
vim.opt.swapfile = false          -- スワップファイルを生成しない

vim.opt.backup = false
vim.opt.hidden = true
vim.opt.encoding = "utf-8"
vim.opt.fileencodings = { "utf-8", "cp932", "euc-jp", "sjis" }
vim.opt.fileformats = "unix,dos,mac"

-- undoファイルを保存するディレクトリが存在しない場合は自動作成
local undo_dir = vim.fn.stdpath('state') .. '/undo'
if vim.fn.isdirectory(undo_dir) == 0 then
  vim.fn.mkdir(undo_dir, 'p')
end

-- undoファイルの永続化を有効化
vim.opt.undofile = true
vim.opt.undodir = undo_dir


--
-- ファイルタイプでタブ幅を変更
--
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact", "json", "lua" },
  callback = function()
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.softtabstop = 2
    vim.bo.expandtab = true
  end,
})

-- Markdownファイル中のファイルリンクに.mdを自動付加
vim.api.nvim_create_autocmd({ "FileType", "BufWinEnter" }, {
  pattern = "markdown",
  callback = function()
    -- スペルチェックOFF
    vim.schedule(function()
      vim.opt_local.spell = false
    end)

    -- Vim(gfキー)用の設定
    vim.opt_local.path:append({ ".", "**" }) -- サブディレクトリ再帰
    vim.opt_local.suffixesadd:append(".md")  -- 拡張子なし→.md自動追加
    vim.opt_local.isfname:append("@-@")
    vim.cmd("setlocal path+=.")
  end,
})

-- エラーの表示設定
vim.diagnostic.config({
  virtual_text = false,
  underline = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.HINT] = "",
      [vim.diagnostic.severity.INFO] = "",
    },
  },
})

-- クリップボードをホストPCと共有
vim.g.clipboard = {
  name = 'win32yank',
  copy = {
    ['+'] = '/mnt/d/Apps/Neovim/bin/win32yank.exe -i --crlf',
    ['*'] = '/mnt/d/Apps/Neovim/bin/win32yank.exe -i --crlf',
  },
  paste = {
    ['+'] = '/mnt/d/Apps/Neovim/bin/win32yank.exe -o --lf',
    ['*'] = '/mnt/d/Apps/Neovim/bin/win32yank.exe -o --lf',
  },
  cache_enabled = 0,
}
