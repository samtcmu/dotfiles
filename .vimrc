" name: Sam Tetruashvili (samt@alumni.cmu.edu)
" title: .vimrc
" date created: Mon May 30 22:14:34 PDT 2011
" description: This file contains my Vim settings.

" last modified: Sun Jun 26 01:12:33 PDT 2011

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

if has('gui_running')
    " color solarized
    " set bg=dark
    color pablo
    set guioptions= 
else
    color desert
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
endfunction

" Set up \f and \F to open and close all fold respectively.
nmap <leader>f :call ToggleFolds()<CR>
function! ToggleFolds()
    " Set the ToggleFolds variable for the current buffer to false (0) if
    " it didn't exists before. This indicates that folds are all intially
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

" Set up \c to open the .cc file corresponding to the .h file open in the
" current buffer.
nmap <leader>c :e %:r.cc<CR>

" Set up \h to open the .h file corresponding to the .cc file open in the
" current buffer.
nmap <leader>h :e %:r.h<CR>

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

