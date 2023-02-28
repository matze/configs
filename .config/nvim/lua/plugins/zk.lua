return {
  {
    "mickael-menu/zk-nvim",
    keys = {
      { "<C-n>", "<cmd>:ZkNotes<CR>", remap = false },
      { "<C-t>", "<cmd>:ZkTags<CR>", remap = false },
      { "<Leader>zc", "<cmd>:ZkNew<CR>", remap = false },
      { "<Leader>zn", ":'<,'>ZkNewFromTitleSelection<CR>", mode = "v", remap = false },
    },
    config = function()
      require("zk").setup({
        picker = "telescope",
      })
    end
  }
}
