local M = {}

local lsp_installer = require "nvim-lsp-installer"
local lsp_installer_servers = require "nvim-lsp-installer.servers"
local lspconfig = require "lspconfig"
local null_ls = require "null-ls"
local schemastore = require "schemastore"
local cmp_nvim_lsp = require "cmp_nvim_lsp"
local lsp_servers = require("utils.lsp").lsp_servers
local use = require("utils.lsp").use
local utils = require "utils.lsp"

--- @diagnostic disable-next-line: unused-local
local on_attach = function(client, bufnr)
  require("core.keymap").buf_register(bufnr)
end

local capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())

local setup_utils = function()
  utils.setup(capabilities)
end

local setup_lsp_installer = function()
  use "bashls"
  use "clangd"
  use "dartls"
  use "dockerls"
  use "gopls"
  use "html"
  use "kotlin_language_server"
  use "pyright"
  use "rust_analyzer"
  use "sorbet"
  use "svelte"
  use "terraformls"
  use "vimls"
  use "volar"
  use("ansiblels", {
    autostart = false,
  })
  use("graphql", {
    single_file_support = true,
  })
  use("tailwindcss", {
    single_file_support = true,
  })
  use("emmet_ls", {
    single_file_support = true,
  })
  use("cssls", {
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
  use("sumneko_lua", function()
    local runtime_path = vim.split(package.path, ";")
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")

    return {
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
            path = runtime_path,
          },
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = vim.api.nvim_list_runtime_paths(),
          },
          telemetry = {
            enable = false,
          },
        },
      },
    }
  end)
  use("tsserver", {
    disable_formatting = true,
    init_options = {
      preferences = {
        disableSuggestions = true,
        includeCompletionsForImportStatements = true,
        importModuleSpecifierPreference = "shortest",
        lazyConfiguredProjectsFromExternalProject = true,
      },
    },
  })
  use("jsonls", {
    disable_formatting = true,
    settings = {
      json = {
        schemas = schemastore.json.schemas(),
      },
    },
    get_language_id = function(_, filetype)
      return filetype == "json" and "jsonc" or filetype
    end,
  })
  use("yamlls", {
    disable_formatting = true,
    settings = {
      yaml = {
        validate = false,
        hover = true,
        completion = true,
        schemaStore = {
          enable = true,
          url = "https://www.schemastore.org/api/json/catalog.json",
        },
      },
    },
  })

  local on_server_ready = function(server)
    for _, lsp in pairs(lsp_servers) do
      if lsp.name == server.name then
        local opts = lsp.opts

        opts.on_attach = function(client, bufnr)
          if opts.disable_formatting then
            client.resolved_capabilities.document_formatting = false
            client.resolved_capabilities.document_range_formatting = false
          end

          on_attach(client, bufnr)
        end

        server:setup(opts)

        break
      end
    end
  end

  lsp_installer.on_server_ready(on_server_ready)

  for _, lsp in pairs(lsp_servers) do
    local server_available, requested_server = lsp_installer_servers.get_server(lsp.name)

    if server_available and not requested_server:is_installed() then
      requested_server:install()
    end
  end
end

local function setup_lspconfig()
  lspconfig.sourcekit.setup {
    capabilities = capabilities,
    on_attach = on_attach,
  }
end

local function setup_null_ls()
  null_ls.config {
    sources = {
      null_ls.builtins.formatting.trim_newlines,
      null_ls.builtins.formatting.trim_whitespace,
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.prettierd,
      null_ls.builtins.formatting.taplo,
      null_ls.builtins.formatting.clang_format,
      null_ls.builtins.formatting.sqlformat,
      null_ls.builtins.formatting.shfmt.with {
        filetypes = { "sh", "zsh" },
        extra_args = { "-i", 2 },
      },
      null_ls.builtins.formatting.fish_indent,
      null_ls.builtins.formatting.nginx_beautifier,
      null_ls.builtins.diagnostics.eslint_d,
    },
  }

  lspconfig["null-ls"].setup {
    on_attach = function(client)
      if client.resolved_capabilities.document_formatting then
        vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()"
      end
    end,
  }
end

function M.setup()
  setup_utils()
  setup_lsp_installer()
  setup_lspconfig()
  setup_null_ls()

  vim.diagnostic.config {
    update_in_insert = true,
  }
end

return M
