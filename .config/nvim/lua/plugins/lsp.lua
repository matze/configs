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
        config = function()
          require('fidget').setup({
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
    },
  },
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    config = function()
      require("rust-tools").setup {
        server = {
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
      }
    end,
  }
}
