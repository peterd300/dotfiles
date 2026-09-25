local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.mouse = "a"
opt.clipboard = "unnamedplus"   -- share clipboard with OS
opt.termguicolors = true

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true

opt.ignorecase = true
opt.smartcase = true
opt.wrap = false
opt.scrolloff = 8
opt.signcolumn = "yes"

vim.g.mapleader = " "