call plug#begin('~/.vim/plugged')

" surround.vim : テキストを括弧で囲む／削除する
Plug 'tpope/vim-surround'

" repeat.vim：surround.vimなどを"."で繰り返し出来るようにする
Plug 'tpope/vim-repeat'

" vim-operator-user : 簡単にoperatorを定義できるようにする
Plug 'kana/vim-operator-user'

" operator-replace : yankしたものでreplaceする
Plug 'kana/vim-operator-replace'

" textobj-user : 簡単にVimエディタのテキストオブジェクトをつくれる
Plug 'textobj-user'

" vim-textobj-entire : buffer全体をtext-objectに
Plug 'textobj-entire'

" vim-textobj-multiblock：カッコ系をまとめてib, abで扱う
Plug 'osyo-manga/vim-textobj-multiblock'

" vim-textobj-between：任意の文字で囲まれた範囲をtext-objectに
Plug 'thinca/vim-textobj-between'

" vim-textobj-indent：同階層のインデント部分をtext-objectに
Plug 'kana/vim-textobj-indent'

" vimproc：非同期処理
Plug 'Shougo/vimproc.vim', { 'dir': '~/.vim/plugged/vimproc.vim', 'do': 'make' }

" speeddating-vim：C-a, C-xの対象を拡張
Plug 'tpope/vim-speeddating'

" vim-fugitive：vimからgit操作をできるようにする
Plug 'tpope/vim-fugitive'

" vim-slime：vim上のテキストをscreen/tmuxセッションに送る
Plug 'jpalardy/vim-slime'

" incsearch.vim：検索を便利に
Plug 'haya14busa/incsearch.vim'

" vim-asterisk：*検索を便利に
Plug 'haya14busa/vim-asterisk'

" recognize_charcode：文字エンコーディングを自動判別
Plug 'banyan/recognize_charcode.vim'

" vim-quickhl：キーワードをハイライトする
Plug 't9md/vim-quickhl'

" vim-migemo：migemo
Plug 'haya14busa/vim-migemo'

" yankround.vim：副作用のないYankRing
Plug 'LeafCage/yankround.vim'

" dispatch.vim：非同期処理
Plug 'tpope/vim-dispatch'

Plug 'basyura/TweetVim'
Plug 'mattn/webapi-vim'
Plug 'basyura/twibill.vim'
Plug 'tyru/open-browser.vim'
Plug 'basyura/bitly.vim'

call plug#end()
