function LoadFileLine ()
    let filename=expand ("<afile>")
    let items=split (filename, ":")
    exe "edit +" . items[1] items[0]
endfunction

au BufNewFile *:\d* call LoadFileLine ()
