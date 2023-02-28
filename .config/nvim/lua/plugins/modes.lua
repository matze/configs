return {
  {
    "mvllow/modes.nvim",
    event = "ModeChanged",
    config = function()
      require('modes').setup({
        set_cursor = false,
        line_opacity = 0.1,
      })
    end
  },
}
