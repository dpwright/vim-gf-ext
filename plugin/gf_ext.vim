" gf-ext.vim - Extend "gf" to open files with external programs
" Author: Daniel P. Wright (http://dpwright.com)

if exists("g:loaded_gf_ext") || v:version < 700 || &cp
  finish
endif
let g:loaded_gf_ext = 1

noremap <silent> gf :<C-U>call gf_ext#run_handler_for_file(expand("<cfile>"),v:count)<cr>
" vim:set et sw=2:
