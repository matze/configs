return {
  {
    "matze/wastebin.nvim",
    event = "BufRead",
    config = function()
      require("wastebin").setup()
    end,
  }
}