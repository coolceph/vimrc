cd ~/vimrc/bundle/vimproc.vim/
make
cd ~
unlink ~/.vimrc
ln -s ~/vimrc/vimrc ~/.vimrc

if [ x$TERM != x"xterm-256color" ]
then
    echo "TERM is not xterm-256color, will set TERM=xterm-256color now"

    is_zsh=`echo $SHELL|grep 'zsh'|wc -l`
    is_bash=`echo $SHELL|grep 'bash'|wc -l`

    if [ $is_zsh -eq 1 ]
    then
        echo "Your shell is zsh, set TERM in ~/.zshrc"
        echo "export TERM=xterm-256color" >> ~/.zshrc
        echo "Set TERM OK, please execute:"
        echo "    source ~/.zshrc"
    elif [ $is_bash -eq 1 ]
    then
        echo "Your shell is bash, set TERM in ~/.bash_profile"
        echo "export TERM=xterm-256color" >> ~/.bash_profile
        echo "Set TERM OK, please execute:"
        echo "    source ~/.bash_profile"
    else
        echo "Your shell cannot set TERM automatically, please set TERM to xterm-256color by yourself"
    fi

else
    echo "TERM is xterm-256color, OK"
fi

echo "Install OK"
