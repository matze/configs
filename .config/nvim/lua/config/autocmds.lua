-- Auto-format Rust, C and C++ with LSP
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = {"*.rs", "*.c", "*.cpp", "*.h"},
  callback = function(ev)
    vim.lsp.buf.format()
  end
})

-- Set indentation to 2 for select file types
vim.api.nvim_create_autocmd("FileType", {
  pattern = {"css,lua"},
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
  end
})
