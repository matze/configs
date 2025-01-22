return {
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false }, -- disable to avoid interference with blink-cmp-copilot
        panel = { enabled = false }, -- disable to avoid interference with blink-cmp-copilot
        copilot_node_command = "node",
      })
    end,
  },
  {
    "giuxtaposition/blink-cmp-copilot",
    dependencies = "zbirenbaum/copilot.lua",
  },
}
