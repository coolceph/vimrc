cd ~/.vim/bundle/vimproc.vim/
make
cd ~
unlink ~/.vimrc
ln -s ~/.vim/vimrc ~/.vimrc
echo "Install OK"

