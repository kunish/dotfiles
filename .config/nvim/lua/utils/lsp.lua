local M = {}

M.lsp_servers = {}
M.capabilities = {}

M.setup = function(capabilities)
  M.capabilities = capabilities
end

M.use = function(name, opts)
  opts = type(opts) == 'function' and opts() or type(opts) == 'table' and opts or {}
  opts.capabilities = M.capabilities

  M.lsp_servers[#M.lsp_servers + 1] = {
    name = name,
    opts = opts,
  }
end

M.peek = function()
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, 'textDocument/definition', params, function(_, result)
    if result == nil or vim.tbl_isempty(result) then
      return nil
    end
    vim.lsp.util.preview_location(result[1])
  end)
end

return M
