local M = {}

local bufdelete = require('bufdelete')

function M.buf_delete()
  bufdelete.bufdelete(0)
end

function M.buf_only()
  local cur = vim.api.nvim_get_current_buf()

  for _, n in ipairs(vim.api.nvim_list_bufs()) do
    if n ~= cur then
      vim.api.nvim_buf_delete(n, {})
    end
  end
end

function M.buf_clear()
  for _, n in ipairs(vim.api.nvim_list_bufs()) do
    vim.api.nvim_buf_delete(n, {})
  end
end

return M
