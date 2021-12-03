local M = {}

M.lsp_servers = {}
M.capabilities = {}

M.setup = function(capabilities)
  M.capabilities = capabilities
end

M.use = function(name, opts)
  opts = type(opts) == "function" and opts() or type(opts) == "table" and opts or {}
  opts.capabilities = M.capabilities

  M.lsp_servers[#M.lsp_servers + 1] = {
    name = name,
    opts = opts,
  }
end

return M
