" Matzes .vimrc
"
" Last revision: 2011-08-10

" --- general ---------------------------------------------------------------
"
set nocompatible    " vi-Kompatibilität ausschalten
set showmatch       " Klammermatching anzeigen
set cursorline      " aktuelle Zeile anzeigen
set ruler           " aktuelle Cursorposition
set laststatus=2    " Status immer anzeigen
set backspace=2     " alles im Insertmode löschen
set noerrorbells    " Klingeling ausschalten
set history=1000    " Commandline-History
set wildmenu        " Tab-completion im Menü
set wildignore+=*~  " will ich nicht sehen
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
nnoremap <Space> za


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
if has("cscope")
    set cst         " use cscope's tag
    set csto=1      " use ctags first

    if filereadable("cscope.out")
        cs add cscope.out
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
endif

" --- stuff for newer versions ----------------------------------------------
"
if version >= 730
    set relativenumber
endif

" --- plugins ---------------------------------------------------------------
"
filetype off

call pathogen#runtime_append_all_bundles()

filetype on
filetype plugin on
filetype indent on

" --- Tagbar
let g:tagbar_type_tex = {
    \ 'ctagstype' : 'latex',
    \ 'kinds'     : [
        \ 's:sections',
        \ 'g:graphics',
        \ 'l:labels',
        \ 'r:refs:1',
        \ 'p:pagerefs:1'
    \ ],
    \ 'sort'    : 0
\ }
nmap <silent> <Leader>tt :TagbarToggle<CR>

" --- minibufexplorer
let g:miniBufExplMaxHeight = 1
let g:miniBufExplMapWindowNavArrows = 0

" --- NERDTree
nmap <Leader>nt :NERDTreeToggle<CR>
nmap <Leader>nf :NERDTreeFind<CR>

" --- fugitive
autocmd BufReadPost fugitive://* set bufhidden=delete
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

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
"imap <C-h>  <Plug>(neocomplcache_snippets_expand)
"smap <C-h>  <Plug>(neocomplcache_snippets_expand)

inoremap  <expr><tab> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<tab>" : "\<C-x>\<C-u>\<C-p>\<Down>"
function! s:check_back_space()"{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

smap <tab>  <right><plug>(neocomplcache_snippets_jump) 
inoremap <expr><c-e> neocomplcache#complete_common_string()

nmap <Leader>nce :NeoComplCacheEnable<CR>
nmap <Leader>ncd :NeoComplCacheDisable<CR>

" --- omni completion -------------------------------------------------------
"
set omnifunc=syntaxcomplete#Complete
set completeopt=menu,preview


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
nnoremap <tab> %
vnoremap <tab> %

nnoremap <F5> "=strftime("%Y-%m-%d")<CR>P
nnoremap <F6> :w!<CR>:make!<CR>
inoremap <F6> <Esc>:w!<CR>:make!<CR>

nmap <Leader>cw 1z=
nmap <silent> <Leader>h :silent noh<CR>
nmap <Leader>p :set paste! paste?<CR>

" --- window management
nmap - <C-W>-<CR>
nmap + <C-W>+<CR>
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" --- buffer and file management
nmap <Leader>w :w!<CR>
nmap <Leader>a :b#<CR>
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
nmap <Leader>bc :bd<CR>

" --- Tlist and ctags stuff
nmap <Leader>gt :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR>
nmap <C-p> <C-]>
nmap <Leader>cc :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <Leader>cd :cs find d <C-R>=expand("<cword>")<CR><CR>

" --- basic formatting
nmap <Leader>r1 yypVr=
nmap <Leader>r2 yypVr-

" --- spellchecking
nmap <Leader>se :setlocal spell spelllang=en_us<CR>
nmap <Leader>sd :setlocal spell spelllang=de<CR>
nmap <Leader>sn :setlocal nospell<CR>


" --- abbreviations ---------------------------------------------------------
"
iab dne den
iab iene eine
iab rekrusiv rekursiv
iab sidn sind
iab vlgr Viele Grüße

" --- digraphs --------------------------------------------------------------
digraph ,: 8230

" --- Auto-Commands ---------------------------------------------------------
"
augroup text
    au!
    au BufNewFile,BufRead       *.rst               set tw=80
    au BufNewFile,BufRead       *.rst               so $VIMRUNTIME/syntax/rst.vim
    au BufNewFile,BufRead       *.tex               set tw=80
augroup END

au BufEnter *.tex   set nosmartindent
au BufNewFile,BufRead       *.cl set filetype=c
augroup END
