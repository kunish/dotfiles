local M = {}

function M.setup()
  local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    M.packer_bootstrap = vim.fn.system({
      'git',
      'clone',
      '--depth',
      '1',
      'https://github.com/wbthomason/packer.nvim',
      install_path,
    })
  end

  local packer = require('packer')

  packer.startup({
    function(use)
      -- essential
      use('wbthomason/packer.nvim')
      use('nvim-lua/popup.nvim')
      use('nvim-lua/plenary.nvim')

      -- interface
      use({
        'kyazdani42/nvim-web-devicons',
        config = function()
          require('nvim-web-devicons').setup({ default = true })
        end,
      })
      use({
        'ellisonleao/gruvbox.nvim',
        requires = {
          'rktjmp/lush.nvim',
        },
        config = function()
          vim.cmd('colorscheme gruvbox')
        end,
      })
      use('olimorris/onedarkpro.nvim')
      use({
        'lewis6991/gitsigns.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
          require('gitsigns').setup({
            yadm = {
              enable = true,
            },
          })
        end,
      })
      use({
        'stevearc/dressing.nvim',
        config = function()
          require('dressing').setup()
        end,
      })
      use({
        'rcarriga/nvim-notify',
        config = function()
          require('notify').setup({
            background_colour = '#000000',
          })
          vim.notify = require('notify')
        end,
      })
      use({
        'folke/todo-comments.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
          require('todo-comments').setup()
        end,
      })
      use({
        'kyazdani42/nvim-tree.lua',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = function()
          require('nvim-tree').setup({
            view = {
              width = 40,
              auto_resize = true,
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
      })
      use({
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = function()
          require('lualine').setup({
            extensions = { 'nvim-tree', 'fugitive', 'quickfix' },
          })
        end,
      })
      use({
        'akinsho/bufferline.nvim',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = function()
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
      })
      use({
        'norcalli/nvim-colorizer.lua',
        config = function()
          require('colorizer').setup(nil, {
            RRGGBBAA = true,
            css = true,
            css_fn = true,
            rgb_fn = true,
            hsl_fn = true,
          })
        end,
      })

      -- tool
      use({
        'phaazon/hop.nvim',
        config = function()
          require('hop').setup()
        end,
      })
      use({
        'danymat/neogen',
        config = function()
          require('neogen').setup()
        end,
      })
      use({
        'windwp/nvim-autopairs',
        config = function()
          require('nvim-autopairs').setup({
            check_ts = true,
            disable_filetype = { 'TelescopePrompt' },
          })
        end,
      })
      use({
        'max397574/better-escape.nvim',
        config = function()
          require('better_escape').setup({
            timeout = 250,
          })
        end,
      })
      use({
        'numToStr/Navigator.nvim',
        config = function()
          require('Navigator').setup()
        end,
      })
      use({
        'mattn/emmet-vim',
        config = function()
          vim.g.user_emmet_leader_key = '<C-z>'
        end,
      })
      use({
        'folke/which-key.nvim',
        config = function()
          require('which-key').setup()
        end,
      })
      use({
        'mbbill/undotree',
        config = function()
          vim.g.undotree_SetFocusWhenToggle = 1
          vim.g.undotree_HelpLine = 0
        end,
      })
      use({
        'iamcco/markdown-preview.nvim',
        run = 'cd app && yarn',
        config = function()
          vim.g.mkdp_auto_close = 0
        end,
      })
      use('famiu/bufdelete.nvim')
      use('tpope/vim-surround')
      use('vim-scripts/ReplaceWithRegister')
      use('houtsnip/vim-emacscommandline')
      use('nvim-telescope/telescope.nvim')
      use('nvim-telescope/telescope-file-browser.nvim')
      use('numToStr/Comment.nvim')
      use('tpope/vim-fugitive')
      use('tpope/vim-repeat')

      -- treesitter
      use({
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        requires = {
          'nvim-treesitter/nvim-treesitter-refactor',
          'p00f/nvim-ts-rainbow',
          'JoosepAlviste/nvim-ts-context-commentstring',
          'nvim-treesitter/playground',
        },
        config = function()
          require('nvim-treesitter.configs').setup({
            ensure_installed = 'maintained',
            autopairs = { enable = true },
            highlight = { enable = true },
            indent = { enable = true },
            rainbow = { enable = true, extended_mode = true },
            context_commentstring = { enable = true, enable_autocmd = false },
          })
        end,
      })

      -- ide
      use({
        'williamboman/nvim-lsp-installer',
        requires = {
          'neovim/nvim-lspconfig',
          'jose-elias-alvarez/null-ls.nvim',
          'b0o/schemastore.nvim',
          'nathom/filetype.nvim',
          'simrat39/rust-tools.nvim',
        },
      })

      -- dap
      use({
        'mfussenegger/nvim-dap',
        requires = {
          'Pocco81/DAPInstall.nvim',
          'rcarriga/nvim-dap-ui',
          'theHamsta/nvim-dap-virtual-text',
        },
      })

      -- cmp
      use({
        'hrsh7th/nvim-cmp',
        requires = {
          'onsails/lspkind-nvim',
          'hrsh7th/cmp-buffer',
          'hrsh7th/cmp-path',
          'hrsh7th/cmp-nvim-lsp',
          'hrsh7th/cmp-nvim-lua',
          'L3MON4D3/LuaSnip',
          'saadparwaiz1/cmp_luasnip',
          'rafamadriz/friendly-snippets',
        },
      })
      use({
        'github/copilot.vim',
        config = function()
          vim.g.copilot_filetypes = {
            TelescopePrompt = false,
            DressingInput = false,
          }
          vim.g.copilot_no_tab_map = true
          vim.g.copilot_assume_mapped = true
          vim.g.copilot_tab_fallback = ''
        end,
      })

      if M.packer_bootstrap then
        packer.sync()
      end
    end,
  })
end

return M
