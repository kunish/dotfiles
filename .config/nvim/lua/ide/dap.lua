local M = {}

local dap_install = require('dap-install')
local dap_ui = require('dapui')

function M.setup()
  dap_install.setup()
  dap_ui.setup()

  dap_install.config('jsnode', {
    configurations = {
      {
        name = 'Debug Current File',
        type = 'node2',
        request = 'launch',
        console = 'integratedTerminal',
        program = '${file}',
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = 'inspector',
      },
      {
        name = 'Debug Teacher',
        type = 'node2',
        request = 'launch',
        console = 'integratedTerminal',
        program = '${file}',
        cwd = vim.fn.getcwd() .. '/apps/teacher',
        runtimeExecutable = 'yarn',
        runtimeArgs = { 'start' },
        autoAttachChildProcesses = true,
      },
    },
  })
end

return M
