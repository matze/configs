return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufRead",
    build = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "css",
        "html",
        "json",
        "markdown",
        "rust",
      },
      highlight = { enable = true },
    },
  }
}
