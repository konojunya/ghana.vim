let g:ghana_job_id = 0
" FIXME @konojunya Rustのバイナリを指定する
let s:bin = ""

" ====================
" initialize rpc
" ====================
function! s:init_rpc() abort
  if g:ghana_job_id == 0
    " let job_id = jobstart([s:bin], {"rpc": v:true})
    let job_id = jobstart(["ls"])

    return job_id
  else
    return g:ghana_job_id
  endif
endfunction

function! s:init() abort
  let id = s:init_rpc()
  if id == 0
    echoerr "ghana: can not start rpc process"
  elseif id == -1
    echoerr "ghana: rpc process is executable"
  else
    let g:ghana_job_id = id
  endif
endfunction

call s:init()

" ====================
" rpc functions
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

  echo "call rpcnotify(pull_request_save)"

  let owner_and_repo = ghana#git#get_owner_and_repo()
  let title = buf_body[0]
  let body = join(buf_body[2:], "\\n")
  let head = ghana#git#get_current_branch()
  let base = ghana#git#get_base_branch()

  let p = {'owner_and_repo': owner_and_repo,'title': title,'body': body,'head': head,'base': base}

  echo p
endfunction
