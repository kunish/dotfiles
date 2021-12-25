local M = {}

local lspconfig = require('lspconfig')
local lsp_installer = require('nvim-lsp-installer')
local lsp_installer_servers = require('nvim-lsp-installer.servers')
local null_ls = require('null-ls')
local schemastore = require('schemastore')
local cmp_nvim_lsp = require('cmp_nvim_lsp')
local keymap = require('core.keymap')
local lsp_servers = require('utils.lsp').lsp_servers
local rust_tools = require('rust-tools')

local get_on_attach = function(disable_formatting)
  return function(client, bufnr)
    if disable_formatting then
      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false
    end

    keymap.buf_register(bufnr)
  end
end

local capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())

local setup_lsp_installer = function()
  require('utils.lsp').setup({
    capabilities = capabilities,
    get_on_attach = get_on_attach,
  }).startup(function(use)
    use('bashls')
    use('cssmodules_ls')
    use('dartls')
    use('dockerls')
    use('emmet_ls')
    use('flow')
    use('gopls')
    use('grammarly')
    use('html')
    use('kotlin_language_server')
    use('pyright')
    use('sorbet')
    use('svelte')
    use('terraformls')
    use('vimls')
    use('volar')
    use('sourcekit', {
      single_file_support = true,
    })
    use('ansiblels', {
      autostart = false,
    })
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
      disable_diagnostics = true,
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
          schemaStore = {
            enable = true,
            url = 'https://www.schemastore.org/api/json/catalog.json',
          },
        },
      },
    })
    use('sumneko_lua', function()
      local runtime_path = vim.split(package.path, ';')
      table.insert(runtime_path, 'lua/?.lua')
      table.insert(runtime_path, 'lua/?/init.lua')

      return {
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT',
              path = runtime_path,
            },
            diagnostics = {
              globals = { 'vim' },
            },
            workspace = {
              library = vim.api.nvim_list_runtime_paths(),
              preloadFileSize = 1024,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      }
    end)
    use('rust_analyzer', {
      settings = {
        ['rust-analyzer'] = {
          diagnostics = {
            disabled = {
              'incorrect-ident-case',
            },
          },
        },
      },
    }, function(server, opts)
      rust_tools.setup({
        server = {
          cmd = server._default_options.cmd,
          capabilities = opts.capabilities,
          on_attach = opts.on_attach,
        },
      })
    end)
  end)

  local on_server_ready = function(server)
    local config = require('utils.lsp').find(server.name)
    local opts = config.opts

    if config.setup then
      config.setup(server, opts)
    else
      server:setup(opts)
    end
  end

  lsp_installer.on_server_ready(on_server_ready)

  for _, lsp in pairs(lsp_servers) do
    local server_available, requested_server = lsp_installer_servers.get_server(lsp.name)

    if server_available then
      if not requested_server:is_installed() then
        requested_server:install()
      end
    else
      lspconfig[lsp.name].setup({
        capabilities = capabilities,
        on_attach = get_on_attach(),
        autostart = false,
      })
    end
  end
end

local function setup_null_ls()
  null_ls.setup({
    sources = {
      null_ls.builtins.formatting.trim_newlines,
      null_ls.builtins.formatting.trim_whitespace,
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.prettierd,
      null_ls.builtins.formatting.taplo,
      null_ls.builtins.formatting.clang_format,
      null_ls.builtins.formatting.shfmt.with({
        filetypes = { 'sh', 'zsh' },
        extra_args = { '-i', 2 },
      }),
      null_ls.builtins.formatting.fish_indent,
      null_ls.builtins.code_actions.gitsigns,
    },
    on_attach = function(client)
      if client.resolved_capabilities.document_formatting then
        vim.cmd('autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()')
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
    float = { source = 'always' },
  })
end

return M
