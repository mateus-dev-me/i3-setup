local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettierd", "prettier" },
    html = { "prettierd", "prettier" },
    typescript = { { "prettierd", "prettier" } },
    typescriptreact = { { "prettierd", "prettier" } },
    javascript = { { "prettierd", "prettier" } },
    javascriptreact = { { "prettierd", "prettier" } },
    json = { { "prettierd", "prettier" } },
    sql = { "sqlfmt" },
    toml = { "taplo" },
    yaml = { "yamlls" },
    python = {
      -- To fix lint errors.
      "ruff_fix",
      -- To run the Ruff formatter.
      "ruff_format",
    },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

require("conform").setup(options)
