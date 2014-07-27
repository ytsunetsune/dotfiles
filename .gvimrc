" OS settings
if has('win32') || has('win64')
    " Windowsの場合の処理
    source $VIMRUNTIME/delmenu.vim
    set langmenu=ja_jp.utf-8
    source $VIMRUNTIME/menu.vim
    set guifont=Ricty:h12
else
    " Windows以外の場合の処理
    set guifont=Ricty\ 12
endif

colorscheme solarized
set background=dark
