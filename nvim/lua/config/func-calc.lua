local M = {}
--
-- 矩形選択した範囲の数値を合計して通知する関数
--
function M.notify_sum_of_selection()
  -- 現在のビジュアル選択範囲（行・列）を取得
  local _, s_row, s_col, _ = unpack(vim.fn.getpos("'<"))
  local _, e_row, e_col, _ = unpack(vim.fn.getpos("'>"))

  -- 行の上下関係を補正
  local start_row = math.min(s_row, e_row)
  local end_row = math.max(s_row, e_row)
  -- 列の左右関係を補正（矩形選択用）
  local start_col = math.min(s_col, e_col)
  local end_col = math.max(s_col, e_col)

  -- 指定範囲のテキストを取得
  local lines = vim.api.nvim_buf_get_lines(0, start_row - 1, end_row, false)
  local sum = 0
  local count = 0

  for _, line in ipairs(lines) do
    -- 各行から矩形選択された部分を切り出し
    local sub_str = string.sub(line, start_col, end_col)
    -- 文字列から最初に見つかった数値を抽出（マイナスや小数に対応）
    local num = tonumber(string.match(sub_str, "%-?%d+%.?%d*"))
    if num then
      sum = sum + num
      count = count + 1
    end
  end

  -- 結果を通知
  if count > 0 then
    vim.notify(string.format("合計: %s (対象: %d件)", sum, count), vim.log.levels.INFO)
  else
    vim.notify("選択範囲に数値が見つかりませんでした", vim.log.levels.WARN)
  end
end

return M
