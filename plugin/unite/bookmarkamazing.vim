let s:save_cpo = &cpo
set cpo&vim

"TODO custom korosu
"call unite#custom#action('file', 'bookmark', s:file_bookmark_action)
"call unite#custom#action('buffer', 'bookmark', s:buffer_bookmark_action)
delcommand UniteBookmarkAdd

command! -nargs=? -complete=customlist,s:unite_bookmarkamazing_comp
      \ UniteBookmarkAmazingAdd call s:unite_bookmarkamazing_edit(<q-args>)

function! s:unite_bookmarkamazing_comp(A,L,P) "{{{
  return filter(unite#sources#bookmarkamazing#get_bookmark_file_complete_list(a:A, a:L, a:P), "
        \ v:val != '*'
        \ ")
endfunction "}}}

function! s:unite_bookmarkamazing_edit(st_arg) "{{{
  let st_file = empty(a:st_arg) ? 'default.md' : a:st_arg
  let st_file = (st_file =~? '\.md$') ? st_file : st_file . '.md'
  let st_path = g:unite_source_bookmarkamazing_directory . '/' . st_file
  if empty(glob(st_path))
    echom 'file not found ' . st_path
  endif
  silent exe join(['tabe', st_path])
endfunction "}}}

let &cpo = s:save_cpo
unlet s:save_cpo