return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- 1. エンコーディングと改行コード
      local fileformat = {
        function()
          local enc = vim.bo.fileencoding
          if enc == "" then
            enc = vim.o.fileencoding
          end
          enc = enc ~= "" and string.upper(enc) or "NONE"

          local ff = vim.bo.fileformat
          if ff == "unix" then
            ff = "LF"
          elseif ff == "dos" then
            ff = "CRLF"
          elseif ff == "mac" then
            ff = "CR"
          else
            ff = string.upper(ff)
          end

          return string.format("%s[%s]", enc, ff)
        end,
      }

      local mode = {
        function()
          return string.upper(vim.fn.mode())
        end,
      }

      -- 時間
      local time = {
        function()
          return os.date("%H:%M:%S")
        end,
        icon = " ",
        color = { fg = "#000000" },
      }

      -- 行数とカラム（行：列）
      local line_col = {
        color = { fg = "#81959f" },
      }

      -- sections を初期化
      opts.sections = {
        lualine_a = { mode },
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename', 'searchcount'},
        lualine_x = {  },
        lualine_y = { 'progress', 'location' },
        lualine_z = { fileformat, time }
      }

    end,
  },
}
