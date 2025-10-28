-- LSP related plugins.

return {
  {
    {
      "rachartier/tiny-inline-diagnostic.nvim",
      event = "VeryLazy",
      priority = 1000,
      opts = {
        preset = "powerline",
      },
    },
  },
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
    event = "LspAttach",
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
}
