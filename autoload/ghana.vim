" ====================
" pull request
" ====================
function! ghana#create_pull_request(args) abort
  augroup ghana-new-buffer
    autocmd!
    autocmd BufWriteCmd create-pull-request call ghana#rpc#pr_saved(bufnr("%"))
  augroup END

  new
  call setline(1, a:args)
  call append(line("$"), "---")
  call append(line("$"), "PULL_REQUEST_TEMPLATE")

  file create-pull-request
  set nomodified
  setlocal buftype=acwrite
  setlocal filetype=md
  setlocal noswapfile
endfunction
