" Override the autocomment feature of the filetype plugin.
if has("autocmd")
    au FileType * setlocal formatoptions-=cro
endif
