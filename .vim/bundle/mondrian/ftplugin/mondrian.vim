" Copyright 2010 Google Inc. All Rights Reserved.
"
" Author: jkinkead@google.com (Jesse Kinkead)
"
" Vim script for mondrian filetype.  Contains some special mappings.

" Looks at the word under the cursor.  If it's a tag, opens it in the preview
" window.  If not, the cursor is advanced as if <Enter> was pressed.
function! s:_PreviewTag()
  let l:word = expand('<cword>')
  try
    " Jump to preview tag.
    execute 'ptag ' . l:word
  catch
    " Tag not found.  Emulate <CR>.
    let l:curline = line('.')
    if l:curline != line('$')
      execute l:curline + 1
    endif
  endtry
endfunction

" Allow a user to press <Enter> on a comment tag to open a view into that tag.
nnoremap <buffer> <silent> <CR> :call <SID>_PreviewTag()<CR>
