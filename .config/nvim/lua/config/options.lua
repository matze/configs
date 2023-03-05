vim.opt.modeline = true
vim.opt.showcmd = false
vim.opt.cursorcolumn = false
vim.opt.errorbells = false
vim.opt.cursorline = true
vim.opt.history = 1000
vim.opt.wildmenu = true
vim.opt.hidden = true
vim.opt.scrolloff = 2
vim.opt.sidescrolloff = 2
vim.opt.mouse = "a"
vim.opt.guicursor = ""
vim.opt.signcolumn = "yes"
vim.opt.clipboard = "unnamedplus"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.wrapscan = true
vim.opt.incsearch = true
vim.opt.textwidth = 80
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.linebreak = true
vim.opt.number = true
vim.opt.list = true
vim.opt.listchars = { tab = "› ", trail = "•", nbsp = "␣" }
vim.opt.fillchars = { fold = "·" }
vim.opt.backspace = "indent,eol,start"
vim.opt.foldenable = true
vim.opt.foldmethod = "marker"
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.laststatus = 3
-- Ideally I would like to hide the command line by setting it to 0 but there is
-- a bug with macro recordings.
vim.opt.cmdheight = 1
