" name: Sam Tetruashvili (samt@alumni.cmu.edu)
" title: .vimrc
" date created: Mon May 30 22:14:34 PDT 2011
" description: This file contains my Vim settings.

" last modified: Sat Jun 11 22:27:48 PDT 2011

set nocompatible
set bs=2
set number
syn on
color desert
set expandtab
set tabstop=4
set shiftwidth=4
set ruler
set spellfile=~/.vim/spellfile.add
set tags=tags;/
set history=100

" Activate the man page plugin.
runtime ftplugin/man.vim

" Set up \e to toggle the visibility of invisible characters.
nmap <leader>e :set list!<CR>
set listchars=tab:▸\ ,eol:¬

" Set \s to toggle highlighting of search string.
nmap <leader>s :set hlsearch!<CR>

" Set up \v to reload my vimrc.
nmap <leader>v :source $MYVIMRC<CR>

" Set up \V to open my vimrc.
nmap <leader>V :e $MYVIMRC<CR>

" Set up \u to toggle the Gundo window.
nmap <leader>u :GundoToggle<CR>

" Set up \d to updated the 'last modified' date in a file.
nmap <leader>d :call UpdateLastModifiedDate()<CR>
function!GetCurrentDate()
    normal mh
    :r!date
    normal $v0"vydd
    normal `h
    normal "vp
endfunction

" Set up \D to paste the current date (via the UNIX date command after the
" current cursor location.
nmap <leader>D :call GetCurrentDate()<CR>
function! UpdateLastModifiedDate()
    normal gg
    if search("last modified:") > 0
        normal f:lld$
        :r!date
        normal kJ
    endif
    normal ``
endfunction

if has("autocmd")
    " Enable filetype detection and filetype plugins.
    " note: Filetype plugins are stored in ~/.vim/ftplugin.
    filetype on
    filetype plugin on

    " Automatically set Makefiles to use tabs instead of spaces.
    autocmd FileType make setlocal ts=4 sts=4 sw=4 noexpandtab
endif

