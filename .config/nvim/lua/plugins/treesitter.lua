return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufRead",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "css",
        "html",
        "json",
        "lua",
        "markdown",
        "rust",
      },
      highlight = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  }
}
