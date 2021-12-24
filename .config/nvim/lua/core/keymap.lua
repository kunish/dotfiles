local M = {}

local wk = require('which-key')
local hop = require('hop')
local telescope_builtin = require('telescope.builtin')
local tree = require('nvim-tree')
local tree_lib = require('nvim-tree.lib')
local tree_view = require('nvim-tree.view')
local bufferline = require('bufferline')
local navigator = require('Navigator')

function M.setup()
  wk.setup()

  -- hop
  wk.register({
    l = {
      function()
        hop.hint_lines_skip_whitespace()
      end,
      'HopLine',
    },

    s = {
      function()
        hop.hint_char1()
      end,
      'HopChar',
    },
  }, {
    prefix = '<Leader><Leader>',
  })

  -- bufferline
  wk.register({
    b = {
      name = 'Buffer',

      O = { '<cmd>silent! BufOnly<CR>', 'BufferOnly' },

      b = {
        function()
          bufferline.pick_buffer()
        end,
        'BufferPick',
      },

      c = {
        function()
          local explorerWindow = tree_view.get_winnr()
          local wasExplorerOpen = vim.api.nvim_win_is_valid(explorerWindow)

          local bufferToDelete = vim.api.nvim_get_current_buf()

          if wasExplorerOpen then
            bufferline.cycle(-1)
          end

          vim.cmd('bdelete! ' .. bufferToDelete)
        end,
        'BufferClose',
      },

      C = {
        function()
          bufferline.close_buffer_with_pick()
        end,
        'BufferPickClose',
      },

      h = {
        function()
          bufferline.move(-1)
        end,
        'BufferMove Previous',
      },

      l = {
        function()
          bufferline.move(1)
        end,
        'BufferMove Next',
      },

      H = {
        function()
          bufferline.close_in_direction('left')
        end,
        'BufferClose Left',
      },

      L = {
        function()
          bufferline.close_in_direction('right')
        end,
        'BufferClose Right',
      },
    },
  }, {
    prefix = '<Leader>',
  })

  wk.register({
    ['<Tab>'] = {
      function()
        bufferline.cycle(1)
      end,
      'Buffer Next',
    },

    ['<S-Tab>'] = {
      function()
        bufferline.cycle(-1)
      end,
      'Buffer Previous',
    },
  })

  -- telescope
  wk.register({
    f = {
      name = 'Find',

      a = {
        function()
          telescope_builtin.builtin()
        end,
        'Telescope Builtin',
      },
      b = {
        function()
          telescope_builtin.buffers()
        end,
        'Telescope Buffers',
      },
      f = {
        function()
          telescope_builtin.find_files()
        end,
        'Telescope Find Files',
      },
      g = {
        function()
          telescope_builtin.git_commits()
        end,
        'Telescope Git Commits',
      },
      h = {
        function()
          telescope_builtin.help_tags()
        end,
        'Telescope Help',
      },
      j = {
        function()
          telescope_builtin.jumplist()
        end,
        'Telescope Jump List',
      },
      k = {
        function()
          telescope_builtin.keymaps()
        end,
        'Telescope Keymaps',
      },
      l = {
        function()
          require('telescope').extensions.file_browser.file_browser()
        end,
        'Telescope File Browser',
      },
      m = {
        function()
          telescope_builtin.man_pages()
        end,
        'Telescope Man Pages',
      },
    },
  }, {
    prefix = '<Leader>',
  })

  -- buffer fuzzy finder
  wk.register({
    ['\\'] = {
      function()
        telescope_builtin.current_buffer_fuzzy_find()
      end,
      'Telescope Buffer Search',
    },
  })

  -- nvimtree
  wk.register({
    ft = {
      function()
        tree.toggle()
      end,
      'File Tree',
    },
    fT = {
      function()
        tree_lib.collapse_all()
      end,
      'File Tree Collapse',
    },
  }, { prefix = '<Leader>' })

  -- fugitive
  wk.register({
    g = {
      name = 'Git',

      g = { '<cmd>Git<CR>', 'Git Status' },
      p = { '<cmd>Git pull<CR>', 'Git Pull' },
      P = { '<cmd>Git push<CR>', 'Git Push' },
    },
  }, {
    prefix = '<Leader>',
  })

  -- packer
  wk.register({
    P = {
      function()
        require('packer').sync()
      end,
      'Package Sync',
    },
  }, {
    prefix = '<Leader>',
  })

  -- undotree
  wk.register({
    U = { '<cmd>UndotreeToggle<CR>', 'UndoTree Toggle' },
  }, { prefix = '<Leader>' })

  -- copilot
  wk.register({
    ['<C-l>'] = {
      function()
        vim.api.nvim_feedkeys(vim.fn['copilot#Accept'](), 'i', true)
      end,
      'Copilot',
    },
  }, { mode = 'i' })

  -- custom
  wk.register({
    ['<C-s>'] = { '<cmd>silent! write<CR>', 'Buffer Save' },

    ['<A-h>'] = {
      function()
        navigator.left()
      end,
      'Window Left',
    },

    ['<A-l>'] = {
      function()
        navigator.right()
      end,
      'Window Right',
    },

    ['<A-k>'] = {
      function()
        navigator.up()
      end,
      'Window Up',
    },

    ['<A-j>'] = {
      function()
        navigator.down()
      end,
      'Window Down',
    },
  })
end

function M.buf_register(bufnr)
  wk.register({
    l = {
      name = 'LSP',

      a = {
        function()
          vim.lsp.buf.code_action()
        end,
        'LSP Code Actions',
      },

      r = {
        function()
          vim.lsp.buf.rename()
        end,
        'LSP Rename',
      },

      s = {
        function()
          telescope_builtin.lsp_document_symbols()
        end,
        'LSP Document Symbols',
      },

      S = {
        function()
          telescope_builtin.lsp_workspace_symbols()
        end,
        'LSP Workspace Symbols',
      },

      e = {
        function()
          vim.diagnostic.open_float()
        end,
        'Diagnostics Show Line',
      },

      E = {
        function()
          telescope_builtin.diagnostics()
        end,
        'Diagnostics Show Document',
      },

      f = {
        function()
          vim.lsp.buf.formatting()
        end,
        'LSP Format',
      },

      F = {
        function()
          vim.lsp.buf.formatting_seq_sync()
        end,
        'LSP Format',
      },
    },
  }, {
    prefix = '<Leader>',
    buffer = bufnr,
  })

  wk.register({
    gd = {
      function()
        vim.lsp.buf.definition()
      end,
      'LSP Definitions',
    },

    gi = {
      function()
        vim.lsp.buf.implementation()
      end,
      'LSP Implementations',
    },

    gD = {
      function()
        vim.lsp.buf.type_definition()
      end,
      'LSP Declaration',
    },

    gR = {
      function()
        vim.lsp.buf.references()
      end,
      'LSP References',
    },

    gt = {
      function()
        vim.lsp.buf.type_definition()
      end,
      'LSP Type Definitions',
    },

    gG = {
      function()
        require('neogen').generate()
      end,
      'Annotation Generate',
    },

    K = {
      function()
        vim.lsp.buf.hover()
      end,
      'LSP Hover',
    },

    ['[e'] = {
      function()
        vim.diagnostic.goto_prev()
      end,
      'LSP Diagnostic Prev',
    },

    [']e'] = {
      function()
        vim.diagnostic.goto_next()
      end,
      'LSP Diagnostic Next',
    },
  }, {
    buffer = bufnr,
  })
end

return M
