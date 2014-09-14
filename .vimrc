"
"                    /\ \__
"   ___ ___      __  \ \ ,_\  ____      __
"  /' __` __`\  /'__`\ \ \ \/ /\_ ,`\  /'__`\
"  /\ \/\ \/\ \/\ \L\.\_\ \ \_\/_/  /_/\  __/
"  \ \_\ \_\ \_\ \__/.\_\\ \__\ /\____\ \____\
"   \/_/\/_/\/_/\/__/\/_/ \/__/ \/____/\/____/
"
" Author: matthias.vogelgesang[at]gmail[dot]com
" Blog: http://bloerg.net
"

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
set tags=.tags      " Tags file
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
set listchars=tab:»\ ,trail:·,eol:¬
set fillchars=fold:·

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
"}}}
"{{{ Plugins
call plug#begin('~/.vim/plugged')

Plug 'itchyny/lightline.vim'
Plug 'justinmk/vim-sneak'
Plug 'junegunn/goyo.vim'
Plug 'kien/ctrlp.vim'
Plug 'ledger/vim-ledger'
Plug 'matze/vim-markdown'
Plug 'matze/vim-move'
Plug 'matze/vim-tex-fold'
Plug 'matze/vim-ini-fold'
Plug 'mileszs/ack.vim'
" Plug 'nelstrom/vim-markdown-folding'
Plug 'nanotech/jellybeans.vim'
Plug 'nvie/vim-flake8'
Plug 'petRUShka/vim-opencl'
Plug 'reedes/vim-wordy'
Plug 'Shougo/neocomplcache'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'spolu/dwm.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-vinegar'
Plug 'zah/nimrod.vim'

call plug#end()

"{{{ ack.vim
let g:ackprg="ag --nogroup --nocolor --column"
"}}}
"{{{ NeoComplCache
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_auto_select = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_auto_completion_start_length = 3
let g:neocomplcache_manual_completion_start_length = 3
let g:neocomplcache_min_syntax_length = 3

if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

function! s:my_cr_function()
    return neocomplcache#smart_close_popup() . "\<CR>"
endfunction

inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>

imap <C-e>     <Plug>(neosnippet_expand_or_jump)
smap <C-e>     <Plug>(neosnippet_expand_or_jump)

nmap <Leader>nce :NeoComplCacheEnable<CR>
nmap <Leader>ncd :NeoComplCacheDisable<CR>
"}}}
"{{{ NeoSnippets
let g:neosnippet#snippets_directory='~/.vim/snippets'
"}}}
"{{{ ctrlp.vim
let g:ctrlp_extensions = ['tag']

let g:ctrlp_user_command = {
    \ 'types': {
    \   1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
    \   2: ['.hg', 'hg --cwd %s locate -I .'],
    \ },
    \ 'fallback': 'ag %s -l --nocolor -g ""'
    \ }
"}}}
"{{{ dwm.vim
let g:dwm_map_keys = 0

nmap <C-J> <C-W>w
nmap <C-K> <C-W>W
nmap <C-N> <Plug>DWMNew
nmap <C-X> <Plug>DWMClose
nmap <C-L> <Plug>DWMGrowMaster
nmap <C-H> <Plug>DWMShrinkMaster
nmap <C-E> <Plug>DWMFocus
"}}}
"{{{ sneak
let g:sneak#streak = 1
"}}}
"{{{ jellybeans.vim
silent! colorscheme jellybeans
"}}}
"{{{ lightline
let g:lightline = {
    \ 'component': {
    \   'readonly': '%{&readonly?"✖":""}',
    \ },
    \ 'active': {
    \   'right': [['lineinfo'], ['percent']],
    \ },
    \ }
"}}}
"{{{ vim-move
let g:move_map_keys = 0

vmap j <Plug>MoveBlockDown
vmap k <Plug>MoveBlockUp
nmap j <Plug>MoveLineDown
nmap k <Plug>MoveLineUp
"}}}
"{{{ vim-markdown-folding
let g:markdown_fold_override_foldtext = 0
"}}}
"{{{ vim-tex-fold
let g:tex_fold_additional_envs = ['tikzpicture']
"}}}
"}}}
"{{{ Functions
function NicerFoldText()
    " Match everything that has the Vim marker after some character (presumably
    " the comment starter.
    let foldline = getline(v:foldstart)
    let line = substitute(foldline, '^[^{]*{' . '{{\d*\([.]*\)', '\1', '') . ' '
    return '+-' . v:folddashes . line
endfunction

function TagJumpBack()
    try | foldclose! | catch | | endtry
    pop
endfunction

function TagJumpForward()
    execute "tag " . expand("<cword>")
    try | foldopen! | catch | | endtry
endfunction

set foldtext=NicerFoldText()
"}}}
"{{{ Keymaps

" paste multiple lines without overwriting content
vnoremap <silent> p p`]
nnoremap <silent> p p`]

nnoremap <CR> za

nnoremap <silent> <C-i> :call TagJumpForward()<CR>
nnoremap <silent> <C-t> :call TagJumpBack()<CR>

" select pasted text
noremap gV `[v`]

nnoremap <F5> <Esc>:w!<CR>:make!<CR><CR>
nnoremap <F6> <Esc>:w!<CR>:Make<CR><CR>

nnoremap <Right> :bn<CR>
nnoremap <Left> :bp<CR>

nnoremap <C-f> :Ack! <C-r><C-w><CR><CR>
nnoremap <C-b> :CtrlPTag<CR>

nnoremap cn <Esc>:cn<CR>
nnoremap cp <Esc>:cp<CR>

nnoremap <Leader>w :w!<CR>
nnoremap <Leader>h :silent noh<CR>

nmap <Leader>gt :!git ls-tree -r --name-only $(git rev-parse --abbrev-ref HEAD) <bar> ctags -f .tags --sort=yes -L - <CR><CR>

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
"}}}
