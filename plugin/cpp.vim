function! LoadHeaderFile()
    0read ~/.vim/plugin/cpp/h.tmpl
    if exists('$PROJECT')
        let path = toupper(expand("<afile>:p"))
        let mangled_filename = toupper($PROJECT) . substitute(substitute(substitute(path, '.*\(\(/[^/]*\)\{3}$\)', '\1',""), '_','','g'), '[./]' , '_', 'g')
    else
        let mangled_filename = "__" . substitute (toupper(expand ("<afile>:t")), "\\.", "_", "g") . "__"
    endif
    /__IFDEFS__
    delete
    execute "normal i#ifndef " . mangled_filename . "\r"
    execute "normal i#define " . mangled_filename . "\r"
    /#endif
    delete
    execute "normal i#endif // " . mangled_filename
    %s/__NS__/\=expand("<afile>:p:h:t")/g
    ?namespace
endfunction

function! LoadSourceFile()
    0read ~/.vim/plugin/cpp/cpp.tmpl
    if exists('$PROJECT')
        let path = toupper(expand("<afile>:p"))
        let mangled_filename = toupper($PROJECT) . substitute(substitute(substitute(path, '.*\(\(/[^/]*\)\{3}$\)', '\1',""), '_','','g'), '[./]' , '_', 'g')
    else
        let mangled_filename = "__" . substitute (toupper(expand ("<afile>:t")), "\\.", "_", "g") . "__"
    endif
    %s/__NS__/\=expand("<afile>:p:h:t")/g
    ?namespace
endfunction

" Templates
:au BufNewFile *.cpp call LoadSourceFile()
:au BufNewFile *.h call LoadHeaderFile()
:au BufNewFile *.c 0read ~/.vim/plugin/cpp/c.tmpl
