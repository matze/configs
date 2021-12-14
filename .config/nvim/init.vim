"
"                    /\ \__
"   ___ ___      __  \ \ ,_\  ____      __
"  /' __` __`\  /'__`\ \ \ \/ /\_ ,`\  /'__`\
"  /\ \/\ \/\ \/\ \L\.\_\ \ \_\/_/  /_/\  __/
"  \ \_\ \_\ \_\ \__/.\_\\ \__\ /\____\ \____\
"   \/_/\/_/\/_/\/__/\/_/ \/__/ \/____/\/____/

"{{{ General settings
set nocompatible
set modeline
set noshowcmd
set nocursorline
set nocursorcolumn
set noerrorbells
set history=1000
set wildmenu
set wildignore+=*/.git/*,*~,*/build/*,*.pyc
set hidden
set scrolloff=2
set sidescrolloff=2
set mouse=a
set guicursor=
set ttimeoutlen=0
set dir=~/.vim
set clipboard=unnamedplus
set ignorecase
set smartcase
set hlsearch
set wrapscan
set incsearch
set textwidth=80
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab
set linebreak
set number
set list
set listchars=tab:›\ ,trail:•,nbsp:␣
set fillchars=fold:·
set backspace=indent,eol,start
set signcolumn=yes
set t_Co=256
set foldenable
set foldmethod=marker
set completeopt=menu,menuone,noselect
set shortmess+=c
"}}}
"{{{ Plugins
call plug#begin('~/.local/share/nvim/plugged')

Plug 'akinsho/nvim-bufferline.lua'
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'editorconfig/editorconfig-vim'
Plug 'ggandor/lightspeed.nvim', { 'branch': 'main' }
Plug 'hrsh7th/cmp-cmdline', { 'branch': 'main' }
Plug 'hrsh7th/cmp-buffer', { 'branch': 'main' }
Plug 'hrsh7th/cmp-nvim-lsp', { 'branch': 'main' }
Plug 'hrsh7th/cmp-path', { 'branch': 'main' }
Plug 'hrsh7th/nvim-cmp', { 'branch': 'main' }
Plug 'L3MON4D3/LuaSnip'
Plug 'lewis6991/gitsigns.nvim', { 'branch': 'main' }
Plug 'matze/vim-ini-fold', { 'for': 'ini' }
Plug 'matze/vim-lilypond', { 'for': 'lilypond' }
Plug 'matze/vim-move'
Plug 'matze/vim-tex-fold', { 'for': 'tex' }
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'branch': 'main', 'do': 'make' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'petRUShka/vim-opencl', { 'for': 'opencl' }
Plug 'ray-x/lsp_signature.nvim'
Plug 'rose-pine/neovim', { 'branch': 'main' }
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'simrat39/rust-tools.nvim'
Plug 'tpope/vim-commentary'

call plug#end()

"{{{ nvim-bufferline.lua
lua <<EOF
require('bufferline').setup {
  options = {
    always_show_bufferline = false,
    show_buffer_close_icons = false,
    modified_icon = '·',
  },
  highlights = {
    buffer_selected = {
      gui = "bold",
    }
  },
}
EOF
"}}}
"{{{ editorconfig-vim
let g:EditorConfig_disable_rules = ['trim_trailing_whitespace']
"}}}
"{{{ lsp_signature.nvim
lua <<EOF
require('lsp_signature').setup()
EOF
"}}}
"{{{ lualine.nvim
lua <<EOF
require('lualine').setup {
  options = {
    theme = 'rose-pine',
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'filetype'},
    lualine_y = {'diff'},
    lualine_z = {'location'}
  },
}
EOF
"}}}
"{{{ gitsigns.nvim
lua <<EOF
require('gitsigns').setup {
  attach_to_untracked = false,
}
EOF
"}}}
"{{{ nvim-cmp
lua <<EOF
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
  }),
  mapping = {
    ["<C-j>"] = cmp.mapping.confirm({ select = true }),
  },
})

cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

require('lspconfig')['rust_analyzer'].setup {
  capabilities = capabilities
}
EOF
"}}}
"{{{ nvim-lspconfig
lua <<EOF
local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
  local opts = { noremap=true, silent=true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K' , '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
end

nvim_lsp.clangd.setup({ on_attach = on_attach })
nvim_lsp.pylsp.setup({ on_attach = on_attach })

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)
EOF
"}}}
"{{{ nvim-treesitter
lua <<EOF
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
  },
}

-- Coremake treesitter parser
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.coremake = {
  install_info = {
    url = "https://github.com/matze/tree-sitter-coremake",
    files = {"src/parser.c"}
  },
  filetype = "coremake"
}
EOF
"}}}
"{{{ rose-pine
sign define LspDiagnosticsSignError text=▶ texthl=Error

lua <<EOF
vim.g.rose_pine_variant = 'base'
vim.g.rose_pine_disable_italics = true
vim.g.rose_pine_colors = { punctuation = '#bd8091' }
EOF
"}}}
"{{{ rust-tools
lua <<EOF
require('rust-tools').setup {
  tools = {
    inlay_hints = {
      show_parameter_hints = false,
      other_hints_prefix = "→ ",
      },
    },
  }
EOF
"}}}
"{{{ telescope
lua <<EOF
require('telescope').load_extension('fzf')
EOF
"}}}
"{{{ vim-commentary
autocmd FileType cmake setlocal commentstring=#\ %s
autocmd FileType meson setlocal commentstring=#\ %s
autocmd FileType dosini setlocal commentstring=#\ %s
autocmd FileType cpp setlocal commentstring=//\ %s
autocmd FileType cinemoproj setlocal commentstring=//\ %s
"}}}
"{{{ vim-move
let g:move_map_keys = 0

vmap <A-j> <Plug>MoveBlockDown
vmap <A-k> <Plug>MoveBlockUp
nmap <A-j> <Plug>MoveLineDown
nmap <A-k> <Plug>MoveLineUp
"}}}
"{{{ vim-tex-fold
let g:tex_fold_additional_envs = ['tikzpicture']
"}}}

silent! colorscheme rose-pine
silent! set background=dark

syntax enable

"}}}
"{{{ Functions
" Adapted from github.com/jkramer/vim-checkbox
fu! ToggleCheckbox()
  let line = getline('.')

  if match(line, '- \[ \]') != -1
    call setline('.', substitute(line, '- \[ \]', '- \[x\]', ''))
  elseif match(line, '- \[x\]') != -1
    call setline('.', substitute(line, '- \[x\]', '- \[ \]', ''))
  elseif match(line, '- ') != -1
    call setline('.', substitute(line, '- ', '- \[ \] ', ''))
  endif
endf
"}}}
"{{{ Keymaps
let mapleader = "\<Space>"

inoremap <C-c> <Esc>
nnoremap <C-p> <cmd>Telescope find_files<CR>
nnoremap <C-b> <cmd>Telescope buffers<CR>
nnoremap <C-f> <cmd>Telescope grep_string<CR>
nnoremap <C-g> <cmd>Telescope live_grep<CR>

nnoremap gd <cmd>Telescope lsp_definitions<CR>
nnoremap gi <cmd>Telescope lsp_implementations<CR>
nnoremap ga <cmd>Telescope lsp_code_actions<CR>
nnoremap gr <cmd>Telescope lsp_references<CR>
nnoremap ge <cmd>Telescope diagnostics<CR>

imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<CR>

snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<CR>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<CR>

" paste multiple lines without overwriting content
vnoremap <silent> p p`]
nnoremap <silent> p p`]

nnoremap <CR> za

" select pasted text
noremap gV `[v`]

nnoremap <Right> :bn<CR>
nnoremap <Left> :bp<CR>

nnoremap cn <Esc>:cn<CR>
nnoremap cp <Esc>:cp<CR>

nnoremap <Leader>w :w!<CR>

nmap <Leader>r1 yypVr=
nmap <Leader>r2 yypVr-
nmap <Leader>fw :%s/\s\+$//<CR>

nmap <Leader>se :setlocal spell spelllang=en<CR>
nmap <Leader>sd :setlocal spell spelllang=de<CR>
nmap <Leader>sn :setlocal nospell<CR>
nmap <Leader>ss 1z=

vmap <Leader>y "+y
vmap <Leader>d "+d
vmap <Leader>p "+p
vmap <Leader>P "+P
nmap <Leader>p "+p
nmap <Leader>P "+P

" Splits
nmap <C-J> <C-W>w
nmap <C-K> <C-W>W
nmap <C-X> :q<CR>
"}}}
"{{{ Autocmds
" Allow using <CR> on quickfix entries
autocmd FileType markdown nnoremap <Leader>cm :call ToggleCheckbox()<CR>
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
" }}}
