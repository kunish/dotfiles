local M = {}

local formatter = require "formatter"

function M.setup()
  local shfmt = {
    function()
      return {
        exe = "shfmt",
        args = { "-i", 2 },
        stdin = true,
      }
    end,
  }

  local formatter_by_ft = {
    zsh = shfmt,
  }

  formatter.setup {
    filetype = formatter_by_ft,
  }
end

return M
