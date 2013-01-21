" Matzes .vimrc
"

" --- general ---------------------------------------------------------------
"
set nocompatible    " vi-Kompatibilität ausschalten
set modeline
set showmatch       " Klammermatching anzeigen
set nocursorline
set nocursorcolumn
set ruler           " aktuelle Cursorposition
set laststatus=2    " Status immer anzeigen
set backspace=2     " alles im Insertmode löschen
set noerrorbells    " Klingeling ausschalten
set history=1000    " Commandline-History
set wildmenu        " Tab-completion im Menü
set wildignore+=*/.git/*,*/.bzr/*,*~,*/build/*
set hidden
set scrolloff=2     " Mindestens zwei Zeilen Kontext
set sidescrolloff=2 " Mindestens zwei Spalten Kontext
set mouse=a         " Mouse-Support im Terminal
set tags=tags
set ttyfast
let mapleader = ","


" --- textformatting, indenting, tabs ---------------------------------------
"
set autoindent
set si
set tabstop=4       " Anzahl Spaces pro <Tab>
set shiftwidth=4
set softtabstop=4
set expandtab       " Spaces statt Tabs
set smarttab        " Ich hoffe du schaffst das...
set linebreak       " Zeilen am Ende (visuelle) umbrechen
set number          " Zeilennummern anschalten
set listchars=tab:»\ ,trail:·,eol:¬
set tw=80

" --- folding ---------------------------------------------------------------
"
set nofoldenable
set foldmethod=indent
set fillchars=fold:\

" --- searching -------------------------------------------------------------
"
set ignorecase      " Case-insentive Suchen
set smartcase       " ignoriere ggf. ignorecase
set hlsearch
set wrapscan        " Suche oben fortsetzen
set sm
set incsearch       " Inkrementelle Suche von Teilergebnissen
set noedcompatible
set nogdefault      " g ist nicht Standard bei :s/foo/bar

" --- plugins ---------------------------------------------------------------
"
filetype off

set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'mileszs/ack.vim'
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/neosnippet'
Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-fugitive'
Bundle 'nvie/vim-flake8'
Bundle 'spolu/dwm.vim'
Bundle 'matze/latex-fold'
Bundle 'Lokaltog/vim-easymotion'

if has("python")
    Bundle 'Lokaltog/vim-powerline'
endif

filetype on
filetype plugin on
filetype indent on

" --- ack.vim
let g:ackprg="ack-grep -H --nocolor --nogroup --column"

" --- NeoComplCache
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

inoremap <expr><CR> neocomplcache#smart_close_popup() . "\<CR>"

nmap <Leader>nce :NeoComplCacheEnable<CR>
nmap <Leader>ncd :NeoComplCacheDisable<CR>

" --- powerline
let g:Powerline_symbols = 'fancy'

" --- ctrlp.vim
let g:ctrlp_extensions = ['buffertag']

" --- dwm.vim
let g:dwm_map_keys = 0
map <C-J> <C-W>w
map <C-K> <C-W>W
map <C-N> <Plug>DWMNew
map <C-X> <Plug>DWMClose
map <C-@> <Plug>DWMFocus
map <C-L> <Plug>DWMGrowMaster
map <C-H> <Plug>DWMShrinkMaster


" --- omni completion -------------------------------------------------------
"
set omnifunc=syntaxcomplete#Complete
set completeopt=menu


" --- highlighting, colors, fonts -------------------------------------------
"
syntax on
set t_Co=256
set background=dark

try
    colorscheme lilypink
catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme desert
endtry

if has("gui_running")
    set lines=60                " bißchen höher im GUI-Modus
    set columns=120             " und ein bißchen breiter
    set gfn=Monospace\ 9
    set guioptions-=m
    set guioptions-=T
    set guioptions-=l
    set guioptions-=L
    set guioptions-=r
    set guioptions-=R
    set guioptions-=b
endif


" --- key mappings ----------------------------------------------------------
nmap <F5> <Esc>:w!<CR>:make!<CR>
inoremap <F9> <C-O>za
nnoremap <F9> za

nmap <Leader>cw 1z=
nmap <silent> <Leader>h :silent noh<CR>

" " --- copy & paste
nnoremap <Leader>y "*yy
nnoremap <Leader>yy "*Y
nnoremap <Leader>p :set paste<CR>:put *<CR>:set nopaste<CR>

" " --- buffer and file management
nmap <Leader>w :w!<CR>
nmap <Leader>d :bd<CR>
nmap cn <Esc>:cn<CR>
nmap cp <Esc>:cp<CR>
nmap <Right> :bn<CR>
nmap <Left> :bp<CR>
nmap <Leader>cl :ccl<CR>

" " --- Tlist and ctags stuff
nmap <Leader>gt :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR>
nmap <C-o> <C-]>

" " --- basic formatting
nmap <Leader>r1 yypVr=
nmap <Leader>r2 yypVr-
nmap <Leader>fw :%s/\s\+$//<CR>

" " --- spellchecking
nmap <Leader>se :setlocal spell spelllang=en_us<CR>
nmap <Leader>sd :setlocal spell spelllang=de<CR>
nmap <Leader>sn :setlocal nospell<CR>

" --- Auto-Commands ---------------------------------------------------------
"
augroup text
    au!
    au BufNewFile,BufRead       *.rst               set tw=80
    au BufNewFile,BufRead       *.rst               so $VIMRUNTIME/syntax/rst.vim
    au BufNewFile,BufRead       *.tex               set tw=80
    au BufNewFile,BufRead       wscript             setf python
augroup END

" Prevent strange re-wrapping with gqap when 'if' is inside a paragraph
au BufEnter *.tex   set nosmartindent
au BufEnter *.py    set nosmartindent
au BufEnter *.bib   set sw=2 ts=2 softtabstop=2

function TryCmakeMakeprg()
    if !filereadable('Makefile')
        if filereadable('build/Makefile')
            set makeprg=make\ -C\ ./build\ --no-print-directory
        endif
    endif
endfunction

au BufEnter *.c     call TryCmakeMakeprg()
