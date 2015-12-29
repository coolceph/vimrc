#/bin/sh
git submodule init
git submodule update

cd ~/vimrc/bundle/vimproc.vim/
make
cd ~

unlink ~/.vimrc
ln -s ~/vimrc/vimrc ~/.vimrc
echo "Init OK"

