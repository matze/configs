return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require('kanagawa').setup({
        theme = "dragon",
        undercurl = true,
        commentStyle = { italic = false },
        functionStyle = {},
        keywordStyle = {},
        statementStyle = {},
        typeStyle = {},
        variablebuiltinStyle = { italic = true },
        specialReturn = false,
        specialException = false,
        transparent = false,
        colors = {
          theme = {
            all = {
              ui = { bg_gutter = "none" }
            }
          }
        },
        overrides = function(colors)
          return {
            CursorLine = { bg = colors.palette.sumiInk2 },
          }
        end,
      })

      vim.cmd([[colorscheme kanagawa]])
    end,
  }
}
