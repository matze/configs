setlocal nosmartindent
setlocal textwidth=79

function! PythonFoldExpr(lnum)
    let line = getline(a:lnum)

    if line =~ '^\s*class '
        let length = strlen(matchstr(line, '^\(\s\)*class ')) / &shiftwidth
        return '>' . length
    endif

    if line =~ '^\s*def '
        let length = strlen(matchstr(line, '^\(\s\)*def ')) / &shiftwidth
        return '>' . length
    endif

    return '='
endfunction

function! PythonFoldText()
    let fold_line = getline(v:foldstart)

    " let line = substitute(fold_line, '^\s*', '', '')
    let line = substitute(fold_line, '(.*$', '', '')
    return line . ' '
endfunction

setlocal foldmethod=expr
setlocal foldexpr=PythonFoldExpr(v:lnum)
setlocal foldtext=PythonFoldText()
