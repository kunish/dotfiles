local M = {}

local dap_install = require('dap-install')
local dbg_list = require('dap-install.api.debuggers').get_installed_debuggers()

function M.setup()
  dap_install.setup()

  for _, debugger in ipairs(dbg_list) do
    dap_install.config(debugger)
  end
end

return M
