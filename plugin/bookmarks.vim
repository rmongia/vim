function! Bookmark()
    if (strlen(@q) <= 1)
        let @q = expand("<cword>")
    endif
    let @q=substitute (@q, "\n", "\\\\n", "g")
    let bookmark=@q . ";" . expand("%:p") . ";" . line(".")
    let @q=bookmark
    sp ~/bookmarks
    put q
    w
    bd
endfunction

function! BookmarksLoad()
    if filereadable (expand ('~/bookmarks'))
        edit ~/bookmarks
        setlocal cursorline
        setlocal bufhidden=delete
        setlocal noswapfile
        syntax match xIgnore /;.*$/
        highlight link xIgnore Ignore
        noremap <buffer> <CR> :call <SID>LoadFile()<CR>
    else
        echohl ErrorMsg | echo "Bookmark file not found" | echohl None
    endif
endfunction

function! s:LoadFile()
    let line = getline( '.' )
    let idx_end = strridx ( line, ";" )
    let line_nr = strpart (line, idx_end + 1)
    let idx_start = strridx (line, ";", idx_end - 1)
    let path = strpart( line, idx_start + 1, idx_end - idx_start - 1)
    "let text = strpart( line, 0, idx_start)
    "silent exe 'pedit +setlocal\ bufhidden=delete ' . path
    silent exe 'edit +' . line_nr . ' ' . path
endfunction
map ,b "qy :call Bookmark()<CR>
map .b :call BookmarksLoad()<CR>
