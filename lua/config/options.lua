vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

-- Editing
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true
opt.autoindent = true
opt.breakindent = true
opt.undofile = true
opt.swapfile = false
opt.confirm = true

-- Search and completion
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = "split"
opt.completeopt = { "menu", "menuone", "noselect" }
opt.timeoutlen = 300
opt.updatetime = 250

-- Interface
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.termguicolors = true
opt.mouse = "a"
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = false

-- Windows
opt.splitright = true
opt.splitbelow = true
opt.winminwidth = 5
opt.winminheight = 1

-- System clipboard integration
opt.clipboard = "unnamedplus"
