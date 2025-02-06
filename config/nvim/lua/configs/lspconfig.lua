-- Carregar configurações padrão do NvChad LSP
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

-- Configuração do lspconfig
local lspconfig = require "lspconfig"
local servers = {
  "html",
  "cssls",
  "gopls",
  "pyright",  -- LSP para Python
  "ruff",     -- Linter para Python
}

local null_ls = require('null-ls')

-- Configuração do LSP para os servidores com configuração padrão
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

lspconfig.html.setup({
  on_attach = function(client, bufnr)
    -- Formatação automática ao salvar
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ bufnr = bufnr })
      end,
    })
  end,
  capabilities = require("cmp_nvim_lsp").default_capabilities(), -- Integra com nvim-cmp
})

-- Configuração para CSS
lspconfig.cssls.setup({
  on_attach = function(client, bufnr)
    -- Formatação automática ao salvar
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ bufnr = bufnr })
      end,
    })
  end,
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
  settings = {
    css = {
      validate = true,
    },
    less = {
      validate = true,
    },
    scss = {
      validate = true,
    },
  },
})


lspconfig.gopls.setup({
  on_attach = function(client, bufnr)
    -- Organizar imports e formatar antes de salvar
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        -- Organiza imports com gopls
        -- Formata o arquivo
        vim.lsp.buf.format({ bufnr = bufnr })
      end,
    })
  end,
  settings = {
    gopls = {
      gofumpt = true, -- Usa o formato gofumpt (mais rigoroso que o gofmt)
      analyses = {
        unusedparams = true, -- Detecta parâmetros não usados
      },
      staticcheck = true, -- Ativa checks estáticos adicionais
    },
  },
})

-- Configuração do null-ls
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.blue,
    null_ls.builtins.formatting.isort.with({
      extra_args = { "--profile", "blue" },
    }),
    null_ls.builtins.diagnostics.ruff,
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = "LspFormatting", buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("LspFormatting", { clear = true }),
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
})

-- Configuração do Pyright (LSP para Python)
lspconfig.pyright.setup({
  on_attach = function(client, bufnr)
    -- Habilitar formatação automática apenas para o Pyright
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format()
      end,
    })
  end,
})
