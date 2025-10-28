return {
  {
    "olimorris/codecompanion.nvim",
    opts = {},
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("codecompanion").setup({
        adapters = {
          http = {
            copilot = function()
              return require("codecompanion.adapters").extend("copilot", {
                schema = {
                  model = {
                    default = "claude-sonnet-4",
                  }
                }
              })
            end,
          }
        },
        strategies = {
          chat = {
            adapter = "copilot",
            keymaps = {
              close = {
                modes = { n = "<Esc>", i = "<Esc>" },
                opts = {},
              },
            },
          },
          inline = {
            adapter = "copilot",
          },
        },
      })
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    enabled = false,
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
        copilot_node_command = "node",
      })
    end,
  },
}
