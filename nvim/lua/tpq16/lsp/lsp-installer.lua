local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

local servers = {
  "ccls",
  "sumneko_lua",
  "cssls",
  "html",
  "tsserver",
  "pyright",
  "bashls",
  "jsonls",
  "yamlls",
}

lsp_installer.setup()

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local opts = {}

for _, server in pairs(servers) do
  opts = {
    on_attach = require("tpq16.lsp.handlers").on_attach,
    capabilities = require("tpq16.lsp.handlers").capabilities,
  }
--Start
  if server == "sumneko_lua" then
    local sumneko_opts = require "tpq16.lsp.settings.sumneko_lua"
    opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
  end

  if server == "pyright" then
    local pyright_opts = require "tpq16.lsp.settings.pyright"
    opts = vim.tbl_deep_extend("force", pyright_opts, opts)
  end

  if server == "ccls" then
    local ccls_opts = require "tpq16.lsp.settings.ccls"
    opts = vim.tbl_deep_extend("force", ccls_opts, opts)
  end
--End
  lspconfig[server].setup(opts)
end
