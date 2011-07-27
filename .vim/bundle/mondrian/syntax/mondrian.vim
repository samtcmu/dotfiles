" Copyright 2010 Google Inc. All Rights Reserved.
"
" Author: jkinkead@google.com (Jesse Kinkead)
"
" Vim syntax for Mondrian review mails.
"
" This highlights lines Mondrian treats specially when processing email.


" Quit when a syntax file was already loaded.
if exists('b:current_syntax')
  finish
endif


syn keyword mondrianKeyword File Line snapshot contained

syn match mondrianFilePath 'File //depot/[^ ]* (snapshot \w*)' contains=mondrianKeyword contained
syn match mondrianLineNumber 'Line \d*\ze:' contains=mondrianKeyword contained
syn match mondrianLink 'http://mondrian.corp[^ ]*' contained
syn match mondrianQuoted '^> .*' contains=mondrianTag,mondrianFilePath,mondrianLineNumber,mondrianLink,mondrianSkip
syn match mondrianSkip '\(=\{72\}\|-\{36\}\)'
syn match mondrianTag '|Comment_\d\+|'


hi def link mondrianFilePath String
hi def link mondrianKeyword Keyword
hi def link mondrianLineNumber Number
hi def link mondrianLink String
hi def link mondrianQuoted Comment
hi def link mondrianSkip PreProc
hi def link mondrianTag Identifier


let b:current_syntax = 'mondrian'
