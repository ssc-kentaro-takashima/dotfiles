local ret = {}

function ret.get_listed_buffers_count()
  local count = 0
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buflisted then
      count = count + 1
    end
  end
  return count
end

function ret.safe_bdelete()
  if ret.get_listed_buffers_count() <= 1 then
    vim.notify("Last buffer; deletion skipped.", vim.log.levels.WARN)
    return
  end
  vim.cmd('bdelete')
end

return ret
