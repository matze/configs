require("config.options")
require("config.mappings")
require("config.autocmds")
require("config.filetypes")
require("config.lazy")

vim.lsp.enable({"clangd", "gopls", "ruff", "rust-analyzer", "tinymist", "ty"})

if vim.o.background == "light" then
  vim.cmd([[colorscheme jellybeans-muted-light]])
else
  vim.cmd([[colorscheme jellybeans]])
end
