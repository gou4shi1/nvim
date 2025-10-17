function! coc#source#codecompanion#init() abort
  if exists('*v:lua.codecompanion_coc_init')
    return v:lua.codecompanion_coc_init()
  endif
  return {}
endfunction

function! coc#source#codecompanion#complete(opt, cb) abort
  if exists('*v:lua.codecompanion_coc_complete')
    return a:cb(v:lua.codecompanion_coc_complete(a:opt))
  endif
  return a:cb([])
endfunction

function! coc#source#codecompanion#on_complete(opt) abort
  if exists('*v:lua.codecompanion_coc_execute')
    return v:lua.codecompanion_coc_execute(a:opt)
  endif
  return v:null
endfunction
