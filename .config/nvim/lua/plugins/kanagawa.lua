return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      local colors = require('kanagawa.colors').setup()

      require('kanagawa').setup({
        undercurl = true,
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = {},
        statementStyle = {},
        typeStyle = {},
        variablebuiltinStyle = { italic = true },
        specialReturn = false,
        specialException = false,
        transparent = false,
        colors = {},
        overrides = {
          CursorLine = { bg = colors.bg_light0 },
        },
      })

      vim.cmd([[colorscheme kanagawa]])
    end,
  }
}
