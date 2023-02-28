return {
  {
    "matze/vim-move",
    init = function()
      vim.g.move_map_keys = false
    end,
    keys = {
      { "<A-j>", "<Plug>MoveBlockDown", mode = "v" },
      { "<A-k>", "<Plug>MoveBlockUp", mode = "v" },
      { "<A-j>", "<Plug>MoveLineDown", mode = "n" },
      { "<A-k>", "<Plug>MoveLineUp", mode = "n" },
    },
  }
}
