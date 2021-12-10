local M = {}

local filetype = require 'filetype'

function M.setup()
  filetype.setup {
    overrides = {
      literal = {
        ['.eslintcache'] = 'json',
        ['.releaserc'] = 'json',
      },
      shebang = {
        node = 'javascript',
      },
    },
  }
end

return M
