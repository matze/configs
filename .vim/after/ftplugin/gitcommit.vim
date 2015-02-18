function SquashAcceptMessage()
python << endpython
import vim

row, _ = vim.current.window.cursor
row -= 1
lines = vim.current.window.buffer
region = lines[row:]
hits = [i for (l, i) in zip(region, range(row, row + len(region))) if l.startswith('#') or not l]
del lines[hits[0]:hits[1] + 1]
vim.current.window.cursor = (hits[2], 0)
endpython
endfunction


function SquashRevokeMessage()
python << endpython
import vim

row, _ = vim.current.window.cursor
row -= 1
lines = vim.current.window.buffer
region = lines[row:]
hits = [i for (l, i) in zip(region, range(row, row + len(region))) if l.startswith('#') or not l]
del lines[hits[0]:hits[2] + 1]
endpython
endfunction


noremap <Cr>    :call SquashAcceptMessage()<Cr>
noremap <Del>   :call SquashRevokeMessage()<Cr>
