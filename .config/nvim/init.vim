"
"                    /\ \__
"   ___ ___      __  \ \ ,_\  ____      __
"  /' __` __`\  /'__`\ \ \ \/ /\_ ,`\  /'__`\
"  /\ \/\ \/\ \/\ \L\.\_\ \ \_\/_/  /_/\  __/
"  \ \_\ \_\ \_\ \__/.\_\\ \__\ /\____\ \____\
"   \/_/\/_/\/_/\/__/\/_/ \/__/ \/____/\/____/

"{{{ Settings

" General
set nocompatible    " Disable vi compatibility
set modeline        " Enable modeline
set noshowcmd
set nocursorline    " Do not highlight cursor line
set nocursorcolumn  " Do not highlight current cursor column
set ruler           " Show cursor position
set laststatus=2    " Show status line
set noerrorbells    " No beeps
set history=1000    " Maximum history
set wildmenu        " Tab completion
set wildignore+=*/.git/*,*/.bzr/*,*~,*/build/*,*.pyc
set hidden          " Allow buffers to be hidden
set scrolloff=2     " At least two lines and ...
set sidescrolloff=2 " two columns context
set mouse=a         " Mouse support
set guicursor=      " Disable cursor change in neovim
set ttimeoutlen=0   " Timeout for keycodes, esp. <Esc>
set dir=~/.vim      " Location for .swp files
set clipboard=unnamedplus
let mapleader = "\<Space>"

" Searching
set ignorecase      " Case insensitive search
set smartcase       " Ignore ignorecase
set hlsearch        " Show search results
set wrapscan        " Continue search at the top
set incsearch       " Incremental search

" Textformatting, indenting, tabs
set textwidth=80    " Yay, history!
set autoindent      " ...
set smartindent     " ...
set tabstop=4       " Number of spaces per tab
set shiftwidth=4    " Default number of spaces for >> and <<
set softtabstop=4   " Number of spaces per tab
set expandtab       " Spaces instead of tabs
set smarttab        " Add/remove spaces instead of tabs
set linebreak       " Break lines nicer
set number          " Show line numbers
set listchars=tab:›\ ,trail:•,nbsp:␣
set list
set fillchars=fold:·
set backspace=indent,eol,start
set signcolumn=yes

" Highlighting, colors, fonts
set t_Co=256
syntax enable

" Folding
set foldenable
set foldmethod=marker

" Completion
set completeopt=menuone,noselect
set shortmess+=c
"}}}
"{{{ Plugins

call plug#begin('~/.local/share/nvim/plugged')

Plug 'cespare/vim-toml'", { 'for': 'toml' } {{{
"}}}
Plug 'editorconfig/editorconfig-vim' "{{{
let g:EditorConfig_disable_rules = ['trim_trailing_whitespace']
"}}}
Plug 'gruvbox-community/gruvbox' "{{{
let g:gruvbox_contrast_dark = "hard"
"}}}
Plug 'hoob3rt/lualine.nvim' "{{{
"}}}
Plug 'nvim-lua/popup.nvim' "{{{
"}}}
Plug 'nvim-lua/plenary.nvim' "{{{
"}}}
Plug 'nvim-telescope/telescope.nvim' "{{{
"}}}
Plug 'Konfekt/FastFold'"{{{
"}}}
Plug 'nathangrigg/vim-beancount'", { 'for': 'beancount' } {{{
autocmd BufReadPost,BufNewFile *.beancount :set sw=2 
" }}}
Plug 'matze/vim-lilypond'", { 'for': 'lilypond' }  {{{
"}}}
Plug 'matze/vim-markdown'", { 'for': 'markdown' } {{{
let g:markdown_fold_override_foldtext = 0
"}}}
Plug 'matze/vim-meson'"{{{
"}}}
Plug 'matze/vim-move'"{{{
let g:move_map_keys = 0

vmap <A-j> <Plug>MoveBlockDown
vmap <A-k> <Plug>MoveBlockUp
nmap <A-j> <Plug>MoveLineDown
nmap <A-k> <Plug>MoveLineUp
"}}}
Plug 'matze/vim-tex-fold'", { 'for': 'tex' } {{{
let g:tex_fold_additional_envs = ['tikzpicture']
"}}}
Plug 'matze/vim-ini-fold'", { 'for': 'ini' } {{{
"}}}
Plug 'neovim/nvim-lspconfig'" {{{
"}}}
Plug 'nvim-treesitter/nvim-treesitter'", {'do': ':TSUpdate'} {{{
"}}}
Plug 'nvim-lua/lsp_extensions.nvim'" {{{
"}}}
Plug 'hrsh7th/nvim-compe'" {{{
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
"}}}
Plug 'petRUShka/vim-opencl'", { 'for': 'opencl' } {{{
"}}}
Plug 'posva/vim-vue'", { 'for': 'vue' } {{{
"}}}
Plug 'tpope/vim-commentary'"{{{
autocmd FileType cmake setlocal commentstring=#\ %s
autocmd FileType meson setlocal commentstring=#\ %s
autocmd FileType cpp setlocal commentstring=//\ %s
autocmd FileType cinemoproj setlocal commentstring=//\ %s
"}}}
Plug 'rust-lang/rust.vim'", { 'for': 'rust' } {{{
"}}}

call plug#end()

lua <<EOF
require'lualine'.setup {
  options = {
    theme = 'gruvbox',
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

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
}

-- nvim_lsp object
local nvim_lsp = require'lspconfig'

local on_attach = function(client, bufnr)
  local opts = { noremap=true, silent=true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K' , '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
end

nvim_lsp.ccls.setup({ on_attach = on_attach })
nvim_lsp.pylsp.setup({ on_attach = on_attach })
nvim_lsp.rust_analyzer.setup({ on_attach = on_attach })

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)
EOF

silent! colorscheme gruvbox
silent! set background=dark

highlight clear SignColumn

"}}}
"{{{ Keymaps
nnoremap <C-p> <cmd>Telescope find_files<CR>
nnoremap <C-b> <cmd>Telescope buffers<CR>
nnoremap <C-f> <cmd>Telescope grep_string<CR>

nnoremap gd <cmd>Telescope lsp_definitions<CR>
nnoremap gi <cmd>Telescope lsp_implementations<CR>
nnoremap ga <cmd>Telescope lsp_code_actions<CR>

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
nnoremap <Leader>h :silent noh<CR>

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
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>

" Reset fold background to reduce distraction
autocmd VimEnter * hi Folded ctermbg=None

autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *
\ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }
" }}}
