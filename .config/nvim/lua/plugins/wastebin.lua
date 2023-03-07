return {
  {
    "matze/wastebin.nvim",
    event = "BufRead",
    init = function()
      require("wastebin").setup()
    end,
  }
}
