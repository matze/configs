-- Auto-format Rust, Python, C and C++ with LSP
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = {"*.rs", "*.c", "*.cpp", "*.h", "*.py"},
  callback = function(ev)
    vim.lsp.buf.format()
  end
})

-- Set indentation to 2 for select file types
vim.api.nvim_create_autocmd("FileType", {
  pattern = {"css,lua,tex"},
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
  end
})

-- Enable inlay hints
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local id = vim.tbl_get(event, "data", "client_id")
    local client = id and vim.lsp.get_client_by_id(id)
    if client == nil or not client.supports_method("textDocument/inlayHint") then
      return
    end

    vim.lsp.inlay_hint.enable(true)
  end
})
