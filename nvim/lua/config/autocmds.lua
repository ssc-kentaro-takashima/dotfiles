--
-- LSPの読み込みが完了した時に通知を表示
--
local lsp_initialized = false
vim.api.nvim_create_autocmd("LspProgress", {
  callback = function(args)
    if lsp_initialized then
      return
    end

    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end

    -- ts_ls の progress が "end" になった時に通知
    local progress = client.progress
    if progress and progress._items then
      local last_item = progress._items[progress._idx_write - 1]
      if last_item and last_item.value and last_item.value.kind == "end" then
        lsp_initialized = true

        local clients = vim.lsp.get_clients()
        local names = {}

        for _, c in ipairs(clients) do
          table.insert(names, c.name)
        end

        local msg = ("LSP ready (%d servers): %s"):format(
          #names, table.concat(names, ", ")
        )

        vim.notify(msg, vim.log.levels.INFO, { timeout = 10000 })
      end
    end
  end,
})
