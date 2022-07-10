" name: Sam Tetruashvili (samt@alumni.cmu.edu)
" title: .vimrc
" date created: Mon May 30 22:14:34 PDT 2011
" description: This file contains my Vim settings.

" last modified: Sun Nov 20 18:00:08 EST 2011

set nocompatible
set bs=2
set number
syn on
set expandtab
set tabstop=4
set shiftwidth=4
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
    delfun OpenCFile
    delfun OpenHFile
    delfun OpenTestFile
    delfun AddIncludeGuard
    delfun EditLedgerLine
    delfun Calculate
endif

" Used to edit ledger files line item amount start columns.
function EditLedgerLine()
    :normal 66|"lyl
    if !(@l == "-" || @l == " ")
        :normal 65|i
    endif
endfunction

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
" note: listchars doesn't work for vim running in Terminal.app unless I set
"       encoding to utf-8.
set encoding=utf-8
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

" Set up \b to start a build with make.
nmap <leader>b :!make<CR>

" Set up \d to updated the 'last modified' date in a file.
nmap <leader>d :call UpdateLastModifiedDate()<CR>
function GetCurrentDate()
    normal mh
    :r!date
    normal $v0"vydd
    normal `h
    normal "vp
endfunction

" Set up \D to paste the current date (via the UNIX date command after the
" current cursor location.
nmap <leader>D :call GetCurrentDate()<CR>
function UpdateLastModifiedDate()
    normal gg
    if search("last modified:") > 0
        normal f:lld$
        :r!date
        normal kJ
    endif
endfunction

" Open .cc file from .h or _test.cc files.
function! OpenCFile()
    if @% =~ ".h"
        :let cc_file = substitute(@%, "\.h", "\.cc", "g")
        :execute "e " . cc_file
    elseif @% =~ "_test.cc"
        :let cc_file = substitute(@%, "_test\.cc", "\.cc", "g")
        :execute "e " . cc_file
    endif
endfunction

"Open .h file from _test.cc or .cc file.
function! OpenHFile()
    if @% =~ "_test.cc"
        :let h_file = substitute(@%, "_test\.cc", "\.h", "g")
        :execute "e " . h_file
    elseif @% =~ ".cc"
        :let h_file = substitute(@%, "\.cc", "\.h", "g")
        :execute "e " . h_file
    endif
endfunction

"Open _test.cc file from .cc or .h file.
function! OpenTestFile()
    if @% =~ ".cc"
        :let test_file = substitute(@%, "\.cc", "_test\.cc", "g")
        :execute "e " . test_file
    elseif @% =~ ".h"
        :let test_file = substitute(@%, "\.h", "_test\.cc", "g")
        :execute "e " . test_file
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
    let @s = escape(@s, '/*~[]')
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

" Calculates the text from the current cursor to the end of the current line.
vmap <leader>x maxi<C-r>=<C-r>"<CR><ESC>`a
nmap <leader>x :call Calculate()<CR>
function Calculate()
    normal ma
    normal "sDa
    :let @s = substitute(@s, "(", "\\\\(", "g")
    :let @s = substitute(@s, ")", "\\\\)", "g")
    :let command = 'calc ' . @s
    execute 'r!' . command
    normal kJ`a
    if getline(".") =~ ","
        :. s/,//g
    endif
    normal `a
endfunction

if has("autocmd")
    " Enable filetype detection and filetype plugins.
    " note: Filetype plugins are stored in ~/.vim/ftplugin.
    filetype on
    filetype plugin on

    " Automatically set Makefiles to use tabs instead of spaces.
    autocmd FileType make setlocal ts=4 sts=4 sw=4 noexpandtab
    autocmd FileType cpp nmap <leader>c :call OpenCFile()<CR>
    autocmd FileType cpp nmap <leader>h :call OpenHFile()<CR>
    autocmd FileType cpp nmap <leader>t :call OpenTestFile()<CR>

    " Ledger commands.
    autocmd FileType ledger nmap <leader>c :call ledger#transaction_state_set(line('.'), '*')<CR>
endif

nmap <leader>T :Tabularize /\|<CR>
vmap <leader>T :Tabularize /\|<CR>

nmap <C-\> :Commentary<CR>
vmap <C-\> :Commentary<CR>

nmap <leader>r :e!%<CR>

nmap <leader>I :call AddIncludeGuard()<CR>
function AddIncludeGuard()
    :let temp = @x
    :let include_guard = toupper(substitute(@%, "[-/.]", "_", "g"))
    :let @x = include_guard
    :normal i#ifndef 
    :normal "xpo
    :normal i#define 
    :normal "xpo
    :normal i#endif  //
    :normal "xp
    :let @x = temp
endfunction

autocmd FileType cpp setlocal commentstring=\/\/\ %s

let vimrc_loaded = 1
