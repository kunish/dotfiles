local M = {}

function M.setup()
  require("hop").setup()
  require("nvim-treesitter.configs").setup {
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },
  }
  require("Comment").setup {
    pre_hook = function(ctx)
      local U = require "Comment.utils"

      local location = nil
      if ctx.ctype == U.ctype.block then
        location = require("ts_context_commentstring.utils").get_cursor_location()
      elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
        location = require("ts_context_commentstring.utils").get_visual_start_location()
      end

      return require("ts_context_commentstring.internal").calculate_commentstring {
        key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
        location = location,
      }
    end,
  }
  require("nvim-autopairs").setup {
    check_ts = true,
    disable_filetype = { "TelescopePrompt" },
  }

  require("telescope").setup {
    defaults = {
      layout_strategy = "vertical",
    },
    pickers = {
      find_files = {
        hidden = true,
      },
      file_browser = {
        hidden = true,
      },
    },
  }
  require("telescope").load_extension "fzf"

  require("plenary.filetype").add_file "json"

  -- emmet
  vim.g.user_emmet_leader_key = "<C-z>"

  -- markdown preview
  vim.g.mkdp_auto_close = 0
end

return M
