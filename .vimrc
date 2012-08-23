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
set wildignore+=*/.git/*,*/.bzr/*,*~
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

Bundle 'mileszs/ack.vim',
Bundle 'Raimondi/delimitMate',
Bundle 'Shougo/neocomplcache',
Bundle 'Shougo/neocomplcache-snippets-complete',
Bundle 'Lokaltog/vim-powerline',
Bundle 'kien/ctrlp.vim',
Bundle 'tpope/vim-commentary',
Bundle 'tpope/vim-markdown',
Bundle 'tpope/vim-fugitive',
Bundle 'nvie/vim-flake8',
Bundle 'matze/dwm.vim'

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

inoremap  <expr><tab> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<tab>" : "\<C-x>\<C-u>\<C-p>\<Down>"
function! s:check_back_space()"{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

inoremap <expr><c-e> neocomplcache#complete_common_string()

imap <C-K> <Plug>(neocomplcache_snippets_expand)
smap <C-K> <Plug>(neocomplcache_snippets_expand)

nmap <Leader>nce :NeoComplCacheEnable<CR>
nmap <Leader>ncd :NeoComplCacheDisable<CR>

" --- notes.vim
let g:notes_directory = '~/notes'
let g:notes_suffix = '.note'

" --- powerline
let g:Powerline_symbols = 'fancy'

" --- ctrlp.vim
let g:ctrlp_extensions = ['buffertag']
nmap <Leader>pp :CtrlPBufTag<CR>

" --- dwm.vim
let g:dwm_map_keys = 0
map <C-N> :call DWM_New()<CR>
map <C-X> :call DWM_Close()<CR>
map <C-H> :call DWM_Focus()<CR>
map <C-J> <C-W>w
map <C-K> <C-W>W

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
"
nnoremap / /\v
vnoremap / /\v

nmap <F5> <Esc>:w!<CR>:make!<CR>

nmap <Leader>cw 1z=
nmap <silent> <Leader>h :silent noh<CR>
nmap <Leader>p :set paste! paste?<CR>
nmap <Leader>bb :Ack "@inproceedings\\|@article\\|@misc\\|@standard" %<CR><CR>:cw<CR>

" --- copy & paste
nnoremap <Leader>y "*yy
nnoremap <Leader>yy "*Y
nnoremap <Leader>p :set paste<CR>:put *<CR>:set nopaste<CR>

" --- buffer and file management
nmap <Leader>w :w!<CR>
nmap <Leader>d :bd<CR>
nmap cn <Esc>:cn<CR>
nmap cp <Esc>:cp<CR>
nmap <Right> :bn<CR>
nmap <Left> :bp<CR>
nmap <Leader>1 :b1<CR>
nmap <Leader>2 :b2<CR>
nmap <Leader>3 :b3<CR>
nmap <Leader>4 :b4<CR>
nmap <Leader>5 :b5<CR>
nmap <Leader>6 :b6<CR>
nmap <Leader>7 :b7<CR>
nmap <Leader>8 :b8<CR>
nmap <Leader>9 :b9<CR>
nmap <Leader>cl :ccl<CR>

" --- Tlist and ctags stuff
nmap <Leader>gt :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR>
nmap <Leader>cc :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <Leader>cd :cs find d <C-R>=expand("<cword>")<CR><CR>
nmap <C-o> <C-]>

" --- basic formatting
nmap <Leader>r1 yypVr=
nmap <Leader>r2 yypVr-
nmap <Leader>fw :%s/\s\+$//<CR>

" --- spellchecking
nmap <Leader>se :setlocal spell spelllang=en_us<CR>
nmap <Leader>sd :setlocal spell spelllang=de<CR>
nmap <Leader>sn :setlocal nospell<CR>


" --- digraphs --------------------------------------------------------------
digraph ,: 8230

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

autocmd FileType note NeoComplCacheDisable
