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
  local util = require('packer.util')

  packer.startup({
    function(use)
      -- essential
      use('wbthomason/packer.nvim')
      use('nvim-lua/popup.nvim')
      use('nvim-lua/plenary.nvim')
      use('rktjmp/lush.nvim')

      -- interface
      use('olimorris/onedarkpro.nvim')
      use('ellisonleao/gruvbox.nvim')
      use('kyazdani42/nvim-web-devicons')
      use('lewis6991/gitsigns.nvim')
      use('akinsho/bufferline.nvim')
      use('numToStr/BufOnly.nvim')
      use('kyazdani42/nvim-tree.lua')
      use('nvim-lualine/lualine.nvim')
      use('norcalli/nvim-colorizer.lua')
      use('folke/todo-comments.nvim')
      use('stevearc/dressing.nvim')
      use('rcarriga/nvim-notify')

      -- tool
      use('folke/which-key.nvim')
      use('tpope/vim-surround')
      use('vim-scripts/ReplaceWithRegister')
      use('houtsnip/vim-emacscommandline')
      use('nvim-telescope/telescope.nvim')
      use('nvim-telescope/telescope-file-browser.nvim')
      use('phaazon/hop.nvim')
      use('numToStr/Comment.nvim')
      use('tpope/vim-fugitive')
      use('tpope/vim-repeat')
      use('mbbill/undotree')
      use('windwp/nvim-autopairs')
      use({ 'iamcco/markdown-preview.nvim', run = 'cd app && yarn' })
      use('mattn/emmet-vim')
      use('max397574/better-escape.nvim')
      use('numToStr/Navigator.nvim')
      use('danymat/neogen')

      -- treesitter
      use({
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
      })
      use('nvim-treesitter/nvim-treesitter-refactor')
      use('p00f/nvim-ts-rainbow')
      use('JoosepAlviste/nvim-ts-context-commentstring')
      use('nvim-treesitter/playground')

      -- ide
      use('github/copilot.vim')
      use('williamboman/nvim-lsp-installer')
      use('neovim/nvim-lspconfig')
      use('jose-elias-alvarez/null-ls.nvim')
      use('b0o/schemastore.nvim')
      use('mfussenegger/nvim-dap')
      use('Pocco81/DAPInstall.nvim')
      use('nathom/filetype.nvim')
      use('simrat39/rust-tools.nvim')

      -- cmp
      use('onsails/lspkind-nvim')
      use('hrsh7th/nvim-cmp')
      use('hrsh7th/cmp-buffer')
      use('hrsh7th/cmp-path')
      use('hrsh7th/cmp-nvim-lsp')
      use('hrsh7th/cmp-nvim-lua')
      use('L3MON4D3/LuaSnip')
      use('saadparwaiz1/cmp_luasnip')
      use('rafamadriz/friendly-snippets')

      if M.packer_bootstrap then
        packer.sync()
      end
    end,

    config = {
      compile_path = util.join_paths(vim.fn.stdpath('data'), 'site', 'packer_compiled.lua'),
    },
  })
end

return M
