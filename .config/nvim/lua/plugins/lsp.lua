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
      require("lspconfig").pylsp.setup({})
    end,
    dependencies = {
      {
        "j-hui/fidget.nvim",
        tag = "legacy",
        config = function()
          require("fidget").setup({
            text = {
              spinner = "dots",
            },
            timer = {
              fidget_decay = 0,
              task_decay = 0,
            },
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
    "simrat39/rust-tools.nvim",
    ft = "rust",
    config = function()
      require("rust-tools").setup({
        server = {
          capabilities = {
            textDocument = {
              completion = {
                completionItem = {
                  snippetSupport = false
                }
              }
            }
          },
          settings = {
            ["rust-analyzer"] = {
              inlayHints = { locationLinks = false },
            },
          },
        },
        tools = {
          inlay_hints = {
            show_parameter_hints = true,
            parameter_hints_prefix = "← ",
            other_hints_prefix = "⇒ ",
          },
        },
        hover_actions = {
          auto_focus = true,
        },
      })
    end,
  },
  {
    "p00f/clangd_extensions.nvim",
    ft = { "c", "cpp" },
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
