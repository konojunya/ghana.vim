function! ghana#compat#win_findbuf(bufnr) abort
  if !exists('*win_findbuf')
    return []
  endif

  return win_findbuf(a:bufnr)
endfunction


function! ghana#compat#win_getid() abort
  if !exists('*win_getid')
    return 0
  endif

  return win_getid()
endfunction


function! ghana#compat#win_gotoid(expr) abort
  if !exists('*win_gotoid')
    return 0
  endif

  return win_gotoid(a:expr)
endfunction
