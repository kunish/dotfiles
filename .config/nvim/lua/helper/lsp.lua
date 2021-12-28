local M = {}

M.lsp_servers = {}
M.capabilities = {}

function M.setup(config)
  M._capabilities = config.capabilities
  M._get_on_attach = config.get_on_attach

  return M
end

function M.startup(start)
  start(M.use)
end

function M.use(name, opts, setup)
  opts = type(opts) == 'function' and opts() or type(opts) == 'table' and opts or {}
  opts.capabilities = M._capabilities
  opts.on_attach = M._get_on_attach(opts.disable_formatting)

  opts.handlers = opts.handlers or {}

  if opts.disable_diagnostics then
    opts.handlers['textDocument/publishDiagnostics'] = function() end
  end

  M.lsp_servers[#M.lsp_servers + 1] = {
    name = name,
    opts = opts,
    setup = setup,
  }
end

function M.find(name)
  local configs = vim.tbl_filter(function(config)
    return config.name == name
  end, M.lsp_servers)

  return #configs == 0 and nil or configs[1]
end

function M.peek()
  local params = vim.lsp.util.make_position_params()

  return vim.lsp.buf_request(0, 'textDocument/definition', params, function(_, result)
    if result == nil or vim.tbl_isempty(result) then
      return nil
    end

    vim.lsp.util.preview_location(result[1])
  end)
end

return M
