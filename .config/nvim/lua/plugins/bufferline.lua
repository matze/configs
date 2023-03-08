return {
  {
    "akinsho/bufferline.nvim",
    event = "BufRead",
    config = function()
      require("bufferline").setup {
        options = {
          always_show_bufferline = false,
          show_buffer_close_icons = false,
          modified_icon = '·',
          diagnostics = "nvim_lsp",
          separator_style = "padded_slant",
        },
        highlights = {
          buffer_selected = {
            bold = true,
            italic = false,
          }
        },
      }
    end,
  }
}
