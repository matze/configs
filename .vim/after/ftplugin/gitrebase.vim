function RebaseActionToggle()
    let line = getline(".")
    let result = matchstr(line, "^\\a")
    let transitions = {'p': 'squash', 's': 'fixup', 'f': 'pick'}
    execute "normal! ^cw" . transitions[result]
endfunction

noremap <Cr>   :call RebaseActionToggle()<Cr>
