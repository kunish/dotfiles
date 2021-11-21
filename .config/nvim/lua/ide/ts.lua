local M = {}

local nvim_treesitter_configs = require "nvim-treesitter.configs"

function M.setup()
  nvim_treesitter_configs.setup {
    ensure_installed = "maintained",
    autopairs = { enable = true },
    highlight = { enable = true },
    indent = { enable = true },
    rainbow = { enable = true, extended_mode = true },
    context_commentstring = { enable = true },
  }
end

return M
