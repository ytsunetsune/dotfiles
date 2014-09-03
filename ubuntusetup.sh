#!/bin/sh

key=$1
INSTALL="apt-get install -y"

GEN_TOOLS="vim emacs zsh tmux terminator"
DEV_TOOLS="rlwrap automake pkg-config libpcre3-dev zlib1g-dev liblzma-dev"
TOOLS="$GEN_TOOLS $DEV_TOOLS"

PYTHON="python-setuptools"
PIP="easy_install pip"
CL="clisp"
PLANG="$PYTHON $CL"

ALL="$TOOLS $PLANG"

case "$key" in
    "all" ) $INSTALL $ALL ;;
    "tools" ) $INSTALL $TOOLS ;;
    "general" ) $INSTALL $GEN_TOOLS ;;
    "dev" ) $INSTALL $DEV_TOOLS ;;
    "lang" ) $INSTALL $PLANG ;;
    "python" ) $INSTALL $PYTHON; $PIP ;;
    "commonlisp" ) $INSTALL $CL ;;
    * ) echo "ubuntusetup all/tools(general/dev)/lang(python/commonlisp)" ;;
esac

