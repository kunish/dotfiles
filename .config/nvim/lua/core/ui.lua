local M = {}

function M.setup()
  require("colorizer").setup(nil, {
    RRGGBBAA = true,
    css = true,
    css_fn = true,
    rgb_fn = true,
    hsl_fn = true,
  })
  require("lualine").setup {
    options = { disabled_filetypes = { "NvimTree" } },
  }
  require("gitsigns").setup()
  require("nvim-web-devicons").setup { default = true }

  -- nvimtree
  vim.g.nvim_tree_highlight_opened_files = 1
  vim.g.nvim_tree_group_empty = 0
  vim.g.nvim_tree_git_hl = 1
  vim.g.nvim_tree_show_icons = {
    folder_arrows = 0,
    files = 1,
    folders = 1,
    git = 1,
  }
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
      width = "30%",
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

  -- barbar
  vim.g.bufferline = { animation = false, auto_hide = true }

  vim.cmd "silent! colorscheme gruvbox"
end

return M
