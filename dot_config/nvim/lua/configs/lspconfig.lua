-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = {
  "html",
  "cssls",
  "gopls",
  "svelte",
  "tsserver",
  "quick_lint_js",
  "eslint",
  "astro",
  "clangd",
  "cmake",
  "docker_compose_language_service",
  "dockerls",
  "dotls",
  "elixirls",
  "htmx",
  "java_language_server",
  "jsonls",
  "marksman",
  "mdx_analyzer",
  "nginx_language_server",
  "rust_analyzer",
  "sqlls",
  "tailwindcss",
  "yamlls",
}
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- configuring single server, example: typescript
-- lspconfig.tsserver.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
