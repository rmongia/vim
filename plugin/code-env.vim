function! s:RebuildIndex()
    :!find $REPO_ROOT -name "*.cpp" -o -name "*.h" -o -name "*.c" -printf "\%f:\%p\n" >& $REPO_ROOT/files.list
endfunction

" FileExplorer
noremap <C-F> :call FileExplorer()<CR>
function! FileExplorer()
    if filereadable( $REPO_ROOT . '/cscope.files' )
        edit $REPO_ROOT/cscope.files
        setlocal nomodifiable
        setlocal readonly
        setlocal buftype=nowrite
        setlocal bufhidden=delete
        setlocal noswapfile
        syntax match xIgnore /:.*$/
        highlight link xIgnore Ignore
        noremap <buffer> <CR> :call LoadFile()<CR>
    else
        echohl ErrorMsg | echo "cscope.files not found" | echohl None
    endif
endfunction
function! LoadFile()
    let line = getline( '.' )
    let idx = stridx( line, ":" )
    let path = strpart( line, idx + 1)
    "silent exe 'pedit +setlocal\ bufhidden=delete ' . path
    silent exe 'edit ' . path
endfunction

nnoremap <silent> <buffer> <F5> :call <SID>RebuildIndex()<cr>
