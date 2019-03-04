"
"                    /\ \__
"   ___ ___      __  \ \ ,_\  ____      __
"  /' __` __`\  /'__`\ \ \ \/ /\_ ,`\  /'__`\
"  /\ \/\ \/\ \/\ \L\.\_\ \ \_\/_/  /_/\  __/
"  \ \_\ \_\ \_\ \__/.\_\\ \__\ /\____\ \____\
"   \/_/\/_/\/_/\/__/\/_/ \/__/ \/____/\/____/

"{{{ Settings

" General
" set showmatch       " Show matching parentheses
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
set ttyfast
set ttimeoutlen=0   " Timeout for keycodes, esp. <Esc>
set dir=~/.vim      " Location for .swp files
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
set listchars=tab:›\ ,trail:•
set list
set fillchars=fold:·
set backspace=indent,eol,start

" Highlighting, colors, fonts
set t_Co=256
syntax enable

if has("gui_running")
    set lines=60                " More lines ...
    set columns=120             " and columns in GUI mode
    set gfn=Monospace\ 9
    set guioptions-=m
    set guioptions-=T
    set guioptions-=l
    set guioptions-=L
    set guioptions-=r
    set guioptions-=R
    set guioptions-=b
endif

" Folding
set foldenable
set foldmethod=marker

" Omni completion
set omnifunc=syntaxcomplete#Complete
set completeopt=menu

" Makeprg
set makeprg=wrapped-make
"}}}
"{{{ Plugins

call plug#begin('~/.local/share/nvim/plugged')

Plug 'cespare/vim-toml'", { 'for': 'toml' } {{{
"}}}
Plug 'editorconfig/editorconfig-vim' "{{{
let g:EditorConfig_disable_rules = ['trim_trailing_whitespace']
"}}}
Plug 'itchyny/lightline.vim' "{{{

let g:lightline = {
    \ 'colorscheme': 'jellybeans',
    \ 'component': {
    \   'readonly': '%{&readonly?"✖":""}',
    \ },
    \ 'active': {
    \   'right': [['lineinfo'], ['percent']],
    \ },
    \ }

"}}}
Plug 'morhetz/gruvbox' "{{{
"}}}
Plug 'justinmk/vim-sneak' "{{{

let g:sneak#streak = 1

hi link SneakPluginTarget Type
hi link SneakPluginScope Function
hi link SneakStreakTarget Type
hi link SneakStreakMask Function

nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
omap f <Plug>Sneak_f
omap F <Plug>Sneak_F

"}}}
Plug 'junegunn/fzf' "{{{
"}}}
Plug 'junegunn/fzf.vim' "{{{
nnoremap <C-p> :Files<CR>
nnoremap <C-b> :Tags<CR>
nnoremap <C-f> :Rg <C-r><C-w><CR>

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
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
Plug 'neoclide/coc.nvim'"{{{
nmap <Leader>f <Plug>(coc-definition)
nmap <Leader>c <Plug>(coc-declaration)
nmap <Leader>i <Plug>(coc-implementation)
"}}}
Plug 'nvie/vim-flake8'", { 'for': 'python' } {{{
"}}}
Plug 'petRUShka/vim-opencl'", { 'for': 'opencl' } {{{
"}}}
Plug 'posva/vim-vue'", { 'for': 'vue' } {{{
"}}}
Plug 'spolu/dwm.vim'"{{{
let g:dwm_map_keys = 0

nmap <C-J> <C-W>w
nmap <C-K> <C-W>W
nmap <C-N> <Plug>DWMNew
nmap <C-X> <Plug>DWMClose
nmap <C-L> <Plug>DWMGrowMaster
nmap <C-H> <Plug>DWMShrinkMaster
nmap <C-E> <Plug>DWMFocus
"}}}
Plug 'tpope/vim-commentary'"{{{
autocmd FileType cmake setlocal commentstring=#\ %s
autocmd FileType meson setlocal commentstring=#\ %s
autocmd FileType cpp setlocal commentstring=//\ %s
autocmd FileType cinemoproj setlocal commentstring=//\ %s
"}}}
Plug 'tpope/vim-dispatch'"{{{
"}}}
Plug 'wting/rust.vim'", { 'for': 'rust' } {{{
"}}}

let g:ftplugin_sql_omni_key = '<C-j>'

call plug#end()

silent! colorscheme gruvbox
silent! set background=dark

highlight clear SignColumn

"}}}
"{{{ Functions
function! DefaultFoldText()
    let foldline = getline(v:foldstart)
    let line = substitute(foldline, '[^{]{{' . '{', '\1', '') . ' '
    return '+-' . v:folddashes . line
endfunction

function! TagJumpBack()
    try | foldclose! | catch | | endtry
    pop
endfunction

function! TagJumpForward()
    execute "tag " . expand("<cword>")
    try | foldopen! | catch | | endtry
endfunction

set foldtext=DefaultFoldText()
"}}}
"{{{ Keymaps

" paste multiple lines without overwriting content
vnoremap <silent> p p`]
nnoremap <silent> p p`]

nnoremap <CR> za

nnoremap <silent> <C-i> :call TagJumpForward()<CR>
nnoremap <silent> <C-t> :call TagJumpBack()<CR>

" for some reason this is mapped to :call TagJumpForward
nnoremap <tab> <nop>

" select pasted text
noremap gV `[v`]

nnoremap <F5> <Esc>:w!<CR>:make!<CR><CR>
nnoremap <F6> <Esc>:w!<CR>:Make<CR><CR>

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
nmap <Leader>d :bd<CR>

vmap <Leader>y "+y
vmap <Leader>d "+d
vmap <Leader>p "+p
vmap <Leader>P "+P
nmap <Leader>p "+p
nmap <Leader>P "+P

" Tabs
nmap o :tabnew<CR>
nmap n :tabnext<CR>
nmap p :tabprevious<CR>

" clang-format
map <C-i> :py3f ~/.local/bin/clang-format.py<cr>
"}}}
"{{{ Autocmds
" Allow using <CR> on quickfix entries
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>

" Show quickfix after :make, taken from
" http://vim.wikia.com/wiki/Automatically_open_the_quickfix_window_on_:make
autocmd QuickFixCmdPost [^l]*   nested  cwindow
autocmd QuickFixCmdPost l*      nested  lwindow

" Reset fold background to reduce distraction
autocmd VimEnter * hi Folded ctermbg=None
" }}}
