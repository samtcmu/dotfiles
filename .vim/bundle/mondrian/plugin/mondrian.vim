" Copyright 2010 Google Inc. All Rights Reserved.
"
" Author: jkinkead@google.com (Jesse Kinkead)
"
" Vim script containing functions to fetch mondrian comments and turn them into
" an email template + tags file.
" Tedxt.

" Global settings.  These can be overridden in a .vimrc file.


" Directory to put email files while they are being written.  This should be in
" your home directory (and more specifically, should be somewhere not easily
" world-readable).
if !exists('g:mondrian_review_tmp_dir')
  let g:mondrian_review_tmp_dir = expand('~/.mondrian_vim')
endif
if !isdirectory(g:mondrian_review_tmp_dir)
  call mkdir(g:mondrian_review_tmp_dir, 'p')
endif


" Caches the location of the generate_mondrian_files.par archive.  This is
" populated lazily; populating during initialization will sometimes fail.
let s:generate_mondrian_files = ''


" Gets location of the generate_mondrian_files.par archive.
function _GetGenerateMondrianFiles()
  let l:search_path = matchstr(&runtimepath, '.\{-},\@=')
  return findfile('generate_mondrian_files.par', l:search_path . '/**')
endfunction


" Gets comments.  If no arguments are provided, this fetches comments for the
" currently open buffer file.  If one string argument is provided, this fetches
" comments for the file named.  If one number argument is provided, this fetches
" comments for the CL named.
function GetComments(...)
  " If set, use this as the file name to fetch comments for.
  let l:file_name = ''
  " If l:file_name is not set, use this as the CL number to fetch comments for.
  let l:cl_number = 0
  if !a:0
    " Use current buffername.
    let l:file_name = bufname('%')
  elseif match(a:1, '^\d\+$') >= 0
    " CL number.
    let l:cl_number = a:1
  else
    " Filename.
    let l:file_name = a:1
  endif
  " Set the extra arguments string for generate_mondrian_files.
  if l:file_name != ''
    echo 'Fetching comments for file ' . l:file_name . ' . . .'
    let l:extra_args = '--cl_file ' . shellescape(l:file_name)
  else
    echo 'Fetching comments for CL ' . l:cl_number . ' . . .'
    let l:extra_args = '--cl_number ' . shellescape(l:cl_number)
  endif
  let l:email_file = _CallGenerateMondrianFiles(l:extra_args)
  " Open the email file, if it was generated successfully.
  if l:email_file != ''
    execute 'split ' . l:email_file
    0
    " Fold out the email headers from view.
    let l:old_foldmethod = &foldmethod
    let &l:foldmethod = 'manual'
    let l:blankline = search('^$')
    execute '1,' . l:blankline . 'fold'
    " Move past the fold.
    execute l:blankline + 1
    let &l:foldmethod = l:old_foldmethod
    " Set the filetype.
    " TODO(jkinkead): Use automatic filetype detection?
    set filetype=mondrian
  endif
endfunction


" Sends the current file with sendmail.  This uses the '-t' flag which takes the
" from / to info from the headers in the email given.
" The file will be written before sending.
function SendCurrentFile()
  write
  " This will break if 'shell' doesn't support redirection.
  execute '!echo Sending mail . . . && sendmail -i -t < ' .
      \ shellescape(bufname('%')) . '&& echo Done.'
endfunction


" Calls the generate_mondrian_files script, and returns the email file.  Prints
" out any error messages encountered while running the script.
"
" Arguments:
"   extra_args: An extra string literal to include in the script arguments.
"       Must be shell-escaped as needed.
" Returns:
"   Empty string on error (and prints out an error message).
function _CallGenerateMondrianFiles(extra_args)
  if !executable(s:generate_mondrian_files)
    let s:generate_mondrian_files =
        \ fnamemodify(_GetGenerateMondrianFiles(), ':p')
    if !executable(s:generate_mondrian_files)
      echoerr 'Could not find generate_mondrian_files.par file'
      return ''
    endif
  endif
  let l:output = system(shellescape(s:generate_mondrian_files) .
          \ ' --cwd ' . shellescape(getcwd()) . ' --output_dir ' .
          \ g:mondrian_review_tmp_dir . ' ' . a:extra_args)
  if v:shell_error
    " echoerr handles newlines weirdly - they get printed as '@' - so use echohl
    " to style instead.
    echohl ErrorMsg
    echo l:output
    echohl None
    return ''
  else
    return l:output
  endif
endfunction


" Command shortcut for GetComments.
command! -nargs=? MGet :call GetComments(<args>)
" Convenience command which autocompletes files but is otherwise identical to
" MGet.
command! -nargs=? -complete=file MGetFile :call GetComments(<args>)
" Command shortcut for SendCurrentFile.
command! MMail :call SendCurrentFile()
