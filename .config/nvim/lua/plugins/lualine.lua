return {
  "nvim-lualine/lualine.nvim",
  config = function()
    require("lualine").setup {
      options = {
        theme = "kanagawa",
      },
      sections = {
        lualine_a = {"mode"},
        lualine_b = {
          {
            "branch",
            fmt = function(str)
              if #str >= 30 then
                return str:sub(1, 29) .. "…"
              else
                return str
              end
            end
          }
        },
        lualine_c = {"filename"},
        lualine_x = {"encoding"},
        lualine_y = {
          "filetype",
          {
            "diff",
            symbols = { added = " ", modified = "柳", removed = " " }
          },
        },
        lualine_z = {"location"}
      },
    }
  end,
}
