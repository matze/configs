require("config.options")
require("config.mappings")
require("config.autocmds")
require("config.filetypes")
require("config.lazy")

vim.lsp.enable({"clangd", "ruff", "rust-analyzer", "tinymist", "ty"})
