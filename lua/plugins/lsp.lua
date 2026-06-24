local servers = {
  "clangd",
  "intelephense",
  "ts_ls",
  "html",
  "cssls",
}

return {
  {
    "neovim/nvim-lspconfig",
    version = "v2.3.0",
    lazy = false,
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.diagnostic.config({
        severity_sort = true,
        float = { border = "rounded" },
        signs = true,
        underline = true,
        update_in_insert = false,
        virtual_text = { prefix = "●", spacing = 4 },
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
          end

          map("gd", vim.lsp.buf.definition, "Go to definition")
          map("gD", vim.lsp.buf.declaration, "Go to declaration")
          map("gI", vim.lsp.buf.implementation, "Go to implementation")
          map("gr", vim.lsp.buf.references, "Go to references")
          map("K", vim.lsp.buf.hover, "Hover documentation")
          map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
          map("<leader>ca", vim.lsp.buf.code_action, "Code action")
        end,
      })

      for _, server in ipairs(vim.list_extend(vim.deepcopy(servers), { "sourcekit" })) do
        vim.lsp.config(server, { capabilities = capabilities })
      end

      vim.lsp.enable("sourcekit")
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    version = "v2.1.0",
    lazy = false,
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = servers,
      automatic_enable = servers,
    },
  },
}
