setlocal textwidth=72

function! MailRemoveSignature()
    let i = 0

    while (i <= line('$')) && (getline(i) !~ '^> *-- \=$')
        let i = i + 1
    endwhile

    if i != line('$') + 1
        let j = i

        while j < line('$') && getline(j + 1) !~ '^-- $'
            let j = j + 1
        endwhile

        while i > 0 && getline(i - 1) =~ '^\(>\s*\)*$'
            let i = i - 1
        endwhile

        silent execute ':' . i . ',' . j . 'd'
    endif
endfunction

function! MailFixQuote()
    silent :%s/> >/>>/ge
    silent :%s/>>\([^>]\)/>> \1/ge
endfunction

call MailRemoveSignature()
call MailFixQuote()
