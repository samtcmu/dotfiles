" name: Sam Tetruashvili (samt@alumni.cmu.edu)
" title: .vimrc
" date created: Mon May 30 22:14:34 PDT 2011
" description: This file contains my Vim settings.

" last modified: Thu 09 Apr 2020 03:48:51 PM UTC

set nocompatible
set bs=2
set number
syn on
set expandtab
set tabstop=2
set shiftwidth=2
set ruler
set spellfile=~/.vim/spellfile.add
set tags=tags;/
set history=100

if exists("vimrc_loaded")
    delfun GetCurrentDate
    delfun UpdateLastModifiedDate
    delfun ToggleFolds
    delfun SearchSelectedText
    delfun SearchWordUnderCursor
    delfun SearchForString
    delfun InitHeaderFile
endif

if has('gui_running')
    " color solarized
    " set bg=dark
    color pablo
    set guioptions= 
else
    color desert
    set bg=light
    set bg=dark
endif

" Initialize the pathogen plugin.
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Activate the man page plugin.
runtime ftplugin/man.vim

" Set up \e to toggle the visibility of invisible characters.
nmap <leader>e :set list!<CR>
set listchars=tab:▸\ ,eol:¬

" Set \s to toggle highlighting of search string.
nmap <leader>s :set hlsearch!<CR>

" Set up \a to toggle spellcheck.
nmap <leader>a :set spell!<CR>

" Set up \l to highlight of lines longer than 80 characters.
nmap <leader>l :/\%>80v.\+<CR>

" Set up \v to reload my vimrc.
nmap <leader>v :source $MYVIMRC<CR>

" Set up \V to open my vimrc.
nmap <leader>V :e $MYVIMRC<CR>

" Set up \u to toggle the Gundo window.
nmap <leader>u :GundoToggle<CR>

" Set up \d to updated the 'last modified' date in a file.
" nmap <leader>d :call UpdateLastModifiedDate()<CR>
function GetCurrentDate()
    normal mh
    :r!date
    normal $v0"vydd
    normal `h
    normal "vp
endfunction

" Set up \D to paste the current date (via the UNIX date command after the
" current cursor location.
" nmap <leader>D :call GetCurrentDate()<CR>
function UpdateLastModifiedDate()
    normal gg
    if search("last modified:") > 0
        normal f:lld$
        :r!date
        normal kJ
    endif
endfunction

" Set up \f and \F to open and close all fold respectively.
nmap <leader>f :call ToggleFolds()<CR>
function ToggleFolds()
    " Set the ToggleFolds variable for the current buffer to false (0) if
    " it didn't exists before. This indicates that folds are all initially
    " closed.
    if !exists('b:FoldsOpen')
        let b:FoldsOpen = 0
    endif

    if b:FoldsOpen
        " Toggle folding off.
        normal zM
        echo "folds: closed"
    else
        " Toggle folding on.
        normal zR
        echo "folds: opened"
    endif

    " Toggle the FoldsOpen variable to indicate the new fold setting.
    let b:FoldsOpen = !b:FoldsOpen
endfunction

" Set up \\ to search for the currently selected text in visual mode.
vmap <leader><leader> :call SearchSelectedText()<CR>
function SearchSelectedText()
    normal gv"sy
    let @s = escape(@s, '/*~')
    :call SearchForString()
endfunction

" Set up \\ to search for the word that the cursor is currently over
" without jumping to the next instance of the query like * and ? do.
nmap <leader><leader> :call SearchWordUnderCursor()<CR>
function SearchWordUnderCursor()
    " note: Save the cursor position in the s mark and return to it once the
    "       current word is copied.
    normal ms
    normal "syiw
    normal `s
    let @s = '\<' . @s . '\>'

    :call SearchForString()
endfunction

" This function will search for the string currently in the @s register.
" TODO This function shouldn't really exist. It only exists because vim does
"      not automatically add the search query to the command line search
"      history when you issue ':let @/ = <query>'.
function SearchForString()
    " Set the search register to the selected text and search for it without
    " going to the next instance of the query.
    let @/ = @s

    " BUGFIX Manually add the currently selected text to the command line
    "        search history.
    normal /<C-r>/<CR>
endfunction

nmap <leader>I :call InitHeaderFile()<CR>
function InitHeaderFile()
  let @h = "// Copyright 2011 Google Inc. All Rights Reserved.\n"
  let @h .= "// Author: samtet@google.com (Sam Tetruashvili)\n\n"

  let @f = substitute(@%, '/', '_', 'g')
  let @f = substitute(@f, '-', '_', 'g')
  let @f = substitute(@f, '\.', '_', 'g')
  let @f = substitute(@f, "[a-z]", "\\U\\0", "g")
  let @f .= "_"

  let @h .= "#ifndef " . @f . "\n"
  let @h .= "#define " . @f . "\n\n"
  let @h .= "#endif  // " . @f

  normal gg
  normal "hP
endfunction

if has("autocmd")
    " Enable filetype detection and filetype plugins.
    " note: Filetype plugins are stored in ~/.vim/ftplugin.
    filetype on
    filetype plugin on

    " Automatically set Makefiles to use tabs instead of spaces.
    autocmd FileType make setlocal ts=2 sts=2 sw=2 noexpandtab
endif

" Google specific includes.
source ~/config/dotfiles/.google_vimrc

let vimrc_loaded = 1

