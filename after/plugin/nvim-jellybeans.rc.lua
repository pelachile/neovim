local status, n = pcall(require, "jellybeans")
if (not status) then return end

n.setup({
  comment_italics = true,
})

vim.cmd[[colorscheme jellybeans]]
