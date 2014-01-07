function! MakeReferenceLink()
    try
        let a_save = @a
        normal! gv"ay

        " Replace selection with link
        execute ":'<,'>s/" . @a . "/[" . @a . "][]/g"

        " Append link at the bottom
        execute "normal! Go[" . @a . "]: "
        execute "normal! $\"+p"
    finally
        let @a = a_save
    endtry
endfunction

nnoremap <Leader>lr ciw[<C-r>"][]<Esc>Go[<C-r>"]: <Esc>"+p``
vnoremap <Leader>lr :call MakeReferenceLink()<CR>``
nnoremap <Leader>li ciw[<C-r>"](<Esc>"+pli)<Esc>
vnoremap <Leader>li c[<C-r>"](<Esc>"+pli)<Esc>

setlocal nosmartindent
