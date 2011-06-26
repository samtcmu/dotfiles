" Vim color file
" Maintainer:   Hans Fugal <hans@fugal.net>
" Last Change:  $Date: 2004/06/13 19:30:30 $
" Last Change:  $Date: 2004/06/13 19:30:30 $
" URL:      http://hans.fugal.net/vim/colors/desert.vim
" Version:  $Id: desert.vim,v 1.1 2004/06/13 19:30:30 vimboss Exp $

" cool help screens
" :he group-name
" :he highlight-groups
" :he cterm-colors

set background=dark
if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    hi clear
    if exists("syntax_on")
    syntax reset
    endif
endif
let g:colors_name="desert"

hi Normal       gui=NONE             guifg=White       guibg=grey20

" highlight groups
hi Cursor       gui=NONE             guifg=slategrey   guibg=khaki
hi CursorIM     gui=NONE             guifg=NONE        guibg=NONE
hi Directory    gui=NONE             guifg=NONE        guibg=NONE
hi DiffAdd      gui=NONE             guifg=NONE        guibg=NONE
hi DiffChange   gui=NONE             guifg=NONE        guibg=NONE
hi DiffDelete   gui=NONE             guifg=NONE        guibg=NONE
hi DiffText     gui=NONE             guifg=NONE        guibg=NONE
hi ErrorMsg     gui=NONE             guifg=NONE        guibg=NONE
hi VertSplit    gui=NONE             guifg=grey50      guibg=#c2bfa5
hi Folded       gui=NONE             guifg=gold        guibg=grey30
hi FoldColumn   gui=NONE             guifg=tan         guibg=grey30
hi IncSearch    gui=NONE             guifg=slategrey   guibg=khaki
hi LineNr       gui=NONE             guifg=NONE        guibg=NONE
hi ModeMsg      gui=NONE             guifg=goldenrod   guibg=NONE
hi MoreMsg      gui=NONE             guifg=SeaGreen    guibg=NONE
hi NonText      gui=NONE             guifg=LightBlue   guibg=grey30
hi Question     gui=NONE             guifg=springgreen guibg=NONE
hi Search       gui=NONE             guifg=wheat       guibg=peru
hi SpecialKey   gui=NONE             guifg=yellowgreen guibg=NONE
hi StatusLine   gui=NONE             guifg=black       guibg=#c2bfa5
hi StatusLineNC gui=NONE             guifg=grey50      guibg=#c2bfa5
hi Title        gui=NONE             guifg=indianred   guibg=NONE
hi Visual       gui=NONE             guifg=khaki       guibg=olivedrab
hi VisualNOS    gui=NONE             guifg=NONE        guibg=NONE
hi WarningMsg   gui=NONE             guifg=salmon      guibg=NONE
hi WildMenu     gui=NONE             guifg=NONE        guibg=NONE
hi Menu         gui=NONE             guifg=NONE        guibg=NONE
hi Scrollbar    gui=NONE             guifg=NONE        guibg=NONE
hi Tooltip      gui=NONE             guifg=NONE        guibg=NONE

" syntax highlighting groups
hi Comment      gui=NONE             guifg=SkyBlue     guibg=NONE
hi Constant     gui=NONE             guifg=#ffa0a0     guibg=NONE
hi Identifier   gui=NONE             guifg=palegreen   guibg=NONE
hi Statement    gui=NONE             guifg=khaki       guibg=NONE
hi PreProc      gui=NONE             guifg=indianred   guibg=NONE
hi Type         gui=NONE             guifg=darkkhaki   guibg=NONE
hi Special      gui=NONE             guifg=navajowhite guibg=NONE
hi Underlined   gui=NONE             guifg=NONE        guibg=NONE
hi Ignore       gui=NONE             guifg=grey40      guibg=NONE
hi Error        gui=NONE             guifg=NONE        guibg=NONE
hi Todo         gui=NONE             guifg=orangered   guibg=yellow2

" color terminal definitions
hi SpecialKey   cterm=NONE           ctermfg=darkgreen ctermbg=NONE
hi NonText      cterm=bold           ctermfg=darkblue  ctermbg=NONE
hi Directory    cterm=NONE           ctermfg=darkcyan  ctermbg=NONE
hi ErrorMsg     cterm=bold           ctermfg=7         ctermbg=1
hi IncSearch    cterm=NONE           ctermfg=yellow    ctermbg=green
hi Search       cterm=NONE           ctermfg=darkgrey  ctermbg=yellow
hi MoreMsg      cterm=NONE           ctermfg=darkgreen ctermbg=NONE
hi ModeMsg      cterm=NONE           ctermfg=brown     ctermbg=NONE
hi LineNr       cterm=NONE           ctermfg=3         ctermbg=NONE
hi Question     cterm=NONE           ctermfg=green     ctermbg=NONE
hi StatusLine   cterm=bold,reverse   ctermfg=NONE      ctermbg=NONE
hi StatusLineNC cterm=reverse        ctermfg=NONE      ctermbg=NONE
hi VertSplit    cterm=reverse        ctermfg=NONE      ctermbg=NONE
hi Title        cterm=NONE           ctermfg=5         ctermbg=NONE
hi Visual       cterm=reverse        ctermfg=NONE      ctermbg=NONE
hi VisualNOS    cterm=bold,underline ctermfg=NONE      ctermbg=NONE
hi WarningMsg   cterm=NONE           ctermfg=1         ctermbg=NONE
hi WildMenu     cterm=NONE           ctermfg=0         ctermbg=3
hi Folded       cterm=NONE           ctermfg=darkgrey  ctermbg=NONE
hi FoldColumn   cterm=NONE           ctermfg=darkgrey  ctermbg=NONE
hi DiffAdd      cterm=NONE           ctermfg=NONE      ctermbg=4
hi DiffChange   cterm=NONE           ctermfg=NONE      ctermbg=5
hi DiffDelete   cterm=bold           ctermfg=4         ctermbg=6
hi DiffText     cterm=bold           ctermfg=NONE      ctermbg=1
hi Comment      cterm=NONE           ctermfg=darkcyan  ctermbg=NONE
hi Constant     cterm=NONE           ctermfg=brown     ctermbg=NONE
hi Special      cterm=NONE           ctermfg=5         ctermbg=NONE
hi Identifier   cterm=NONE           ctermfg=6         ctermbg=NONE
hi Statement    cterm=NONE           ctermfg=3         ctermbg=NONE
hi PreProc      cterm=NONE           ctermfg=5         ctermbg=NONE
hi Type         cterm=NONE           ctermfg=2         ctermbg=NONE
hi Underlined   cterm=underline      ctermfg=5         ctermbg=NONE
hi Ignore       cterm=bold           ctermfg=7         ctermbg=NONE
hi Ignore       cterm=NONE           ctermfg=darkgrey  ctermbg=NONE
hi Error        cterm=bold           ctermfg=7         ctermbg=1

"vim: sw=4

