return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        prompt = " ",
        ui_select = true,
        win = {
          input = {
            keys = {
              ["<Esc>"] = "close",
              ["<C-c>"] = { "close", mode = "i" },
            }
          },
        },
      },
    },
    keys = {
      { "<C-p>", function() Snacks.picker.files() end, desc = "Find Files" },
      { "<C-g>", function() Snacks.picker.grep() end, desc = "Live grep" },
      { "<C-f>", function() Snacks.picker.grep_word() end, desc = "Grep word" },
      { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
      { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
      { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
      { "ge", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
    },
    dependencies = {
      {
        "pkazmier/zk-nvim",
        branch = "snacks-picker",
        config = function()
          require("zk").setup({
            picker = "snacks_picker",
          })
        end
      }
    },
  }
}
