-- Auto-format Rust, C and C++ with LSP
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = {"*.rs", "*.c", "*.cpp", "*.h"},
  callback = function(ev)
    vim.lsp.buf.format()
  end
})
