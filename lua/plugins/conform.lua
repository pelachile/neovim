return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      php = { "pint", "php_cs_fixer", stop_after_first = true },
      blade = { "blade-formatter" },
      html = { "prettierd", "prettier" },
      lua = { "stylua" },
      javascript = { "biome", "biome-organize-imports" },
      javascriptreact = { "biome", "biome-organize-imports" },
      typescript = { "biome", "biome-organize-imports" },
      typescriptreact = { "biome", "biome-organize-imports" },
    },
  },
  {
    -- Remove phpcs linter.
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        php = {},
      },
    },
  },
}
