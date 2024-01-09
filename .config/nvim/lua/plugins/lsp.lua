-- LSP related plugins, i.e. basic configuration and extensions like rust tools.

return {
  {
    "neovim/nvim-lspconfig",
    event = "BufRead",
    keys = {
      { "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", remap = false, silent = true },
      { "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", remap = false, silent = true },
      { "K", "<cmd>lua vim.lsp.buf.hover()<CR>", remap = false, silent = true },
      { "<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", remap = false, silent = true },
    },
    config = function()
      require("lspconfig").rust_analyzer.setup({})
      require("lspconfig").pylsp.setup({})
      require("lspconfig").typst_lsp.setup({})
    end,
    dependencies = {
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
  {
    "p00f/clangd_extensions.nvim",
    commit = "52b7e6f1d27de19e30e0c9e492b650f934be3f5e",
    ft = { "c", "cpp" },
    pin = true,
    config = function()
      require("clangd_extensions").setup({
        extensions = {
          inlay_hints = {
            show_parameter_hints = true,
            parameter_hints_prefix = "← ",
            other_hints_prefix = "⇒ ",
          }
        }
      })
    end,
  }
}
