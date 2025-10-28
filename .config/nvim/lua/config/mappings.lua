vim.g.mapleader = " "

-- leave insert mode
vim.keymap.set("i", "<C-c>", "<Esc>", { remap = false })

-- modify buffer
vim.keymap.set("n", "<Leader>d", ":bd<CR>", { remap = false })
vim.keymap.set("n", "<Leader>w", ":w!<CR>", { remap = false })
vim.keymap.set("n", "<Right>", ":bn<CR>", { remap = false })
vim.keymap.set("n", "<Left>", ":bp<CR>", { remap = false })
vim.keymap.set("n", "<C-x>", ":q<CR>", { remap = false })

-- split navigation
vim.keymap.set("n", "<C-j>", "<C-w>w")
vim.keymap.set("n", "<C-k>", "<C-w>W")

-- kill trailing whitespace
vim.keymap.set("n", "<Leader>fw", ":%s/\\s\\+$//<CR>", { remap = false })

-- check spelling
vim.keymap.set("n", "<Leader>se", ":setlocal spell spelllang=en<CR>", { remap = false })
vim.keymap.set("n", "<Leader>sd", ":setlocal spell spelllang=de<CR>", { remap = false })
vim.keymap.set("n", "<Leader>sn", ":setlocal nospell<CR>", { remap = false })

-- jump to next diagnostic
vim.keymap.set("n", "gn", vim.diagnostic.goto_next)
vim.keymap.set("n", "gp", vim.diagnostic.goto_prev)
