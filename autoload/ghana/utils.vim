function! ghana#utils#echo_error(message) abort
  echohl Error
  echomsg a:message
  echohl None
endfunction
