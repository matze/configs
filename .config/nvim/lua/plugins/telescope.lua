return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<C-p>",
        function()
          -- fall back to find_files in case we are not in a git repo
          vim.fn.system('git rev-parse --is-inside-work-tree')

          if vim.v.shell_error == 0 then
            require("telescope.builtin").git_files({})
          else
            require("telescope.builtin").find_files({})
          end
        end,
        remap = false
      },
      { "<C-f>", "<cmd>Telescope grep_string<CR>", remap = false },
      { "<C-g>", "<cmd>Telescope live_grep<CR>", remap = false },
      { "<C-b>", "<cmd>Telescope git_branches<CR>", remap = false },
      { "gd",    "<cmd>Telescope lsp_definitions<CR>", remap = false },
      { "gi",    "<cmd>Telescope lsp_implementations<CR>", remap = false },
      { "gr",    "<cmd>Telescope lsp_references<CR>", remap = false },
      { "ge",    "<cmd>Telescope diagnostics<CR>", remap = false },
    },
    config = function()
      require("telescope").setup({
        pickers = {
          find_files = {
            find_command = { "fd", "--type", "f", "--type", "l", "--exclude", ".git" },
          },
        }
      })
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
          require("telescope").load_extension("ui-select")
        end
      },
      {
        "natecraddock/telescope-zf-native.nvim",
        config = function()
          require("telescope").load_extension("zf-native")
        end
      },
    },
  },
}
