local M = {}

local lspconfig = require('lspconfig')
local null_ls = require('null-ls')
local schemastore = require('schemastore')
local cmp_nvim_lsp = require('cmp_nvim_lsp')
local keymap = require('core.keymap')
local builtin_lsp = require('builtin.lsp')
local lsp_servers = require('builtin.lsp').lsp_servers

local get_on_attach = function(disable_formatting)
  return function(client, bufnr)
    if disable_formatting then
      client.server_capabilities.document_formatting = false
      client.server_capabilities.document_range_formatting = false
    end

    keymap.lsp_buf_register(bufnr)
  end
end

local setup_lsp_installer = function()
  builtin_lsp
    .setup({
      capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities()),
    }, {
      get_on_attach = get_on_attach,
    })
    .startup(function(use)
      use('bashls')
      use('cssmodules_ls')
      use('dockerls')
      use('emmet_ls')
      use('gopls')
      use('kotlin_language_server')
      use('pyright')
      use('svelte')
      use('taplo')
      use('terraformls')
      use('vimls')
      use('volar')
      use('graphql', {
        single_file_support = true,
      })
      use('eslint', {
        handlers = {
          ['eslint/noLibrary'] = function()
            return {}
          end,
        },
      })
      use('html', {
        disable_formatting = true,
      })
      use('tailwindcss', {
        single_file_support = true,
      })
      use('cssls', {
        settings = {
          css = {
            validate = false,
          },
          less = {
            validate = false,
          },
          scss = {
            validate = false,
          },
        },
      })
      use('tsserver', {
        disable_formatting = true,
        init_options = {
          preferences = {
            disableSuggestions = true,
            includeCompletionsForImportStatements = true,
            importModuleSpecifierPreference = 'shortest',
            lazyConfiguredProjectsFromExternalProject = true,
          },
        },
      })
      use('jsonls', {
        disable_formatting = true,
        settings = {
          json = {
            schemas = schemastore.json.schemas(),
          },
        },
        get_language_id = function()
          return 'jsonc'
        end,
      })
      use('yamlls', {
        disable_formatting = true,
        settings = {
          yaml = {
            validate = false,
            hover = true,
            completion = true,
          },
        },
      })
      use('lua_ls', {}, function(opts)
        require('neodev').setup({})
        lspconfig.lua_ls.setup(opts)
      end)
      use('rust_analyzer', {
        settings = {
          ['rust-analyzer'] = {
            diagnostics = {
              disabled = {
                'incorrect-ident-case',
                'inactive-code',
              },
            },
          },
        },
      })
    end)

  require('mason').setup()

  require('mason-lspconfig').setup({
    ensure_installed = builtin_lsp.all(),
    automatic_installation = true,
  })

  for _, lsp in pairs(lsp_servers) do
    local config = builtin_lsp.find(lsp.name)

    if config.setup then
      config.setup(config.opts)
    else
      lspconfig[lsp.name].setup(config.opts)
    end
  end
end

local function setup_null_ls()
  local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

  null_ls.setup({
    sources = {
      null_ls.builtins.formatting.trim_newlines,
      null_ls.builtins.formatting.trim_whitespace,
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.prettierd,
      null_ls.builtins.formatting.clang_format,
      null_ls.builtins.formatting.swiftformat,
      null_ls.builtins.formatting.yapf,
      null_ls.builtins.formatting.shfmt.with({
        filetypes = { 'sh', 'zsh' },
        extra_args = { '-i', 2 },
      }),
      null_ls.builtins.formatting.fish_indent,
      null_ls.builtins.code_actions.gitsigns,
    },
    on_attach = function(client, bufnr)
      if client.supports_method('textDocument/formatting') then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd('BufWritePre', {
          group = augroup,
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({
              bufnr = bufnr,
              filter = function(fmt_client)
                return fmt_client.name == 'null-ls'
              end,
            })
          end,
        })
      end
    end,
  })
end

function M.setup()
  setup_lsp_installer()
  setup_null_ls()

  vim.diagnostic.config({
    update_in_insert = true,
    severity_sort = true,
    virtual_text = { source = 'always' },
    float = { source = 'always' },
  })
end

return M
