let s:ghana_job_id = 0
" let s:bin = '~/.vim/plugged/ghana.vim/ghana'
" for debug
let s:bin = '~/.ghq/src/github.com/konojunya/ghana.vim/target/debug/ghana'

" ====================
" initialize rpc
" ====================
function! s:init_rpc() abort
  if s:ghana_job_id == 0
    let job_id = jobstart([s:bin], {"rpc": v:true})

    return job_id
  else
    return s:ghana_job_id
  endif
endfunction

function! s:init() abort
  " check github token
  let token = get(g:, "ghana_github_token", "")
  if token == ""
    call ghana#utils#echo_error("g:ghana_github_token is required. Set it in init.vim.")
    return
  endif

  " export the github token to an environment variable for Rust app
  let $GHANA_GITHUB_TOKEN = g:ghana_github_token

  let id = s:init_rpc()
  if id == 0
    call ghana#utils#echo_error("ghana: can not start rpc process")
  elseif id == -1
    call ghana#utils#echo_error("ghana: rpc process is executable")
  else
    let s:ghana_job_id = id
  endif
endfunction

call s:init()

" ====================
" issue
" ====================
function! ghana#rpc#list_issue() abort
  let owner_and_repo = ghana#git#get_owner_and_repo()
  call rpcnotify(s:ghana_job_id, "list_issue", owner_and_repo)
endfunction

function! ghana#rpc#hoge(args) abort
  echo "called hoge"
  echo a:args
endfunction
" ====================
" pull request
" ====================
function! ghana#rpc#pr_saved() abort
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

  let owner_and_repo = ghana#git#get_owner_and_repo()
  let title = buf_body[0]
  let body = join(buf_body[2:], "\\n")
  let head = ghana#git#get_current_branch()
  let base = ghana#git#get_base_branch()

  call rpcnotify(s:ghana_job_id, "create_pull_request", owner_and_repo, head, base, title, body)
endfunction
