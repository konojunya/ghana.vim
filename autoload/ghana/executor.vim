" let s:bin = '~/.vim/plugged/ghana.vim/ghana'
" for debug
let s:bin = '/Users/konojunya/.ghq/src/github.com/konojunya/ghana.vim/target/debug/ghana'

" ====================
" issue
" ====================
function! ghana#executor#list_issue() abort
  let owner_and_repo = ghana#git#get_owner_and_repo()

  call system(s:bin + " list_issue")
endfunction

" ====================
" pull request
" ====================
function! ghana#executor#pr_saved() abort
  let buf_body = getline(1, line("$"))
  set nomodified

  let win_ids = ghana#compat#win_findbuf(g:ghana_pr_create_bufnf)
  if empty(win_ids)
    return
  endif

  let win_id = ghana#compat#win_getid()
  if ghana#compat#win_gotoid(win_ids[0])
    call ghana#compat#win_gotoid(win_id)
  endif

  " let owner_and_repo = ghana#git#get_owner_and_repo()
  " let title = buf_body[0]
  " let body = join(buf_body[2:], "\\n")
  " let head = ghana#git#get_current_branch()
  " let base = ghana#git#get_base_branch()

  call system(s:bin + " create_pull_request")
endfunction
