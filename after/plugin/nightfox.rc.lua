local status, n = pcall(require, "nightfox")
if (not status) then return end

n.setup({
  comment_italics = true,
})

vim.cmd("colorscheme nightfox")
