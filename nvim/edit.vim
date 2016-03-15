set showmatch " 括弧の対応をハイライト
set matchtime=1 " showmatchのハイライト時間を0.1秒にする
set number
set list " 不可視文字表示
set listchars=tab:>.,trail:_,extends:>,precedes:< " 不可視文字の表示形式
set display=uhex " 印字不可能文字を16進数で表示
set cmdheight=2
set laststatus=2
set display=lastline

" 全角スペースの表示
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
match ZenkakuSpace /　/

" カーソル行をハイライト
set cursorline
" カレントウィンドウにのみ罫線を引く
augroup cch
  autocmd! cch
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END

hi clear CursorLine
hi CursorLine gui=underline
highlight CursorLine ctermbg=black guibg=black

" コマンド実行中は再描画しない
set lazyredraw

let mapleader = "," " キーマップリーダー
set scrolloff=3 " スクロール時の余白確保
set textwidth=0 " 一行に長い文章を書いていても自動折り返しをしない
set nobackup " バックアップ取らない
set autoread " 他で書き換えられたら自動で読み直す
set noswapfile " スワップファイル作らない
set hidden " 編集中でも他のファイルを開けるようにする
set backspace=indent,eol,start " バックスペースでなんでも消せるように
set formatoptions=lmoq " テキスト整形オプション，マルチバイト系を追加
set vb t_vb= " ビープをならさない
set browsedir=buffer " Exploreの初期ディレクトリ
set whichwrap=b,s,h,l,<,>,[,] " カーソルを行頭、行末で止まらないようにする
set showcmd " コマンドをステータス行に表示
set showmode " 現在のモードを表示
set viminfo='50,<1000,s100,\"50 " viminfoファイルの設定
set modelines=0 " モードラインは無効
set notitle " vimを使ってくれてありがとう
set nrformats-=octal
if has('persistent_undo')
  set undodir=~/.vim/undo
  set undofile
endif

" 保存時にsudo権限で無理やり保存
cnoremap w!! w !sudo tee > /dev/null %<CR>

" 保存先のディレクトリがなければ確認の上作成する
augroup vimrc-auto-mkdir  " \{\{\{
  autocmd!
  autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
  function! s:auto_mkdir(dir, force)  " \{\{\{
    if !isdirectory(a:dir) && (a:force ||
    \    input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
      call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
  endfunction  " \}\}\}
augroup END  " \}\}\}

" insertモードを抜けるとIMEオフ
set noimdisable
set iminsert=0 imsearch=0
set noimcmdline
inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>

" Yは行末までヤンク（DやCの動きと対応する動き）
nnoremap Y y$

" スペルチェッカの設定
set spelllang=en,cjk
nnoremap <silent> ,s :set spell!<CR>

set autoindent " 自動でインデント
set smartindent " 新しい行を開始したときに、新しい行のインデントを現在行と同じ量にする。
set cindent " Cプログラムファイルの自動インデントを始める

" softtabstopはTabキー押し下げ時の挿入される空白の量，0の場合はtabstopと同じ，BSにも影響する
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab

if has("autocmd")
  "ファイルタイプの検索を有効にする
  filetype plugin on
  "そのファイルタイプにあわせたインデントを利用する
  filetype indent on
  " これらのftではインデントを無効に
  "autocmd FileType php filetype indent off

  autocmd FileType c setlocal sw=4 sts=4 ts=4 et
  autocmd FileType cpp setlocal sw=4 sts=4 ts=4 et
  autocmd FileType diff setlocal sw=4 sts=4 ts=4 et
  autocmd FileType html setlocal sw=2 sts=2 ts=2 et
  autocmd FileType java setlocal sw=4 sts=4 ts=4 et
  autocmd FileType javascript setlocal sw=2 sts=2 ts=2 et
  autocmd FileType perl setlocal sw=4 sts=4 ts=4 et
  autocmd FileType php setlocal sw=4 sts=4 ts=4 et
  autocmd FileType python setlocal sw=4 sts=4 ts=4 et
  autocmd FileType ruby setlocal sw=2 sts=2 ts=2 et
  autocmd FileType haml setlocal sw=2 sts=2 ts=2 et
  autocmd FileType sh setlocal sw=4 sts=4 ts=4 et
  autocmd FileType vim setlocal sw=2 sts=2 ts=2 et
  autocmd FileType zsh setlocal sw=4 sts=4 ts=4 et
  autocmd FileType lisp setlocal sw=2 sts=2 ts=2 et
  autocmd FileType mkd setlocal sw=4 sts=4 ts=4 et
endif

" ファイルタイプ判定をon
filetype plugin indent on
syntax on

