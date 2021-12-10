local M = {}

function M.setup()
  require('hop').setup()

  require('Comment').setup {
    pre_hook = function(ctx)
      local U = require 'Comment.utils'

      local location = nil
      if ctx.ctype == U.ctype.block then
        location = require('ts_context_commentstring.utils').get_cursor_location()
      elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
        location = require('ts_context_commentstring.utils').get_visual_start_location()
      end

      return require('ts_context_commentstring.internal').calculate_commentstring {
        key = ctx.ctype == U.ctype.line and '__default' or '__multiline',
        location = location,
      }
    end,
  }

  require('nvim-autopairs').setup {
    check_ts = true,
    disable_filetype = { 'TelescopePrompt' },
  }

  local telescope_defaults = require('telescope.themes').get_ivy()

  telescope_defaults.initial_mode = 'normal'

  require('telescope').setup {
    defaults = telescope_defaults,
    pickers = {
      find_files = {
        hidden = true,
        initial_mode = 'insert',
      },
    },
    extensions = {
      file_browser = {
        hidden = true,
      },
    },
  }
  require('telescope').load_extension 'notify'
  require('telescope').load_extension 'file_browser'
  require('telescope').load_extension 'fzf'

  require('better_escape').setup {
    timeout = 250,
  }
  require('Navigator').setup()

  -- emmet
  vim.g.user_emmet_leader_key = '<C-z>'

  -- markdown preview
  vim.g.mkdp_auto_close = 0

  -- undotree
  vim.g.undotree_SetFocusWhenToggle = 1
  vim.g.undotree_HelpLine = 0
end

return M
