local cpp_filetypes = { "c", "cpp", "objc", "objcpp" }

local formatters_by_ft = {}
for _, filetype in ipairs(cpp_filetypes) do
  formatters_by_ft[filetype] = { "clang-format" }
end

return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      formatters_by_ft = formatters_by_ft,
      format_on_save = {
        timeout_ms = 1000,
        lsp_format = "never",
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local lint = require("lint")

      for _, filetype in ipairs(cpp_filetypes) do
        lint.linters_by_ft[filetype] = { "clangtidy" }
      end

      local group = vim.api.nvim_create_augroup("cpp-lint-on-save", { clear = true })
      vim.api.nvim_create_autocmd("BufWritePost", {
        group = group,
        pattern = { "*.c", "*.cc", "*.cpp", "*.cxx", "*.h", "*.hh", "*.hpp", "*.hxx" },
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
