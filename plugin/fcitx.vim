" vim:set sts=2 sw=2 tw=0 et:
"
" plugin/fcitx.vim - fcitx controll plugin

scriptencoding utf-8

function! s:is_gui_term()
  " FIXME: Check running on GUI term (ex. xfce4-term).
  return exists('$DISPLAY')
endfunction

if has('gui_running')
  augroup FcitxPy
    autocmd!
    autocmd GUIEnter * call fcitx#setup()
  augroup END
elseif s:is_gui_term()
  call fcitx#setup()
endif
