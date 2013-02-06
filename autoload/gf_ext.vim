" gf-ext.vim - Extend "gf" to open files with external programs
" Author: Daniel P. Wright (http://dpwright.com)

" Globals {{{1
let g:gf_ext_file_handlers = []
" }}}1

function! gf_ext#run_handler_for_file(file, count)
  if empty(a:file)
    " Todo use localised error messages
    echoerr "E446: No file name under cursor"
  else
    let candidates = findfile(a:file, "", -1)
    let idx = a:count == 0 ? 0 : a:count - 1
    if len(candidates) > idx
      let path = candidates[idx]
      let handled = 0
      for handler in g:gf_ext_file_handlers
        if !empty(matchstr(path, handler["match"]))
          exe handler["handler"] . " " . path
          let handled = 1
          break
        endif
      endfor

      if !handled
        exe "normal! gf"
      endif
    elseif len(candidates) == 0
      echoerr "E447: Can't find file \"" . a:file . "\" in path"
    else
      echoerr "E347: No more file " . a:file . " found in path"
    endif
  endif
endfunction

function! gf_ext#add_handler(filepattern, handler)
  let handler = {"match": a:filepattern, "handler": a:handler}
  call add(g:gf_ext_file_handlers, handler)
endfunction

" vim:set et sw=2:
