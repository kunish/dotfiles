local M = {}

local lspconfig = require('lspconfig')
local lsp_installer = require('nvim-lsp-installer')
local lsp_installer_servers = require('nvim-lsp-installer.servers')
local null_ls = require('null-ls')
local schemastore = require('schemastore')
local cmp_nvim_lsp = require('cmp_nvim_lsp')
local keymap = require('core.keymap')
local builtin_lsp = require('builtin.lsp')
local lsp_servers = require('builtin.lsp').lsp_servers
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

local setup_lsp_installer = function()
  builtin_lsp.setup({
    capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities()),
  }, {
    get_on_attach = get_on_attach,
  }).startup(function(use)
    use('bashls')
    use('cssmodules_ls')
    use('dartls')
    use('dockerls')
    use('emmet_ls')
    use('gopls')
    use('html')
    use('kotlin_language_server')
    use('pyright')
    use('sorbet')
    use('svelte')
    use('taplo')
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
    use('flow', {
      autostart = false,
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
    use('sumneko_lua', nil, function(server, opts)
      local config = vim.tbl_extend('force', server._default_options, opts)

      local luadev = require('lua-dev').setup({
        lspconfig = config,
      })

      lspconfig.sumneko_lua.setup(luadev)
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
      local config = vim.tbl_extend('force', server._default_options, opts)

      rust_tools.setup({
        tools = {
          autoSetHints = false,
        },
        server = config,
      })
    end)
  end)

  local on_server_ready = function(server)
    local config = builtin_lsp.find(server.name)

    if config == nil then
      return
    end

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
      local config = builtin_lsp.find(lsp.name)

      lspconfig[lsp.name].setup(config.opts)
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
    virtual_text = { source = 'always' },
    float = { source = 'always' },
  })
end

return M
