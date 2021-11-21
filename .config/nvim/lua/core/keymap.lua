local M = {}

local wk = require "which-key"
local set_keymap = vim.api.nvim_set_keymap

local noremap_opts = { noremap = true, silent = true }

function M.setup()
  wk.setup()

  -- hop
  wk.register {
    s = { "<cmd>HopLineStart<CR>", "HopLine" },
    S = { "<cmd>HopChar1<CR>", "HopChar" },
  }

  -- barbar
  wk.register({
    b = {
      name = "Buffer",

      b = { "<cmd>BufferPick<CR>", "BufferPick" },
      C = { "<cmd>BufferClose<CR>", "BufferClose" },
      o = { "<cmd>BufferOrderByBufferNumber<CR>", "BufferOrder ByNumber" },
      O = { "<cmd>BufferCloseAllButCurrent<CR>", "BufferCloseAll ButCurrent" },
      h = { "<cmd>BufferMovePrevious<CR>", "BufferMove Previous" },
      l = { "<cmd>BufferMoveNext<CR>", "BufferMove Next" },
      H = { "<cmd>BufferCloseBuffersLeft<CR>", "BufferClose Left" },
      L = { "<cmd>BufferCloseBuffersRight<CR>", "BufferClose Right" },
    },
  }, {
    prefix = "<Leader>",
  })
  wk.register {
    ["<Tab>"] = { "<cmd>BufferNext<CR>", "Buffer Next" },
    ["<S-Tab>"] = { "<cmd>BufferPrevious<CR>", "Buffer Previous" },
  }

  -- telescope
  wk.register({
    f = {
      name = "Find",

      a = { "<cmd>Telescope builtin<CR>", "Telescope Builtin" },
      b = { "<cmd>Telescope buffers<CR>", "Telescope Buffers" },
      f = { "<cmd>Telescope find_files<CR>", "Telescope Find Files" },
      g = { "<cmd>Telescope git_commits<CR>", "Telescope Git Commits" },
      h = { "<cmd>Telescope help_tags<CR>", "Telescope Help" },
      j = { "<cmd>Telescope jumplist<CR>", "Telescope Jump List" },
      k = { "<cmd>Telescope keymaps<CR>", "Telescope Keymaps" },
      l = { "<cmd>Telescope file_browser<CR>", "Telescope File Browser" },
      m = { "<cmd>Telescope man_pages<CR>", "Telescope Man Pages" },
      s = { "<cmd>Telescope live_grep<CR>", "Telescope Live Grep" },
    },
  }, {
    prefix = "<Leader>",
  })

  -- buffer fuzzy finder
  wk.register {
    ["\\"] = { "<cmd>Telescope current_buffer_fuzzy_find<CR>", "Telescope Buffer Search" },
  }

  -- nvimtree
  wk.register({
    ft = { "<cmd>NvimTreeToggle<CR>", "File Tree" },
  }, { prefix = "<Leader>" })

  -- fugitive
  wk.register({
    g = {
      name = "Git",

      g = { "<cmd>Git<CR>", "Git Status" },
      d = { "<cmd>Gvdiffsplit!<CR>", "Git Diff" },
      p = { "<cmd>Git pull<CR>", "Git Pull" },
      P = { "<cmd>Git push<CR>", "Git Push" },
    },
  }, {
    prefix = "<Leader>",
  })

  -- packer
  wk.register({
    P = {
      "<cmd>PackerSync<CR>",
      "Package Sync",
    },
  }, {
    prefix = "<Leader>",
  })

  -- fterm
  wk.register({
    T = {
      function()
        require("FTerm").open()
      end,
      "Float Term",
    },
  }, {
    prefix = "<Leader>",
  })

  -- undotree
  wk.register({
    U = { "<cmd>UndotreeToggle<CR>", "UndoTree" },
  }, { prefix = "<Leader>" })

  -- format
  wk.register({
    p = { "<cmd>Format<CR>", "Format" },
  }, { prefix = "<Leader>" })

  -- incsearch
  set_keymap("n", "n", "<Plug>(incsearch-nohl-n)", {})
  set_keymap("n", "N", "<Plug>(incsearch-nohl-N)", {})
  set_keymap("n", "*", "<Plug>(incsearch-nohl-*)", {})
  set_keymap("n", "#", "<Plug>(incsearch-nohl-#)", {})
  set_keymap("n", "g*", "<Plug>(incsearch-nohl-g*)", {})
  set_keymap("n", "g#", "<Plug>(incsearch-nohl-g#)", {})

  -- custom
  set_keymap("n", "<C-s>", "<cmd>write<CR>", noremap_opts)
  set_keymap("n", "<C-h>", "<cmd>wincmd h<CR>", noremap_opts)
  set_keymap("n", "<C-j>", "<cmd>wincmd j<CR>", noremap_opts)
  set_keymap("n", "<C-k>", "<cmd>wincmd k<CR>", noremap_opts)
  set_keymap("n", "<C-l>", "<cmd>wincmd l<CR>", noremap_opts)
  set_keymap("i", "<M-a>", "<Home>", noremap_opts)
  set_keymap("i", "<M-e>", "<End>", noremap_opts)
end

function M.buf_register(bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  wk.register({
    l = {
      name = "LSP",

      a = "Code Actions",
      aa = { "<cmd>Telescope lsp_code_actions<CR>", "LSP Code Actions" },
      ar = { "<cmd>lua vim.lsp.buf.rename()<CR>", "LSP Rename" },

      g = "Navigation",
      gr = { "<cmd>Telescope lsp_references<CR>", "LSP References" },
      gi = { "<cmd>Telescope lsp_implementations<CR>", "LSP Implementations" },
      gt = { "<cmd>Telescope lsp_type_definitions<CR>", "LSP Type Definitions" },
      gs = { "<cmd>Telescope lsp_document_symbols<CR>", "LSP Document Symbols" },

      e = "Diagnostics",
      ee = { "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", "Diagnostics Show Line" },
      el = { "<cmd>Telescope lsp_document_diagnostics<CR>", "Diagnostics Show Document" },
      ew = { "<cmd>Telescope lsp_workspace_diagnostics<CR>", "Diagnostics Show Workspace" },

      w = "Workspace",
      wa = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", "LSP Add Workspace Folder" },
      wr = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", "LSP Remove Workspace Folder" },
      ws = { "<cmd>Telescope lsp_workspace_symbols<CR>", "LSP Workspace Symbols" },
      wl = { "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", "LSP Workspace Folders" },

      f = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "LSP Format" },
    },
  }, {
    prefix = "<Leader>",
  })

  buf_set_keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", noremap_opts)
  buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", noremap_opts)
  buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", noremap_opts)
  buf_set_keymap("n", "[e", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", noremap_opts)
  buf_set_keymap("n", "]e", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", noremap_opts)
end

return M
