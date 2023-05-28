local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "clangd", "phpactor", "pylsp", "bashls"}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig.html.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = {"blade.php", "html"}
}

lspconfig.cssls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = {"php", "html", "scss", "css"}
}

