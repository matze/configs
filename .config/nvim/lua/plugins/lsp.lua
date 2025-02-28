-- LSP related plugins, i.e. basic configuration and extensions like rust tools.

return {
  {
    "neovim/nvim-lspconfig",
    event = "BufRead",
    dependencies = { "saghen/blink.cmp" },
    keys = {
      { "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", remap = false, silent = true },
      { "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", remap = false, silent = true },
      { "K", "<cmd>lua vim.lsp.buf.hover()<CR>", remap = false, silent = true },
      { "<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", remap = false, silent = true },
    },
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
      {
        url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = function()
          require("lsp_lines").setup()

          vim.diagnostic.config({
            virtual_lines = false,  -- disable by default
            virtual_text = false,  -- avoid double diagnostics
          })

          vim.keymap.set("", "<Leader>l", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })
        end,
      }
    },
  },
}
