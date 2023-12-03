-- Edit related plugins. LSP and tree-sitter have broader scope and go into
-- their own plugin configurations.

return {
  {
    "matze/vim-move",
    keys = {
      { "<A-j>", "<Plug>MoveBlockDown", mode = "v" },
      { "<A-k>", "<Plug>MoveBlockUp", mode = "v" },
      { "<A-j>", "<Plug>MoveLineDown", mode = "n" },
      { "<A-k>", "<Plug>MoveLineUp", mode = "n" },
    },
    init = function()
      vim.g.move_map_keys = false
    end,
  },
  {
    "numToStr/Comment.nvim",
    event = "FileType",
    config = function()
      require("Comment").setup()
    end
  }
}
