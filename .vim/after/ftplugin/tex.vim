setlocal textwidth=80
setlocal shiftwidth=2
setlocal nosmartindent
setlocal commentstring=%\ %s

function! CheckSyntax()
    let oldmakeprg=&l:makeprg
    let olderrorformat=&l:errorformat

    setlocal makeprg=check-writing\ -v\ %\ $*
    setlocal errorformat=%f:%l:\ %m

    make

    exec 'setlocal makeprg=' . oldmakeprg
    exec 'setlocal errorformat=' . olderrorformat
endfunction

map <F7> :call CheckSyntax()<CR>
