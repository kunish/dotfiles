local M = {}

function M.setup()
  local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable',
      lazypath,
    })
  end

  vim.opt.rtp:prepend(lazypath)

  require('lazy').setup({
    -- essential
    'wbthomason/packer.nvim',
    'nvim-lua/plenary.nvim',
    'rktjmp/lush.nvim',

    -- interface
    {
      'kyazdani42/nvim-web-devicons',
      init = function()
        require('nvim-web-devicons').setup({ default = true })
      end,
    },
    {
      'Shatur/neovim-ayu',
      init = function()
        require('ayu').setup({})
        require('ayu').colorscheme()
      end,
    },
    {
      'lewis6991/gitsigns.nvim',
      init = function()
        require('gitsigns').setup({
          yadm = {
            enable = true,
          },
        })
      end,
    },
    {
      'kyazdani42/nvim-tree.lua',
      init = function()
        require('nvim-tree').setup({
          view = {
            width = 40,
          },
          renderer = {
            root_folder_label = false,
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
      end,
    },
    {
      'nvim-lualine/lualine.nvim',
      init = function()
        require('lualine').setup({
          extensions = { 'nvim-tree', 'fugitive', 'quickfix' },
        })
      end,
    },
    {
      'akinsho/bufferline.nvim',
      init = function()
        require('bufferline').setup({
          options = {
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
      end,
    },
    {
      'norcalli/nvim-colorizer.lua',
      init = function()
        require('colorizer').setup(nil, {
          RRGGBBAA = true,
          css = true,
          css_fn = true,
          rgb_fn = true,
          hsl_fn = true,
        })
      end,
    },

    -- tool
    {
      'phaazon/hop.nvim',
      init = function()
        require('hop').setup()
      end,
    },
    {
      'windwp/nvim-autopairs',
      init = function()
        require('nvim-autopairs').setup({
          check_ts = true,
        })
      end,
    },
    {
      'max397574/better-escape.nvim',
      init = function()
        require('better_escape').setup({
          timeout = 250,
        })
      end,
    },
    {
      'numToStr/Navigator.nvim',
      init = function()
        require('Navigator').setup({})
      end,
    },
    {
      'mattn/emmet-vim',
      init = function()
        vim.g.user_emmet_expandabbr_key = '<C-z>'
        vim.g.user_emmet_mode = 'i'
      end,
    },
    {
      'folke/which-key.nvim',
      init = function()
        require('which-key').setup()
      end,
    },
    {
      'mbbill/undotree',
      init = function()
        vim.g.undotree_SetFocusWhenToggle = 1
        vim.g.undotree_HelpLine = 0
      end,
    },
    {
      'nvim-pack/nvim-spectre',
      init = function()
        require('spectre').setup()
      end,
    },
    {
      'kylechui/nvim-surround',
      init = function()
        require('nvim-surround').setup({})
      end,
    },

    'famiu/bufdelete.nvim',
    'vim-scripts/ReplaceWithRegister',
    'houtsnip/vim-emacscommandline',
    'numToStr/Comment.nvim',
    'tpope/vim-fugitive',
    'tpope/vim-repeat',

    -- telescope
    {
      'nvim-telescope/telescope.nvim',
      init = function()
        require('telescope').setup({
          defaults = require('telescope.themes').get_ivy(),
        })
      end,
    },

    -- treesitter
    {
      'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
      dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
        'JoosepAlviste/nvim-ts-context-commentstring',
      },
      init = function()
        require('nvim-treesitter.install').prefer_git = true
        require('nvim-treesitter.configs').setup({
          ensure_installed = 'all',
          ignore_install = { 'swift', 'phpdoc', 'beancount' },
          autopairs = { enable = true },
          highlight = { enable = true },
          indent = { enable = true, disable = { 'python' } },
          context_commentstring = { enable = true, enable_autocmd = false },
          textobjects = {
            select = {
              enable = true,
              lookahead = true,
              keymaps = {
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
              },
            },
          },
        })
      end,
    },

    -- ide
    {
      'neovim/nvim-lspconfig',
      dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'jose-elias-alvarez/null-ls.nvim',
        'folke/neodev.nvim',
        'b0o/schemastore.nvim',
      },
    },

    -- cmp
    {
      'hrsh7th/nvim-cmp',
      dependencies = {
        'onsails/lspkind-nvim',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-nvim-lsp',
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
        'rafamadriz/friendly-snippets',
      },
    },
  })
end

return M
