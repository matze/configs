return {
  "nvim-lualine/lualine.nvim",
  config = function()
    local colors = require("kanagawa.colors").setup()

    require("lualine").setup {
      options = {
        theme = "kanagawa",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = {
          {
            "mode",
            separator = { left = "", right = "◤" },
          },
        },
        lualine_b = {
          {
            "branch",
            separator = { left = "", right = "◤" },
            fmt = function(str)
              if #str >= 30 then
                return str:sub(1, 29) .. "…"
              else
                return str
              end
            end
          }
        },
        lualine_c = {
          {
            "filename",
            separator = { left = "◥", right = "" },
          },
        },
        lualine_x = {
          {
            "encoding",
            separator = { left = "◥", right = "" },
          },
        },
        lualine_y = {
          {
            "filetype",
            separator = { left = "◥", right = "" },
          },
          {
            "diff",
            symbols = { added = " ", modified = "柳", removed = " " }
          },
        },
        lualine_z = {
          {
            "location",
            separator = { left = "◥", right = "" },
          }
        },
      },
      tabline = {
        lualine_a = {
          {
            "buffers",
            separator = { left = "◢", right = "◣" },
            show_filename_only = true,
            buffers_color = {
              active = { gui = "bold", fg = colors.theme.ui.fg, bg = colors.theme.ui.bg },
              inactive = { fg = colors.palette.dragonBlack6, bg = colors.theme.ui.bg_dim },
            },
            symbols = {
              alternate_file = "",
              modified = " ·",
            },
            fmt = function(str, context)
              return str .. " "
            end,
          }
        }
      },
    }
  end,
}
