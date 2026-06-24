return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash",
          "c",
          "html",
          "javascript",
          "json",
          "lua",
          "luadoc",
          "markdown",
          "markdown_inline",
          "php",
          "python",
          "query",
          "regex",
          "swift",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "yaml",
        },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
}
