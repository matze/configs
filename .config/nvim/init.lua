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
vim.opt.cmdheight = 0

-- diagnostics ----------------------------------------------------------------

vim.diagnostic.config({
  virtual_text = false,
  virtual_lines = false,
})

-- mappings -------------------------------------------------------------------

vim.g.mapleader = " "
vim.g.move_map_keys = false

vim.keymap.set("i", "<C-c>", "<Esc>", { remap = false })
vim.keymap.set("n", "<C-x>", ":q<CR>", { remap = false })
vim.keymap.set("n", "<C-j>", "<C-w>w")
vim.keymap.set("n", "<C-k>", "<C-w>W")
vim.keymap.set("n", "<C-p>", function() Snacks.picker.files({ hidden = true }) end)
vim.keymap.set("n", "<C-g>", function() Snacks.picker.grep() end)
vim.keymap.set("n", "<C-f>", function() Snacks.picker.grep_word() end)

vim.keymap.set("n", "<Right>", ":bn<CR>", { remap = false })
vim.keymap.set("n", "<Left>", ":bp<CR>", { remap = false })

vim.keymap.set("v", "<A-j>", "<Plug>MoveBlockDown", { remap = false })
vim.keymap.set("n", "<A-j>", "<Plug>MoveLineDown", { remap = false })
vim.keymap.set("v", "<A-k>", "<Plug>MoveBlockUp", { remap = false })
vim.keymap.set("n", "<A-k>", "<Plug>MoveLineUp", { remap = false })

vim.keymap.set("n", "K", function() vim.lsp.buf.hover({ border = "rounded" }) end)

vim.keymap.set("n", "gn", vim.diagnostic.goto_next)
vim.keymap.set("n", "gp", vim.diagnostic.goto_prev)
vim.keymap.set("n", "grd", function() Snacks.picker.lsp_definitions() end)
vim.keymap.set("n", "grr", function() Snacks.picker.lsp_references() end)
vim.keymap.set("n", "gri", function() Snacks.picker.lsp_implementations() end)
vim.keymap.set("n", "ge", function() Snacks.picker.diagnostics() end)

vim.keymap.set("n", "<Leader>d", ":bd<CR>", { remap = false })
vim.keymap.set("n", "<Leader>w", ":w!<CR>", { remap = false })
vim.keymap.set("n", "<Leader>fw", ":%s/\\s\\+$//<CR>", { remap = false })
vim.keymap.set("n", "<Leader>se", ":setlocal spell spelllang=en<CR>", { remap = false })
vim.keymap.set("n", "<Leader>sd", ":setlocal spell spelllang=de<CR>", { remap = false })
vim.keymap.set("n", "<Leader>sn", ":setlocal nospell<CR>", { remap = false })

vim.keymap.set("n", "<Leader>zo", '<cmd>:ZkNotes<CR>')
vim.keymap.set("n", "<Leader>zl", '<cmd>:ZkInsertLink<CR>')
vim.keymap.set("v", "<Leader>zl", '<cmd>:ZkInsertLinkAtSelection<CR>')
vim.keymap.set("n", "<Leader>zc", '<cmd>:ZkNew<CR>')
vim.keymap.set("v", "<Leader>zc", ":'<,'>ZkNewFromTitleSelection<CR>")

-- autocmds -------------------------------------------------------------------

-- auto-format using LSP
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.rs", "*.c", "*.cpp", "*.h", "*.py", "*.typ" },
  callback = function(ev)
    vim.lsp.buf.format()
  end
})

-- set indentation to 2 for select file types
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "css,lua,tex" },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
  end
})

-- enable inlay hints
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

-- update nvim-treesitter parsers
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind

    if name == 'nvim-treesitter' and kind == 'update' then
      if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
      vim.cmd('TSUpdate')
    end
  end
})

-- start tree-sitter highlighting for any filetype with an installed parser
vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local ok, parser = pcall(vim.treesitter.get_parser, args.buf)
    if ok and parser then
      vim.treesitter.start(args.buf, parser:lang())
    end
  end,
})

-- macro recording
local function macro_recording()
  local reg = vim.fn.reg_recording()
  if reg ~= '' then return '● REC @' .. reg end
  return ''
end

vim.api.nvim_create_autocmd('RecordingEnter', {
  callback = function()
    require('lualine').refresh()
  end,
})

vim.api.nvim_create_autocmd('RecordingLeave', {
  callback = function()
    vim.defer_fn(function() require('lualine').refresh() end, 50)
  end,
})

-- ui2 ------------------------------------------------------------------------

require('vim._core.ui2').enable({
  enable = true,
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

-- colorscheme ----------------------------------------------------------------

-- Set color scheme based on the system color scheme, i.e.
-- jellybeans-muted-light for light and jellybeans for dark mode. This is
-- defined here, so we can call it before configuring modes.nvim which takes
-- color values from the current colorscheme.
local function sync_colorscheme()
  local result = vim.fn.system("gsettings get org.gnome.desktop.interface color-scheme")
  if result:find("prefer%-light") or result:find("default") then
    vim.o.background = "light"
    vim.cmd([[colorscheme jellybeans-muted-light]])
  else
    vim.o.background = "dark"
    vim.cmd([[colorscheme jellybeans]])
  end
end

-- color scheme watcher
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

-- plugins --------------------------------------------------------------------

vim.pack.add({
  'https://github.com/chrisgrieser/nvim-lsp-endhints',
  'https://github.com/folke/snacks.nvim',
  'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/matze/wastebin.nvim',
  'https://github.com/matze/vim-move',
  'https://github.com/mvllow/modes.nvim',
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-lualine/lualine.nvim',
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/numToStr/Comment.nvim',
  'https://github.com/olimorris/codecompanion.nvim',
  'https://github.com/rachartier/tiny-inline-diagnostic.nvim',
  'https://github.com/rafikdraoui/jj-diffconflicts',
  'https://github.com/wtfox/jellybeans.nvim',
  'https://github.com/zk-org/zk-nvim',
  { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range('*') },
})

require('jellybeans').setup({
  flat_ui = false,
  background = {
    dark = 'jellybeans',
    light = 'jellybeans_muted_light',
  },
  on_highlights = function(hl, c)
    local menu_bg = c.grey_one
    hl.BlinkCmpMenu = { bg = menu_bg, fg = c.foreground }
    hl.BlinkCmpMenuBorder = { bg = menu_bg, fg = c.grey }
    hl.BlinkCmpDoc = { bg = menu_bg, fg = c.foreground }
    hl.BlinkCmpDocBorder = { bg = menu_bg, fg = c.grey }
    hl.BlinkCmpDocSeparator = { bg = menu_bg, fg = c.grey }
    hl.BlinkCmpSignatureHelp = { bg = menu_bg, fg = c.foreground }
    hl.BlinkCmpSignatureHelpBorder = { bg = menu_bg, fg = c.grey }
    hl.PmenuSbar = { bg = menu_bg }
    hl.PmenuThumb = { bg = c.grey_three }
    hl.MacroRecording = { bg = c.error, fg = c.background }
  end,
})

-- sync colors now so subsequent plugins can make use of them as well
sync_colorscheme()

local left_separator = { left = "", right = "" }
local right_separator = { left = "", right = "" }

local function ellipsize(str)
  if #str >= 30 then
    return str:sub(1, 29) .. "…"
  else
    return str
  end
end

require("lualine").setup({
  options = {
    theme = "jellybeans-nvim",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
  },
  sections = {
    lualine_a = {
      { "mode", separator = left_separator },
    },
    lualine_b = {
      { "branch", separator = left_separator, fmt = ellipsize }
    },
    lualine_c = {
      { "filename", separator = left_separator },
    },
    lualine_x = {
      { macro_recording, separator = right_separator, color = "MacroRecording" },
      { "lsp_status", separator = right_separator, symbols = { done = "" } },
    },
    lualine_y = {
      { "filetype", separator = right_separator },
      { "diff", symbols = { added = " ", modified = " ", removed = " " } },
    },
    lualine_z = {
      { "location", separator = right_separator }
    },
  },
  tabline = {
    lualine_a = {
      {
        "buffers",
        separator = left_separator,
        show_filename_only = true,
        symbols = {
          alternate_file = "",
          modified = " ·",
        },
      }
    }
  },
})

require('codecompanion').setup({
  interactions = {
    cli = {
      agent = "claude_code",
      agents = {
        claude_code = {
          cmd = "claude",
          args = {},
          description = "Claude Code CLI",
          provider = "terminal",
        },
      },
    },
  },
})

require('gitsigns').setup({
  on_attach = function(bufnr)
    opts = {}
    opts.buffer = bufnr
    vim.keymap.set('n', '<leader>gb', function() package.loaded.gitsigns.blame_line{ full = true } end, opts)
  end
})

require('lsp-endhints').setup({
  icons = {
    type = "=> ",
    parameter = "<- ",
    offspec = " ", -- hint kind not defined in official LSP spec
    unknown = " ", -- hint kind is nil
  },
})

require('modes').setup({
  set_cursor = false,
  line_opacity = 0.1,
})

require('nvim-treesitter').install({
  "bash", "c", "cpp", "css", "html", "jjdescription", "json", "lua", "markdown", "rust", "vim"
})

require('nvim-web-devicons').setup({
  color_icons = false,
})

require('snacks').setup({
  picker = {
    prompt = ' ',
    ui_select = true,
    win = {
      input = {
        keys = {
          ['<Esc>'] = 'close',
          ['<C-c>'] = { 'close', mode = 'i' },
        }
      },
    },
    sources = {
      gh_issue = {},
      gh_pr = {},
    },
  },
})

require('tiny-inline-diagnostic').setup({
  preset = 'powerline',
})

require('zk').setup({
  picker = "snacks_picker",
})

require('blink.cmp').setup({
  keymap = {
    preset = "default",
    ["<C-j>"] = { "accept" },
  },
  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = "mono",
  },
  completion = {
    documentation = {
      auto_show = true,
      window = {
        winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc,'
          .. '@markup.heading.1.markdown:BlinkCmpDoc,'
          .. '@markup.heading.2.markdown:BlinkCmpDoc,'
          .. '@markup.heading.3.markdown:BlinkCmpDoc,'
          .. '@markup.heading.4.markdown:BlinkCmpDoc',
      },
    },
  },
  sources = {
    default = { "buffer", "lsp", "path" },
  },
  signature = {
    enabled = true,
    window = {
      show_documentation = true,
    },
  },
})
