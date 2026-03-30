-- init.lua for neovim

-- options --------------------------------------------------------------------

vim.opt.modeline = true
vim.opt.showcmd = false
vim.opt.cursorcolumn = false
vim.opt.errorbells = false
vim.opt.cursorline = true
vim.opt.history = 1000
vim.opt.wildmenu = true
vim.opt.hidden = true
vim.opt.scrolloff = 2
vim.opt.sidescrolloff = 2
vim.opt.mouse = "a"
vim.opt.guicursor = ""
vim.opt.signcolumn = "yes"
vim.opt.clipboard = "unnamedplus"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.wrapscan = true
vim.opt.incsearch = true
vim.opt.textwidth = 80
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.linebreak = true
vim.opt.number = true
vim.opt.list = true
vim.opt.listchars = { tab = "› ", trail = "•", nbsp = "␣" }
vim.opt.fillchars = { fold = "·" }
vim.opt.backspace = "indent,eol,start"
vim.opt.foldenable = true
vim.opt.foldmethod = "marker"
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.laststatus = 3
-- Ideally I would like to hide the command line by setting it to 0 but there is
-- a bug with macro recordings.
vim.opt.cmdheight = 1

-- diagnostics ----------------------------------------------------------------

vim.diagnostic.config({
  virtual_text = false,
  virtual_lines = false,
})

-- mappings -------------------------------------------------------------------

vim.g.mapleader = " "

vim.keymap.set("i", "<C-c>", "<Esc>", { remap = false })
vim.keymap.set("n", "<C-x>", ":q<CR>", { remap = false })
vim.keymap.set("n", "<C-j>", "<C-w>w")
vim.keymap.set("n", "<C-k>", "<C-w>W")

vim.keymap.set("n", "<Right>", ":bn<CR>", { remap = false })
vim.keymap.set("n", "<Left>", ":bp<CR>", { remap = false })

vim.keymap.set("n", "gn", vim.diagnostic.goto_next)
vim.keymap.set("n", "gp", vim.diagnostic.goto_prev)

vim.keymap.set("n", "<Leader>d", ":bd<CR>", { remap = false })
vim.keymap.set("n", "<Leader>w", ":w!<CR>", { remap = false })
vim.keymap.set("n", "<Leader>fw", ":%s/\\s\\+$//<CR>", { remap = false })
vim.keymap.set("n", "<Leader>se", ":setlocal spell spelllang=en<CR>", { remap = false })
vim.keymap.set("n", "<Leader>sd", ":setlocal spell spelllang=de<CR>", { remap = false })
vim.keymap.set("n", "<Leader>sn", ":setlocal nospell<CR>", { remap = false })

-- autocmds -------------------------------------------------------------------

-- Auto-format using LSP
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.rs", "*.c", "*.cpp", "*.h", "*.py", "*.typ" },
  callback = function(ev)
    vim.lsp.buf.format()
  end
})

-- Set indentation to 2 for select file types
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "css,lua,tex" },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
  end
})

-- Enable inlay hints
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local id = vim.tbl_get(event, "data", "client_id")
    local client = id and vim.lsp.get_client_by_id(id)
    if client == nil or not client:supports_method("textDocument/inlayHint") then
      return
    end

    vim.lsp.inlay_hint.enable(true)
  end
})

-- filetypes ------------------------------------------------------------------

vim.filetype.add({
  filename = {
    ["Jenkinsfile"] = "groovy",
  },
  extension = {
    typst = "typst"
  },
})

-- lsp ------------------------------------------------------------------------

vim.lsp.enable({"clangd", "gopls", "ruff", "rust-analyzer", "tinymist", "ty"})

-- lazy plugins ---------------------------------------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    {
      "wtfox/jellybeans.nvim",
      lazy = false,
      priority = 1000,
      opts = {
        flat_ui = false,
        background = {
          dark = "jellybeans",
          light = "jellybeans_muted_light",
        },
      },
    },
    {
      "akinsho/bufferline.nvim",
      enabled = false,
      event = "BufRead",
      opts = {
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
      },
    },
    {
      "nvim-lualine/lualine.nvim",
      config = function()
        local separator = { left = "", right = "" }

        require("lualine").setup {
          options = {
            theme = "jellybeans-nvim",
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
                "lsp_status",
                symbols = {
                  done = '',
                },
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
      opts = {
        attach_to_untracked = false,
        on_attach = function(bufnr)
          opts = {}
          opts.buffer = bufnr
          vim.keymap.set("n", "<leader>gb", function() package.loaded.gitsigns.blame_line{full=true} end, opts)
        end
      },
    },
    {
      "nvim-tree/nvim-web-devicons",
      opts = {
        color_icons = false,
      },
    },
    {
      "mvllow/modes.nvim",
      event = "ModeChanged",
      opts = {
        set_cursor = false,
        line_opacity = 0.1,
      },
    },
    {
      "matze/vim-move",
      keys = {
        { "<A-j>", "<Plug>MoveBlockDown", mode = "v" },
        { "<A-k>", "<Plug>MoveBlockUp", mode = "v" },
        { "<A-j>", "<Plug>MoveLineDown", mode = "n" },
        { "<A-k>", "<Plug>MoveLineUp", mode = "n" },
      },
      init = function()
        vim.g.move_map_keys = false
      end,
    },
    {
      "matze/wastebin.nvim",
      event = "BufRead",
    },
    {
      "numToStr/Comment.nvim",
      event = "FileType",
    },
    {
      "rachartier/tiny-inline-diagnostic.nvim",
      event = "VeryLazy",
      priority = 1000,
      opts = {
        preset = "powerline",
      },
    },
    {
      "chrisgrieser/nvim-lsp-endhints",
      event = "LspAttach",
      opts = {
        icons = {
          type = "=> ",
          parameter = "<- ",
          offspec = " ", -- hint kind not defined in official LSP spec
          unknown = " ", -- hint kind is nil
        },
      }
    },
    {
      "folke/snacks.nvim",
      opts = {
        picker = {
          prompt = " ",
          ui_select = true,
          win = {
            input = {
              keys = {
                ["<Esc>"] = "close",
                ["<C-c>"] = { "close", mode = "i" },
              }
            },
          },
          sources = {
            gh_issue = {},
            gh_pr = {},
          },
        },
      },
      keys = {
        { "<C-p>", function() Snacks.picker.files({ hidden = true }) end, desc = "Find Files" },
        { "<C-g>", function() Snacks.picker.grep() end, desc = "Live grep" },
        { "<C-f>", function() Snacks.picker.grep_word() end, desc = "Grep word" },
        { "grd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
        { "grr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
        { "gri", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
        { "ge", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
      },
    },
    {
      "zk-org/zk-nvim",
      opts = {
        picker = "snacks_picker",
      },
      keys = {
        { "<Leader>zo", "<cmd>:ZkNotes<CR>", remap = false },
        { "<Leader>zt", "<cmd>:ZkTags<CR>", remap = false },
        { "<Leader>zl", "<cmd>:ZkInsertLink<CR>", mode = "n", remap = false },
        { "<Leader>zl", ":ZkInsertLinkAtSelection<CR>", mode = "v", remap = false },
        { "<Leader>zc", "<cmd>:ZkNew<CR>", remap = false },
        { "<Leader>zc", ":'<,'>ZkNewFromTitleSelection<CR>", mode = "v", remap = false },
      },
    },
    {
      "nvim-treesitter/nvim-treesitter",
      event = "BufRead",
      lazy = false,
      build = ":TSUpdate",
      opts = {
        ensure_installed = {
          "bash",
          "c",
          "cpp",
          "css",
          "html",
          "json",
          "lua",
          "markdown",
          "rust",
        },
        highlight = {
          enable = true
        },
      },
    },
  },
})

-- colorscheme ----------------------------------------------------------------

local function sync_colorscheme()
  local result = vim.fn.system("gsettings get org.gnome.desktop.interface color-scheme")
  if result:find("prefer%-light") or result:find("default") then
    -- set background directly so lualine is synced as well
    vim.o.background = "light"
    vim.cmd([[colorscheme jellybeans-muted-light]])
  else
    vim.o.background = "dark"
    vim.cmd([[colorscheme jellybeans]])
  end
end

sync_colorscheme()

-- Watch for GNOME theme changes
local handle = vim.uv.new_pipe()
local pid = vim.uv.spawn("gsettings", {
  args = { "monitor", "org.gnome.desktop.interface", "color-scheme" },
  stdio = { nil, handle, nil },
}, function() end)

if handle then
  handle:read_start(function(err, data)
    if data then
      vim.schedule(sync_colorscheme)
    end
  end)
end
