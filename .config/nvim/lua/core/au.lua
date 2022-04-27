local M = {}

function M.setup()
  vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
      vim.highlight.on_yank({ timeout = 500, on_visual = true })
    end,
  })
end

return M
