vim.g.mapleader = " "
vim.o.number = true
vim.o.cursorline = true
vim.o.undofile = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.confirm = true
vim.o.wrap = true
vim.o.signcolumn = "number"
vim.o.scrolloff = 4

vim.cmd([[ 
  colorscheme tokyonight
  packadd cfilter
]])
