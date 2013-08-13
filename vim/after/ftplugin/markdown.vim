function! MarkdownLevel()
    let h = matchstr(getline(v:lnum), '^#\+')

    if empty(h)
        return "="
    else
        return ">" . len(h)
    endif
endfunction

au BufEnter *.md setlocal foldexpr=MarkdownLevel()
au BufEnter *.md setlocal foldmethod=expr
