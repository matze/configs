return {
  {
    "numToStr/Comment.nvim",
    event = "FileType",
    config = function()
      require("Comment").setup()
    end
  }
}
