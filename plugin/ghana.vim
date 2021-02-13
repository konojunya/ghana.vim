if exists("s:ghana_loaded")
  finish
endif
let s:ghana_loaded = 1

" binding functions
command! GhanaListIssue :call ghana#list_issue()
command! -nargs=1 GhanaCreatePullRequest :call ghana#create_pull_request(<f-args>)
