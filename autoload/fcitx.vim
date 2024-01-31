" vim:set sts=2 sw=2 tw=0 et:
"
" autoload/fcitx.vim - fcitx controll plugin autoload part

scriptencoding utf-8

function! s:sockname()
  " TODO: make this configurable and flexible
  return 'unix:/tmp/fcitx-socket-:0'
endfunction

function! s:sockopen()
  return ch_open(s:sockname(), { 'mode': 'raw' })
endfunction

function! fcitx#get()
  let h = s:sockopen()
  call ch_sendraw(h, 0z00.00.00.00)
  let status = ch_readblob(h)
  call ch_close(h)
  return status == 0z02.00.00.00
endfunction

function! fcitx#set(active)
  let h = s:sockopen()
  if a:active
    let d = 0z01.00.01.00
  else
    let d = 0z01.00.00.00
  endif
  call ch_sendraw(h, d)
  call ch_close(h)
endfunction

function! fcitx#setup()
  setglobal imactivatefunc=fcitx#set
  setglobal imstatusfunc=fcitx#get
endfunction
