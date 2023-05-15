return {
  "nvim-lualine/lualine.nvim",
  config = function()
    local colors = require("kanagawa.colors").setup()
    local separator = { left = "", right = "◤" }

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
            separator = separator,
          },
        },
        lualine_b = {
          {
            "branch",
            separator = separator,
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
            separator = separator,
          },
        },
        lualine_x = {
          {
            "encoding",
            separator = separator,
          },
        },
        lualine_y = {
          {
            "filetype",
            separator = separator,
          },
          {
            "diff",
            symbols = { added = " ", modified = " ", removed = " " }
          },
        },
        lualine_z = {
          {
            "location",
          }
        },
      },
      tabline = {
        lualine_a = {
          {
            "buffers",
            separator = separator,
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
