return {
  {
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    config = function()
      require("gitsigns").setup({
        attach_to_untracked = false,
        on_attach = function(bufnr)
          opts = {}
          opts.buffer = bufnr
          vim.keymap.set("n", "<leader>gb", function() package.loaded.gitsigns.blame_line{full=true} end, opts)
        end
      })
    end
  },
}
