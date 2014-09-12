#!/bin/sh

key=$1

clone(){
cd ~/.local/src
echo "current directory: `pwd`"
git clone https://github.com/rkitover/vimpager.git
git clone https://github.com/ggreer/the_silver_searcher.git
wget -O - https://github.com/peco/peco/releases/download/v0.2.8/peco_linux_386.tar.gz | tar xf -
return 0
}

agmake(){
cd ~/.local/src/the_silver_searcher
echo "current directory: `pwd`"
./build.sh
sudo make install
}

link(){
cd ~/.local/bin
echo "current directory: `pwd`"
ln -s ~/.local/src/vimpager/vimpager .
ln -s ~/.local/src/the_silver_searcher/ag .
ln -s ~/.local/src/peco_linux_386/peco .
}

case "$key" in
    "all" ) clone; agmake; link ;;
    "clone" ) clone ;;
    "agmake" ) agmake ;;
    "link" ) link ;;
esac
