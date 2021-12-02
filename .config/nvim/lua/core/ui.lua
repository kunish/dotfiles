local M = {}

function M.setup()
  vim.cmd "silent! colorscheme gruvbox"

  require("lualine").setup {
    options = {
      disabled_filetypes = { "NvimTree" },
    },
  }

  require("colorizer").setup(nil, {
    RRGGBBAA = true,
    css = true,
    css_fn = true,
    rgb_fn = true,
    hsl_fn = true,
  })

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
  vim.g.nvim_tree_special_files = {
    ["package.json"] = 1,
    ["Cargo.toml"] = 1,
    ["README.md"] = 1,
    ["Dockerfile"] = 1,
    ["Makefile"] = 1,
    ["MAKEFILE"] = 1,
  }

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
