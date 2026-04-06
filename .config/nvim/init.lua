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

-- enable highlighting for jjdescription
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'jjdescription',
  callback = function() vim.treesitter.start() end,
})

-- show floating window when recording a macro
local api = vim.api
local win_id = nil
local buf_id = nil

local config = {
  row = 2,
  col_offset = 4,
}

local function close_banner()
  if win_id and api.nvim_win_is_valid(win_id) then
    api.nvim_win_close(win_id, true)
  end

  if buf_id and api.nvim_buf_is_valid(buf_id) then
    api.nvim_buf_delete(buf_id, { force = true })
  end

  win_id = nil
  buf_id = nil
end

local function open_banner()
  local reg = vim.fn.reg_recording()

  if reg == '' then
    return
  end

  close_banner()

  local text = string.format(' ● REC @%s ', reg)

  buf_id = api.nvim_create_buf(false, true)
  api.nvim_buf_set_lines(buf_id, 0, -1, false, { text })

  local col = vim.o.columns - #text - config.col_offset

  win_id = api.nvim_open_win(buf_id, false, {
    relative = 'editor',
    width = #text,
    height = 1,
    row = config.row,
    col = col,
    style = 'minimal',
    border = 'none',
    focusable = false,
    zindex = 150,
  })

  api.nvim_set_option_value(
    'winhighlight',
    'Normal:DiagnosticError',
    { win = win_id }
  )
end

local group = api.nvim_create_augroup('MacroRecordingBanner', { clear = true })

api.nvim_create_autocmd(
  'RecordingEnter',
  { group = group, callback = open_banner }
)

api.nvim_create_autocmd('RecordingLeave', {
  group = group,
  callback = function()
    vim.defer_fn(close_banner, 50)
  end,
})

api.nvim_create_autocmd('VimResized', {
  group = group,
  callback = function()
    if win_id and api.nvim_win_is_valid(win_id) then
      open_banner()
    end
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
    ghost_text = { enabled = true },
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
