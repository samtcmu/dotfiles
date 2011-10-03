" Copyright 2005-2007 Google Inc.
" All Rights Reserved.
" Author: plakal@google.com (Manoj Plakal), mheule@google.com (Markus Heule)
"
" gcl.vim: Vim syntax file for GCL config files.
"
" GCL Language links:
" http://wiki.corp.google.com/twiki/bin/view/Main/BCLReference
" http://wiki.corp.google.com/twiki/bin/view/Main/BCLQuickReference
" //depot/google3/configlang
"
" Usage:
"   - Either source the main google.vim file from
"     /usr/share/vim/google/google.vim
"
"   - Or do the following manually:
"     - Copy this file into ~/.vim/syntax/gcl.vim
"     - Put this snippet into ~/.vim/filetype.vim
"         if exists("did_load_filetypes")
"           finish
"         endif
"         augroup filetypedetect
"           au! BufRead,BufNewFile *.gcl setfiletype gcl
"         augroup END
"     - Put this snippet into ~/.vimrc
"         filetype on
"         syntax on
"

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Valid characters of identifiers: - 0-9 A-Z _ a-z
if version >= 600
  setlocal iskeyword=45,48-57,65-90,95,97-122
else
  set iskeyword=45,48-57,65-90,95,97-122
endif

" Keywords.
syn keyword gclConstant     true false null external
syn keyword gclProperty     final local validation_ignore template
syn keyword gclInclude      import as
syn keyword gclKeyword      expansion lambda assert super up expect
syn match   gclComment      "//.*$" contains=gclTodo display
syn match   gclComment      "#.*$" contains=gclTodo display
syn keyword gclTodo         contained TODO FIXME

" Strings.
" String literals are delimited by "" and contain the usual escapes.
" String literals can also contain interpolated expressions within %
" (where the % is escaped using double %%).
" We ignore the escaping of ordinary characters for now.
syn region gclString   start=+"+ end=+"+ skip=+\\\\\|\\"+ 
                        \contains=gclEscape,gclExpr
syn match  gclEscape   +\\[abfnrtv'"\\\n]+ contained
syn match  gclEscape   "\\\o\o\+" contained display
syn match  gclEscape   "\\\x\x\+" contained display
" Match escaped %.
syn match  gclEscape   +%%+ contained display
" Match all %expr%.
syn match  gclExpr     "%[^%]\+%" contained
" Raw strings (no escaping/interpolation) are delimited using single quotes.
syn region gclRawStr   start=+'+ end=+'+

" Numeric literals = integers and floats.
" Integer literals are the usual octal, decimal, hex except that they can
" include underscores and have a trailing unit (K/M/G/T/P). In addition,
" we also allow integers of the form <decimal-fraction>[K/M/G/T/P], e.g., 1.5G
syn match   gclNumber  "\<0\o[0-7_]\+[KMGTP]\?\>" display
syn match   gclNumber  "\<\d[0-9_]*[KMGTP]\?\>" display
syn match   gclNumber  "\<0x\x[0-9a-fA-F_]\+[KMGTP]\?>" display
syn match   gclNumber  "\<\d\+\.\d\+\>" display
syn match   gclNumber  "\<\d*\(\.\(\d+\)\?\)\?\([eE][+-]\?\d\+\)\>" display

" Object definitions: testcase and test.
" Highlight both the keyword and the name of the defined object that
" follows the keyword. Except when they are preceded by a '.'
" which is the borg way of allowing attributes with these special names.
syn region  gclObjectDef    matchgroup=gclObjectKeyword 
                            \start="\<\.\@<!\(testcase\|test\)\>" 
                            \matchgroup=gclObjectName 
                            \end="\<[A-Za-z_][A-Za-z0-9_\-]*\>" 
                            \oneline skipwhite keepend

" Identifiers.
" Normally these don't require highlighting but GCL allows
" identifiers with arbitrary characters inside backquotes.
syn region  gclRawIdent matchgroup=Normal start=+`+ end=+`+ oneline keepend

" Sections within a GCL object. Note that not all sections can
" occur within all objects, but we punt on context-sensitivity
" for now since that would require us to parse GCL
" within the edit buffer. Keep both sections and attributes (below)
" in sync with the GCL source.
syn keyword gclSection      vars

" Attributes within sections. Note that not all attributes can
" occur within all sections, but we punt on context-sensitivity.
" Currently we do not have any registered attribute name in GCL. Use the line
" below as an example for a future attribute.
" syn keyword gclAttribute    attribute_name

" GCL's builtin functions. Keep this in sync with:
" grep ConfFunction::Register google3/configlang/builtins.cc |
"   cut -d\" -f 2 | sort | fmt -50 | sed 's/^/syn keyword gclBuiltin /'
" and also update borg.vim
syn keyword gclBuiltin attributes basename bcl_version check_assertions
syn keyword gclBuiltin collate_map commonprefix compute_field cond
syn keyword gclBuiltin defined defined_expr eval eval_expr expid
syn keyword gclBuiltin far_value filedir filter fingerprint flatten fmt
syn keyword gclBuiltin get get_objects getcwd getenv glob has_attribute
syn keyword gclBuiltin has_key head isdir isfile items join keys len
syn keyword gclBuiltin listdir lookup map maptuple match mkmap mktuple
syn keyword gclBuiltin myfilename objectid objtype real_username
syn keyword gclBuiltin reduce replace split stringhash substr tail
syn keyword gclBuiltin values walltime

if version >= 508 || !exists("did_gcl_syn_inits")
  if version <= 508
    let did_gcl_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  " The default methods for highlighting.  Can be overridden later
  HiLink gclKeyword            Keyword
  HiLink gclConstant           Constant
  HiLink gclProperty           StorageClass
  HiLink gclInclude            Include
  HiLink gclComment            Comment
  HiLink gclTodo               Todo
  HiLink gclObjectKeyword      Keyword
  HiLink gclObjectName         Function
  HiLink gclSection            Identifier
  HiLink gclAttribute          Typedef
  HiLink gclString             String
  HiLink gclRawStr             String
  HiLink gclEscape             Special
  HiLink gclExpr               Special
  HiLink gclNumber             Number
  HiLink gclRawIdent           String
  HiLink gclBuiltin            Function

  delcommand HiLink
endif

let b:current_syntax = "gcl"

" vim: ts=8
