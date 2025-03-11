-- User interface related plugins affecting the "chrome", i.e. buffer and status
-- line, color scheme etc.

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
  },
  {
    "akinsho/bufferline.nvim",
    enabled = false,
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
  },
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      local colors = require("kanagawa.colors").setup()
      local separator = { left = "", right = "" }

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
  },
  { "avm99963/vim-jjdescription" },
  { "rafikdraoui/jj-diffconflicts" },
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
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup({
        color_icons = false,
      })
    end
  },
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
