#/bin/sh
git submodule init
git submodule update

cd ~/.vim/bundle/vimproc.vim/
make
cd ~

unlink ~/.vimrc
ln -s ~/.vim/vimrc ~/.vimrc
echo "Init OK"

