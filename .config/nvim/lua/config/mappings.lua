vim.g.mapleader = " "

-- leave insert mode
vim.keymap.set("i", "<C-c>", "<Esc>", { remap = false })

-- modify buffer
vim.keymap.set("n", "<Leader>d", ":bd<CR>", { remap = false })
vim.keymap.set("n", "<Leader>w", ":w!<CR>", { remap = false })
vim.keymap.set("n", "<Right>", ":bn<CR>", { remap = false })
vim.keymap.set("n", "<Left>", ":bp<CR>", { remap = false })
vim.keymap.set("n", "<C-x>", ":q<CR>", { remap = false })

-- kill trailing whitespace
vim.keymap.set("n", "<Leader>fw", ":%s/\\s\\+$//<CR>", { remap = false })

-- check spelling
vim.keymap.set("n", "<Leader>se", ":setlocal spell spelllang=en<CR>", { remap = false })
vim.keymap.set("n", "<Leader>sd", ":setlocal spell spelllang=de<CR>", { remap = false })
vim.keymap.set("n", "<Leader>sn", ":setlocal nospell<CR>", { remap = false })
