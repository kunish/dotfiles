local M = {}

local filetype = require('filetype')

function M.setup()
  filetype.setup({
    overrides = {
      extensions = {
        mdx = 'markdown',
        tf = 'terraform',
      },
      literal = {
        ['.eslintcache'] = 'json',
        ['.releaserc'] = 'json',
      },
      shebang = {
        node = 'javascript',
      },
    },
  })
end

return M
