local M = {}

function M.setup()
  require('lualine').setup({
    options = {
      disabled_filetypes = { '', 'packer', 'NvimTree' },
    },
  })

  require('dressing').setup()

  require('notify').setup({
    background_colour = '#000000',
  })

  vim.notify = require('notify')

  require('colorizer').setup(nil, {
    RRGGBBAA = true,
    css = true,
    css_fn = true,
    rgb_fn = true,
    hsl_fn = true,
  })

  require('todo-comments').setup()

  require('bufferline').setup({
    options = {
      always_show_bufferline = false,
      offsets = {
        {
          filetype = 'NvimTree',
          text = 'File Explorer',
          highlight = 'Directory',
          text_align = 'left',
        },
      },
    },
  })

  require('gitsigns').setup({
    yadm = {
      enable = true,
    },
  })

  require('nvim-web-devicons').setup({ default = true })

  -- nvimtree
  vim.g.nvim_tree_git_hl = 1

  require('nvim-tree').setup({
    view = {
      width = 40,
      auto_resize = true,
    },
    hijack_cursor = true,
    update_focused_file = {
      enable = true,
    },
    filters = {
      custom = { '.git' },
    },
  })

  vim.cmd('colorscheme gruvbox')
end

return M
