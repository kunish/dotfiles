local M = {}

local cmp = require("cmp")
local lspkind = require("lspkind")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")

function M.setup()
  local cmp_snippet_sources = {
    { name = "nvim_lsp" },
    { name = "vsnip" },
    { name = "buffer" },
    { name = "path" },
    { name = "nvim_lua" },
  }

  cmp.setup({
    formatting = {
      format = lspkind.cmp_format({
        with_text = true,
        menu = {
          nvim_lsp = "[LSP]",
          vsnip = "[VSnip]",
          buffer = "[Buffer]",
          path = "[Path]",
          nvim_lua = "[Lua]",
        },
      }),
    },
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = {
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-j>"] = cmp.mapping.complete(),
      ["<C-d>"] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp_snippet_sources,
  })

  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

return M
