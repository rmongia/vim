if exists("b:did_indent")
  finish
endif
let b:did_indent = 1
setlocal indentexpr=GetSTLIndent()

function! s:count_braces(lnum, count_open)
  let n_open = 0
  let n_close = 0
  let line = getline(a:lnum)
  let pattern = '<\|>'
  let i = match(line, pattern)
  while i != -1
    if line[i] == '<'
      let n_open += 1
    elseif line[i] == '>'
      if n_open > 0
        let n_open -= 1
      else
        let n_close += 1
      endif
    endif
    let i = match(line, pattern, i + 1)
  endwhile
echo "Open: " . n_open . " close: " . n_close
  return a:count_open ? n_open : n_close
endfunction

function! GetSTLIndent()
  let pnum = prevnonblank(v:lnum - 1)
  if pnum == 0
    return 0
  endif

  return indent(pnum) + s:count_braces(pnum, 1) * &sw
        \ - s:count_braces(v:lnum, 0) * &sw
endfunction
