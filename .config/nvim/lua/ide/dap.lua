local M = {}

local dap_install = require "dap-install"

function M.setup()
  dap_install.setup {
    installation_path = vim.fn.stdpath "data" .. "/dapinstall",
  }
end

return M
