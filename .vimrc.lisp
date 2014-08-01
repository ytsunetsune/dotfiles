" ------------------------------------------------------------------------------
" NeoBundleで管理しているプラグイン読み込み
" ------------------------------------------------------------------------------

" lispモードのカッコを色分けする
let g:lisp_rainbow = 1

" slimvの設定
let g:slimv_lisp='~/.local/bin/ccl64'
let g:slimv_impl = 'clozure'
let g:slimv_preferred = 'clozure'
let g:slimv_swank_cmd = '! xterm -e ccl64 --load ~/.vim/bundle/slimv/slime/start-swank.lisp &' 

