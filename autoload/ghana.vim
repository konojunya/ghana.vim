" ====================
" issue
" ====================
function! ghana#list_issue() abort
  call ghana#rpc#list_issue()
endfunction
" ====================
" pull request
" ====================
function! ghana#create_pull_request(args) abort
  augroup ghana-new-buffer
    autocmd!
    autocmd BufWriteCmd create-pull-request call ghana#rpc#pr_saved()
  augroup END

  let g:ghana_pr_create_bufnf = bufnr("%")

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
