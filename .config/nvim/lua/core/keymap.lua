local M = {}

local wk = require "which-key"
local hop = require "hop"
local telescope_builtin = require "telescope.builtin"
local treeView = require "nvim-tree.view"
local bufferline = require "bufferline"

function M.setup()
  wk.setup()

  -- hop
  wk.register {
    s = {
      function()
        hop.hint_lines_skip_whitespace()
      end,
      "HopLine",
    },
    S = {
      function()
        hop.hint_char1()
      end,
      "HopChar",
    },
  }

  -- bufferline
  wk.register({
    b = {
      name = "Buffer",

      b = { "<cmd>BufferLinePick<CR>", "BufferPick" },
      O = { "<cmd>silent! BufOnly<CR>", "BufferOnly" },
      c = {
        function()
          local explorerWindow = treeView.get_winnr()
          local wasExplorerOpen = vim.api.nvim_win_is_valid(explorerWindow)

          local bufferToDelete = vim.api.nvim_get_current_buf()

          if wasExplorerOpen then
            bufferline.cycle(-1)
          end

          vim.cmd("bdelete! " .. bufferToDelete)
        end,
        "BufferClose",
      },
      C = { "<cmd>BufferLinePickClose<CR>", "BufferPickClose" },
      h = { "<cmd>BufferLineMovePrev<CR>", "BufferMove Previous" },
      l = { "<cmd>BufferLineMoveNext<CR>", "BufferMove Next" },
      H = { "<cmd>BufferLineCloseLeft<CR>", "BufferClose Left" },
      L = { "<cmd>BufferLineCloseRight<CR>", "BufferClose Right" },
    },
  }, {
    prefix = "<Leader>",
  })

  wk.register {
    ["<Tab>"] = { "<cmd>BufferLineCycleNext<CR>", "Buffer Next" },
    ["<S-Tab>"] = { "<cmd>BufferLineCyclePrev<CR>", "Buffer Previous" },
  }

  -- telescope
  wk.register({
    f = {
      name = "Find",

      a = {
        function()
          telescope_builtin.builtin()
        end,
        "Telescope Builtin",
      },
      b = {
        function()
          telescope_builtin.buffers()
        end,
        "Telescope Buffers",
      },
      f = {
        function()
          telescope_builtin.find_files()
        end,
        "Telescope Find Files",
      },
      g = {
        function()
          telescope_builtin.git_commits()
        end,
        "Telescope Git Commits",
      },
      h = {
        function()
          telescope_builtin.help_tags()
        end,
        "Telescope Help",
      },
      j = {
        function()
          telescope_builtin.jumplist()
        end,
        "Telescope Jump List",
      },
      k = {
        function()
          telescope_builtin.keymaps()
        end,
        "Telescope Keymaps",
      },
      l = {
        function()
          require("telescope").extensions.file_browser.file_browser()
        end,
        "Telescope File Browser",
      },
      m = {
        function()
          telescope_builtin.man_pages()
        end,
        "Telescope Man Pages",
      },
      s = {
        function()
          telescope_builtin.live_grep()
        end,
        "Telescope Live Grep",
      },
    },
  }, {
    prefix = "<Leader>",
  })

  -- buffer fuzzy finder
  wk.register {
    ["\\"] = {
      function()
        telescope_builtin.current_buffer_fuzzy_find()
      end,
      "Telescope Buffer Search",
    },
  }

  -- nvimtree
  wk.register({
    ft = {
      function()
        require("nvim-tree").toggle()
      end,
      "File Tree",
    },
    fT = {
      function()
        require("nvim-tree.lib").collapse_all()
      end,
      "File Tree Collapse",
    },
  }, { prefix = "<Leader>" })

  -- fugitive
  wk.register({
    g = {
      name = "Git",

      g = { "<cmd>Git<CR>", "Git Status" },
      p = { "<cmd>Git pull<CR>", "Git Pull" },
      P = { "<cmd>Git push<CR>", "Git Push" },
    },
  }, {
    prefix = "<Leader>",
  })

  -- packer
  wk.register({
    P = {
      function()
        require("packer").sync()
      end,
      "Package Sync",
    },
  }, {
    prefix = "<Leader>",
  })

  -- undotree
  wk.register({
    U = { "<cmd>UndotreeToggle<CR>", "UndoTree Toggle" },
  }, { prefix = "<Leader>" })

  -- copilot
  wk.register({
    ["<C-l>"] = {
      function()
        vim.api.nvim_feedkeys(vim.fn["copilot#Accept"](), "i", true)
      end,
      "Copilot",
    },
  }, { mode = "i" })

  -- custom
  wk.register {
    ["<C-s>"] = { "<cmd>silent! write<CR>", "Buffer Save" },
    ["<C-h>"] = { "<cmd>wincmd h<CR>", "Window Left" },
    ["<C-l>"] = { "<cmd>wincmd l<CR>", "Window Right" },
    ["<C-k>"] = { "<cmd>wincmd k<CR>", "Window Top" },
    ["<C-j>"] = { "<cmd>wincmd j<CR>", "Window Bottom" },
  }
end

function M.buf_register(bufnr)
  wk.register({
    l = {
      name = "LSP",

      a = {
        function()
          vim.lsp.buf.code_action()
        end,
        "LSP Code Actions",
      },

      r = {
        function()
          vim.lsp.buf.rename()
        end,
        "LSP Rename",
      },

      R = {
        function()
          vim.lsp.buf.references()
        end,
        "LSP References",
      },

      i = {
        function()
          vim.lsp.buf.implementation()
        end,
        "LSP Implementations",
      },

      t = {
        function()
          vim.lsp.buf.type_definition()
        end,
        "LSP Type Definitions",
      },

      s = {
        function()
          telescope_builtin.lsp_document_symbols()
        end,
        "LSP Document Symbols",
      },

      S = {
        function()
          vim.lsp.buf.workspace_symbol()
        end,
        "LSP Workspace Symbols",
      },

      e = {
        function()
          vim.diagnostic.open_float()
        end,
        "Diagnostics Show Line",
      },

      E = {
        function()
          vim.diagnostic.setloclist()
        end,
        "Diagnostics Show Document",
      },

      f = {
        function()
          vim.lsp.buf.formatting()
        end,
        "LSP Format",
      },
    },
  }, {
    prefix = "<Leader>",
    buffer = bufnr,
  })

  wk.register({
    gd = {
      function()
        vim.lsp.buf.definition()
      end,
      "LSP Definitions",
    },
    gD = {
      function()
        vim.lsp.buf.declaration()
      end,
      "LSP Declaration",
    },
    K = {
      function()
        vim.lsp.buf.hover()
      end,
      "LSP Hover",
    },
    ["[e"] = {
      function()
        vim.diagnostic.goto_prev()
      end,
      "LSP Diagnostic Prev",
    },
    ["]e"] = {
      function()
        vim.diagnostic.goto_next()
      end,
      "LSP Diagnostic Next",
    },
  }, {
    buffer = bufnr,
  })
end

return M
