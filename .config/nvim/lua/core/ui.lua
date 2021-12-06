local M = {}

function M.setup()
  require("onedarkpro").setup {
    theme = "onedark",
    colors = {
      red = "#ef596f",
      green = "#89ca78",
      cyan = "#2bbac5",
      purple = "#d55fde",
    },
    options = {
      transparency = true,
    },
  }
  require("onedarkpro").load()

  require("lualine").setup {
    options = {
      disabled_filetypes = { "", "packer", "NvimTree" },
    },
  }

  require("colorizer").setup(nil, {
    RRGGBBAA = true,
    css = true,
    css_fn = true,
    rgb_fn = true,
    hsl_fn = true,
  })

  require("todo-comments").setup()

  require("bufferline").setup {
    options = {
      always_show_bufferline = false,
      offsets = {
        {
          filetype = "NvimTree",
          text = "File Explorer",
          highlight = "Directory",
          text_align = "left",
        },
      },
    },
  }

  require("gitsigns").setup()

  require("nvim-web-devicons").setup { default = true }

  -- nvimtree
  vim.g.nvim_tree_git_hl = 1

  require("nvim-tree").setup {
    view = {
      width = 40,
      auto_resize = true,
    },
    hijack_cursor = true,
    diagnostics = {
      enable = true,
    },
    update_focused_file = {
      enable = true,
    },
    filters = {
      custom = { ".git", "node_modules" },
    },
  }
end

return M
