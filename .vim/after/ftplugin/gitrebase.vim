function RebaseActionToggle()
    let line = getline(".")
    let match = matchstr(line, "^\\a")
    let transitions = {'p': 'squash', 's': 'fixup', 'f': 'pick'}
    execute "normal! ^cw" . transitions[match]
endfunction

noremap <Cr>   :call RebaseActionToggle()<Cr>
