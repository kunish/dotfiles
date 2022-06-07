local M = {}

function M.setup()
  vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
  vim.opt.expandtab = true
  vim.opt.fillchars = 'eob: '
  vim.opt.number = true
  vim.opt.relativenumber = true
  vim.opt.ignorecase = true
  vim.opt.lazyredraw = true
  vim.opt.mouse = 'a'
  vim.opt.shiftwidth = 2
  vim.opt.shortmess:append({
    I = true,
    c = true,
  })
  vim.opt.showcmd = false
  vim.opt.showmode = false
  vim.opt.signcolumn = 'yes'
  vim.opt.splitbelow = true
  vim.opt.splitright = true
  vim.opt.swapfile = false
  vim.opt.tabstop = 2
  vim.opt.termguicolors = true
  vim.opt.undofile = true
  vim.opt.updatetime = 250

  vim.g.do_filetype_lua = 1
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '

  require('ayu').colorscheme()

  require('nvim-tree').setup({
    view = {
      width = 40,
      hide_root_folder = true,
    },
    hijack_cursor = true,
    update_focused_file = {
      enable = true,
    },
    git = {
      ignore = false,
    },
    filters = {
      custom = { '.git' },
    },
  })
end

return M
