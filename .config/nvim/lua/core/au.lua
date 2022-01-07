local M = {}

function M.setup()
  vim.cmd([[
    augroup yank
      autocmd!
      autocmd TextYankPost * silent! lua vim.highlight.on_yank({ timeout = 500, on_visual = true })
    augroup end
  ]])
end

return M
