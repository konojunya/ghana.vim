function s:get_root_dir() abort
  return system("git rev-parse --git-dir")
endfunction

" for example, feat/xxx is returned
function! ghana#git#get_current_branch() abort
  return system("git rev-parse --abbrev-ref HEAD")
endfunction

function ghana#git#get_base_branch() abort
  let root = trim(s:get_root_dir())
  let ref = root . "/refs/remotes/origin/HEAD"
  let line = readfile(ref)[0]
  let t = split(line, "/")
  let base_branch = t[len(t)-1]

  return base_branch
endfunction

" TODO @konojunya repoはremote originから取ってきてる関係で
" repo.gitの場合があるので、repoだけになるように整形する
function! ghana#git#get_owner_and_repo() abort
  let origin_url = system("git config --get remote.origin.url")
  let s = split(origin_url, "/")
  let repo = trim(s[len(s)-1])
  let owner = s[len(s)-2]

  return owner . "/" . repo
endfunction
