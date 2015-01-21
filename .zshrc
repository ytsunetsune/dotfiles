#LANG
export LANG=ja_JP.UTF-8
# KEYBIND
bindkey -v
# history-search
bindkey '^p' history-beginning-search-backward
bindkey '^n' history-beginning-search-forward
# PROMPT
# PROMPT="$ "
# enable zmv
autoload -Uz zmv
alias zmv='noglob zmv -W'
#zshプロンプトにモード表示####################################
function zle-line-init zle-keymap-select {
case $KEYMAP in
    vicmd)
        PROMPT="%{$fg[red]%}[%{$reset_color%}%n@${HOST%%.*}/%{$fg_bold[red]%}NOR%{$reset_color%}%{$fg[red]%}]%#%{$reset_color%} " ;; main|viins)
        PROMPT="%{$fg[red]%}[%{$reset_color%}%n@${HOST%%.*}/%{$fg_bold[cyan]%}INS%{$reset_color%}%{$fg[red]%}]%#%{$reset_color%} "
        ;;
esac
zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select
PROMPT2="> "
SPROMPT="%r is correct? [n,y,a,e]: "
RPROMPT='[`rprompt-git-current-branch`%F{cyan}%~%f]'
RPROMPT2="%K{green}%_%k"
# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt prompt_subst
## 入力が右端まで来たらRPROMPTを消す
setopt transient_rprompt
## ${fg[...]} や $reset_color をロード
autoload -U colors; colors
function rprompt-git-current-branch {
local name st color
if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
    return
fi
name=$(basename "`git symbolic-ref HEAD 2> /dev/null`")
if [[ -z $name ]]; then
    return
fi
st=`git status 2> /dev/null`
if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    color=${fg[green]}
elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
    color=${fg[yellow]}
elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
    color=${fg_bold[red]}
else
    color=${fg[red]}
fi
echo "%{$color%}$name%{$reset_color%} "
}
# HISTORY
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
## history (fc -l) コマンドをヒストリリストから取り除く。
setopt hist_no_store
## すぐにヒストリファイルに追記する。
setopt inc_append_history
## 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_dups
## zsh の開始, 終了時刻をヒストリファイルに書き込む
setopt extended_history
## ヒストリを呼び出してから実行する間に一旦編集
setopt hist_verify
## ヒストリを共有
setopt share_history
## コマンドラインの先頭がスペースで始まる場合ヒストリに追加しない
setopt hist_ignore_space
## backspaceを有効に
bindkey "^?" backward-delete-char
# 補完
autoload -Uz compinit
compinit
# Shift-Tabで補完候補を逆順する("\e[Z"でも動作する)
bindkey "^[[Z" reverse-menu-complete
## The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'
## 補完候補を一覧表示
setopt auto_list
## TAB で順に補完候補を切り替える
setopt auto_menu
## 補完候補一覧でファイルの種別をマーク表示
setopt list_types
## カッコの対応などを自動的に補完
setopt auto_param_keys
## ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash
## 補完候補のカーソル選択を有効に
zstyle ':completion:*:default' menu select=1
## 補完候補の色づけ
eval `dircolors`
export ZLS_COLORS=$LS_COLORS
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
## 補完候補を詰めて表示
setopt list_packed
## スペルチェック
setopt correct
## ファイル名の展開でディレクトリにマッチした場合末尾に / を付加する
setopt mark_dirs
## 最後のスラッシュを自動的に削除しない
setopt noautoremoveslash
# 未分類
## コアダンプサイズを制限
limit coredumpsize 102400
## 出力の文字列末尾に改行コードが無い場合でも表示
unsetopt promptcr
## ビープを鳴らさない
setopt nobeep
## 内部コマンド jobs の出力をデフォルトで jobs -l にする
setopt long_list_jobs
## サスペンド中のプロセスと同じコマンド名を実行した場合はリジューム
setopt auto_resume
## cd 時に自動で push
setopt auto_pushd
## 同じディレクトリを pushd しない
setopt pushd_ignore_dups
## ファイル名で #, ~, ^ の 3 文字を正規表現として扱う
setopt extended_glob
## =command を command のパス名に展開する
setopt equals
## --prefix=/usr などの = 以降も補完
setopt magic_equal_subst
## ファイル名の展開で辞書順ではなく数値的にソート
setopt numeric_glob_sort
## 出力時8ビットを通す
setopt print_eight_bit
## ディレクトリ名だけで cd
setopt auto_cd
## cdr
if [[ -n $(echo ${^fpath}/chpwd_recent_dirs(N)) && -n $(echo ${^fpath}/cdr(N)) ]]; then
    autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
    add-zsh-hook chpwd chpwd_recent_dirs
    zstyle ':completion:*:*:cdr:*:*' menu selection
    zstyle ':completion:*' recent-dirs-insert both
    zstyle ':chpwd:*' recent-dirs-max 500
    zstyle ':chpwd:*' recent-dirs-default true
    zstyle ':chpwd:*' recent-dirs-file "${XDG_CACHE_HOME:-$HOME/.cache}/shell/chpwd-recent-dirs"
    zstyle ':chpwd:*' recent-dirs-pushd true
fi

## 小文字の場合大文字も候補に含める
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
## {a-c} を a b c に展開する機能を使えるようにする
setopt brace_ccl
## Ctrl+S/Ctrl+Q によるフロー制御を使わないようにする
#setopt NO_flow_control
## コマンドラインでも # 以降をコメントと見なす
#setopt interactive_comments
# PAGER
if type lv > /dev/null 2>&1; then
    ## lvを優先する。
    export PAGER="lv"
else
    ## lvがなかったらlessを使う。
    export PAGER="less"
fi
if [ "$PAGER" = "lv" ]; then
    ## -c: ANSIエスケープシーケンスの色付けなどを有効にする。
    ## -l: 1行が長くと折り返されていても1行として扱う。
    ## （コピーしたときに余計な改行を入れない。）
    export LV="-c -l"
else
    ## lvがなくてもlvでページャーを起動する。
    alias lv="$PAGER"
fi
# global aliases
alias -g T="| tee"
alias -g G="| grep"
alias -g L="|& $PAGER"
alias -g WC="| wc"
alias -g LC="| wc -l"
alias -g Z="| tail"
# 以下は.bashrcと共用
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ls='ls -alh --color'
alias vi='vim'
alias vim='vim'
alias gvim='vim -g'
# my aliases
case ${OSTYPE} in
    linux*)
        alias open='gnome-open'
        ;;
    cygwin*)
        alias open='cygstart'
        ;;
esac

alias open.='open .'
alias cp='cp -ip'
alias mv='mv -i'
# global aliases
alias -g G='| grep'
alias -g L='| vimpager'
alias -g H='| head'
alias -g T='| tail'
alias -g S='| sort'
alias -g W='| wc'
alias -g X='| xargs'
alias -g P='| peco'
# jokey git alias
alias gtat='git status'
alias gdiff='git diff'
alias glog='git log'
alias gshow='git show'
alias gadd='git add'
alias gcomi='git commit'
alias gcomm='git commit -m '
alias gbrah='git branch'
alias gcheo='git checkout'
alias gpull='git pull'
alias gpush='git push'
alias ggrep='git grep -ie'
alias gstash='git stash'
alias gstashp='git stash pop'
alias ggraph='git graph'
alias ggraphall='git graphall'
# git svn alias
alias gsreb='git svn rebase'
alias gsdco='git svn dcommit'
alias gslog='git svn log'
alias gsclo='git svn clone'
alias gsfet='git svn fetch'
# screen alias
alias sc='screen'
# OMake alias
alias omakep='omake -P --verbose'
# retter settings
export EDITOR=vim


show_buffer_stack() {
    POSTDISPLAY="
    stack: $LBUFFER"
    zle push-line-or-edit
}
zle -N show_buffer_stack
setopt noflowcontrol
bindkey '^Q' show_buffer_stack


if [[ -f ~/.my-settings; ]]; then
    . ~/.my-settings;
fi

alias alert_helper='history|tail -n1|sed -e "s/^\s*[0-9]\+\s*//" -e "s/;\s*alert$//"'
alias alert='notify-send -i /usr/share/icons/gnome/32x32/apps/gnome-character-map.png "[$?] $(alert_helper) finished."'

# agの結果を色付けを有効にしてlessに通す
alias al='ag --pager "less -R"'

# vimpager
if type vimpager > /dev/null 2>&1; then
    export PAGER=vimpager
else
    export PAGER=less
fi
alias vp=vimpager
alias emacs='emacs -nw'

function agvim () {
vim $(ag $@ | peco --query "$LBUFFER" | awk -F : '{print "-c " $2 " " $1}')
}

function todo() { ag -i todo: $@ ;}

if [[ -f ~/.nvm/nvm.sh; ]]; then
    export NVM_DIR="/home/tsuneoka/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
    nvm use stable
fi

if (which zprof > /dev/null); then
    zprof | less
fi
