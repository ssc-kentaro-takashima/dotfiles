return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    require("bufferline").setup({
      options = {
        mode = "buffers", -- "buffers" または "tabs"
        numbers = "buffer_id", -- バッファIDを表示
        close_command = "bdelete! %d", -- バッファを閉じるコマンド
        right_mouse_command = "bdelete! %d", -- 右クリックで閉じる
        left_mouse_command = "buffer %d", -- 左クリックでアクティブに
        indicator = {
          icon = '▎', -- アクティブなバッファのインジケーター
          style = 'icon',
        },
        buffer_close_icon = '  ',
        modified_icon = '●',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',
        max_name_length = 18,
        max_prefix_length = 15,
        tab_size = 18,
        diagnostics = "nvim_lsp", -- LSPの警告やエラーをバッファ名に表示
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        persist_buffer_sort = true,
        separator_style = "slant", -- "slant", "thick", "thin", "none"
        enforce_absolute_fs_paths = true,
      }
    })

    -- キーマッピングの例
    local map = vim.keymap.set
    
    -- バッファの移動
    map('n', '<S-l>', '<Cmd>BufferLineCycleNext<CR>', { desc = '次のバッファへ' })
    map('n', '<S-h>', '<Cmd>BufferLineCyclePrev<CR>', { desc = '前のバッファへ' })
    
    -- バッファの並び替え
    map('n', '<Leader>bp', '<Cmd>BufferLinePick<CR>', { desc = 'バッファを選択して移動' })
    map('n', '<Leader>bde', '<Cmd>BufferLineSortByDirectory<CR>', { desc = 'ディレクトリ順にソート' })
    map('n', '<Leader>ble', '<Cmd>BufferLineSortByExtension<CR>', { desc = '拡張子順にソート' })
  end
}
