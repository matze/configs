-- LSP related plugins, i.e. basic configuration and extensions like rust tools.

return {
  {
    "neovim/nvim-lspconfig",
    event = "BufRead",
    dependencies = { "saghen/blink.cmp" },
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      require("lspconfig").rust_analyzer.setup({
        capabilities = capabilities,
        -- settings = {
        --   ["rust-analyzer"] = {
        --     checkOnSave = {
        --       command = "clippy"
        --     }
        --   }
        -- }
      })
      require("lspconfig").tinymist.setup({
        capabilities = capabilities,
        single_file_support = true,
        root_dir = function()
          return vim.fn.getcwd()
        end,
      })
      require("lspconfig").clangd.setup({})
      require("lspconfig").ruff.setup({})

      local signs = { Error = "", Warn = "", Hint = "", Info = "" }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end
    end,
    dependencies = {
      {
        "chrisgrieser/nvim-lsp-endhints",
        event = "LspAttach",
        opts = {},
        config = function()
          require("lsp-endhints").setup({
            icons = {
              type = "=> ",
              parameter = "<- ",
              offspec = " ", -- hint kind not defined in official LSP spec
              unknown = " ", -- hint kind is nil
            },
          })
        end
      },
      {
        "j-hui/fidget.nvim",
        config = function()
          require("fidget").setup({
            progress = {
              display = {
                done_ttl = 0,
              },
              lsp = {
                progress_ringbuf_size = 16384,
              },
            }
          })
        end
      },
    },
  },
}
