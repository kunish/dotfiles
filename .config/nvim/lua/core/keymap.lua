local M = {}

local wk = require('which-key')
local hop = require('hop')
local dap = require('dap')
local dap_ui = require('dapui')
local telescope_builtin = require('telescope.builtin')
local tree = require('nvim-tree')
local tree_lib = require('nvim-tree.lib')
local bufferline = require('bufferline')
local navigator = require('Navigator')
local builtin_lsp = require('builtin.lsp')
local builtin_buf = require('builtin.buf')

function M.setup()
  -- hop
  wk.register({
    l = {
      hop.hint_lines_skip_whitespace,
      'HopLine',
    },

    s = {
      hop.hint_char1,
      'HopChar',
    },
  }, {
    prefix = '<Leader><Leader>',
  })

  -- bufferline
  wk.register({
    b = {
      name = 'Buffer',

      o = { builtin_buf.buf_only, 'BufferOnly' },
      k = { builtin_buf.buf_clear, 'BufferClear' },

      b = {
        bufferline.pick_buffer,
        'BufferPick',
      },

      c = {
        builtin_buf.buf_delete,
        'BufferClose',
      },

      C = {
        bufferline.close_buffer_with_pick,
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

  -- dap
  wk.register({
    d = 'DAP',

    dc = {
      dap.continue,
      'Dap Continue',
    },

    dC = {
      dap.terminate,
      'Dap Close',
    },

    dt = {
      dap.toggle_breakpoint,
      'Dap Toggle Breakpoint',
    },

    ['do'] = {
      dap.step_over,
      'Dap Step Over',
    },

    dO = {
      dap.step_out,
      'Dap Step Out',
    },

    di = {
      dap.step_into,
      'Dap Step Into',
    },

    dr = {
      dap.repl.open,
      'Dap Open Repl',
    },

    du = {
      dap_ui.toggle,
      'Dap UI Toggle',
    },
  }, { prefix = '<Leader>' })

  -- telescope
  wk.register({
    f = {
      name = 'Find',

      a = {
        telescope_builtin.builtin,
        'Telescope Builtin',
      },
      b = {
        telescope_builtin.buffers,
        'Telescope Buffers',
      },
      f = {
        telescope_builtin.find_files,
        'Telescope Find Files',
      },
      g = {
        telescope_builtin.git_commits,
        'Telescope Git Commits',
      },
      h = {
        telescope_builtin.help_tags,
        'Telescope Help',
      },
      j = {
        telescope_builtin.jumplist,
        'Telescope Jump List',
      },
      k = {
        telescope_builtin.keymaps,
        'Telescope Keymaps',
      },
      l = {
        require('telescope').extensions.file_browser.file_browser,
        'Telescope File Browser',
      },
      m = {
        telescope_builtin.man_pages,
        'Telescope Man Pages',
      },
    },
  }, {
    prefix = '<Leader>',
  })

  -- buffer fuzzy finder
  wk.register({
    ['\\'] = {
      telescope_builtin.current_buffer_fuzzy_find,
      'Telescope Buffer Search',
    },
  })

  -- nvimtree
  wk.register({
    ft = {
      tree.toggle,
      'File Tree',
    },
    fT = {
      tree_lib.collapse_all,
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
      require('packer').sync,
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
      navigator.left,
      'Window Left',
    },

    ['<A-l>'] = {
      navigator.right,
      'Window Right',
    },

    ['<A-k>'] = {
      navigator.up,
      'Window Up',
    },

    ['<A-j>'] = {
      navigator.down,
      'Window Down',
    },
  })
end

function M.buf_register(bufnr)
  wk.register({
    l = {
      name = 'LSP',

      a = {
        vim.lsp.buf.code_action,
        'LSP Code Actions',
      },

      r = {
        vim.lsp.buf.rename,
        'LSP Rename',
      },

      s = {
        telescope_builtin.lsp_document_symbols,
        'LSP Document Symbols',
      },

      S = {
        telescope_builtin.lsp_workspace_symbols,
        'LSP Workspace Symbols',
      },

      e = {
        vim.diagnostic.open_float,
        'Diagnostics Show Line',
      },

      E = {
        telescope_builtin.diagnostics,
        'Diagnostics Show Document',
      },

      f = {
        vim.lsp.buf.formatting,
        'LSP Format',
      },

      F = {
        vim.lsp.buf.formatting_seq_sync,
        'LSP Format',
      },
    },
  }, {
    prefix = '<Leader>',
    buffer = bufnr,
  })

  wk.register({
    gd = {
      vim.lsp.buf.definition,
      'LSP Definitions',
    },

    gi = {
      vim.lsp.buf.implementation,
      'LSP Implementations',
    },

    gD = {
      vim.lsp.buf.type_definition,
      'LSP Declaration',
    },

    gR = {
      vim.lsp.buf.references,
      'LSP References',
    },

    gt = {
      vim.lsp.buf.type_definition,
      'LSP Type Definitions',
    },

    gG = {
      require('neogen').generate,
      'Annotation Generate',
    },

    K = {
      vim.lsp.buf.hover,
      'LSP Hover',
    },

    ['[e'] = {
      vim.diagnostic.goto_prev,
      'LSP Diagnostic Prev',
    },

    [']e'] = {
      vim.diagnostic.goto_next,
      'LSP Diagnostic Next',
    },

    ['<C-k>'] = {
      builtin_lsp.peek,
      'Lsp Peek',
    },
  }, {
    buffer = bufnr,
  })
end

return M
