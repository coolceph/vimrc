# |------------------------|
# |    Coolceph VIMRC      |
# |------------------------|
# |           _            |
# |   __   __(_)___ ___    |
# |   | | / / / __ `__ \   |
# |   | |/ / / / / / / /   |
# |   |___/_/_/ /_/ /_/    |
# |                        |
# |------------------------|
#
# | ---------------------- | ---------------------- |
# | vimrc安装脚本          |                        |
# | ---------------------- | ---------------------- |
# | 说明                   |                        |
# | ---------------------- | ---------------------- |
# | vim_path               | vimrc安装目录的父目录  |
# | vim_dir                | vimrc安装目录名        |
# | ---------------------- | ---------------------- |
vim_path=.vim
vim_dir=$HOME

#setup.sh start here, do not modify
vim_fullpath=$vim_dir/$vim_path        # vimrc安装到的目录
vim_init_file=$vim_fullpath/vimrc.init # vimrc标志文件，记录安装的日期
vim_pwd=$PWD

color_print() {
    printf '\033[0;31m%s\033[0m\n' "$1"
}

warn() {
    color_print "$1" >&2
}

die() {
    warn "$1"
    exit 1
}

logo() {
    color_print "Thank you for installing vimrc!"
    color_print '            _         '
    color_print '    __   __(_)___ ___ '
    color_print '    | | / / / __ `__ \'
    color_print '    | |/ / / / / / / /'
    color_print '    |___/_/_/ /_/ /_/ '
    color_print '                      '
}

require() {
    color_print "Checking requirements for vimrc..."
    color_print "Checking vim version..."
    vim --version | grep 7.[4-9] || die "Your vim's version is too low!\nPlease download higher version(7.4+) from http://www.vim.org/download.php"
    color_print "Checking if git exists..."
    which git || die "No git installed!\nPlease install git from http://git-scm.com/downloads/"
    color_print "Check if ctags exists..."
    which ctags || warn "No ctags installed!\nPlease install ctags form http://ctags.sourceforge.net/ after vimrc intallation!"
}

help() {
    echo "setup.sh -- setup vimrc"
    echo "Usage: setup.sh -i/-u/-b/-l"
    echo "-i -- install vimrc"
    echo "-u -- update vimrc's plugins"
    echo "-b -- backup ~/.vim"
    echo "-l -- link ~/.vim/vimrc to ~/.vimrc and make vim-proc, for green install from tar.gz"
    exit 0
}

make_vimproc() {
    cd $vim_fullpath/bundle/vimproc.vim/
    make
    cd $vim_pwd
    color_print "Make vimproc.vim finished"
}

make_vimrc() {
    if [ -L $HOME/.vimrc ]; then
        unlink $HOME/.vimrc
    fi
    if [ -f $HOME/.vimrc ]; then
        /bin/rm -f $HOME/.vimrc
    fi
    echo "source $vim_fullpath/vimrc" > $HOME/.vimrc
    color_print "Make vimrc finished"
}

close_powerline_fonts() {
    echo "let g:airline_powerline_fonts = 0" >> $HOME/.vimrc
    color_print "Close powerline fonts"
}

backup_vimrc() {
    cd $vim_dir
    backup_date=`date +%Y%m%d`
    color_print $backup_date
    tar --exclude .git -czvf vimrc-$backup_date-mini.tar.gz $vim_path/bundle $vim_path/vimrc $vim_path/setup.sh
    cd $vim_pwd
    color_print "Backup Finished "$backup_date
}

check_term() {
    if [ x$TERM != x"xterm-256color" ]
    then
        color_print "TERM is not xterm-256color, will set TERM=xterm-256color now"

        is_zsh=`color_print $SHELL|grep 'zsh'|wc -l`
        is_bash=`color_print $SHELL|grep 'bash'|wc -l`

        if [ $is_zsh -eq 1 ]
        then
            color_print "Your shell is zsh, set TERM in ~/.zshrc"
            echo "export TERM=xterm-256color" >> ~/.zshrc
            color_print "Set TERM OK, please execute:"
            color_print "    source ~/.zshrc"
        elif [ $is_bash -eq 1 ]
        then
            color_print "Your shell is bash, set TERM in ~/.bash_profile"
            echo "export TERM=xterm-256color" >> ~/.bash_profile
            color_print "Set TERM OK, please execute:"
            color_print "    source ~/.bash_profile"
        else
            color_print "Your shell cannot set TERM automatically, please set TERM to xterm-256color by yourself"
        fi
    else
        color_print "TERM is xterm-256color, OK"
    fi
}

check_lang() {
    if [ x$LANG != x"en_US.UTF-8" ]
    then
        color_print "LANG is not en_US.UTF-8, will set LANG=en_US.UTF-8"

        is_zsh=`color_print $SHELL|grep 'zsh'|wc -l`
        is_bash=`color_print $SHELL|grep 'bash'|wc -l`

        if [ $is_zsh -eq 1 ]
        then
            color_print "Your shell is zsh, set LANG in ~/.zshrc"
            echo "export LANG=en_US.UTF-8" >> ~/.zshrc
            color_print "Set LANG OK, please execute:"
            color_print "    source ~/.zshrc"
        elif [ $is_bash -eq 1 ]
        then
            color_print "Your shell is bash, set LANG in ~/.bash_profile"
            echo "export LANG=en_US.UTF-8" >> ~/.bash_profile
            color_print "Set LANG OK, please execute:"
            color_print "    source ~/.bash_profile"
        else
            color_print "Your shell cannot set LANG automatically, please set LANG to xterm-256color by yourself"
        fi
    else
        color_print "LANG is en_US.UTF-8, OK"
    fi

    if [ x$LC_ALL != x"en_US.UTF-8" ]
    then
        color_print "LC_ALL is not en_US.UTF-8, will set LC_ALL=en_US.UTF-8"

        is_zsh=`color_print $SHELL|grep 'zsh'|wc -l`
        is_bash=`color_print $SHELL|grep 'bash'|wc -l`

        if [ $is_zsh -eq 1 ]
        then
            color_print "Your shell is zsh, set LC_ALL in ~/.zshrc"
            echo "export LC_ALL=en_US.UTF-8" >> ~/.zshrc
            color_print "Set LC_ALL OK, please execute:"
            color_print "    source ~/.zshrc"
        elif [ $is_bash -eq 1 ]
        then
            color_print "Your shell is bash, set LC_ALL in ~/.bash_profile"
            echo "export LC_ALL=en_US.UTF-8" >> ~/.bash_profile
            color_print "Set LC_ALL OK, please execute:"
            color_print "    source ~/.bash_profile"
        else
            color_print "Your shell cannot set LC_ALL automatically, please set LC_ALL to xterm-256color by yourself"
        fi
    else
        color_print "LC_ALL is en_US.UTF-8, OK"
    fi
}

install() {
    color_print "Start install"

    git clone https://github.com/coolceph/vimrc $vim_fullpath;
    if [ $? -eq 0 ]; then
        cd $vim_fullpath
        git submodule init
        git submodule update
        cd $vim_pwd
        color_print "All plugins init finished!"
    else
        echo $?
        color_print "Install failed! "
        exit -1
    fi
}

update() {
    cd $vim_fullpath
    git pull
    git submodule update
    color_print "Update finished!"
    cd $vim_pwd
}

if [ $# -ne 1 ]; then
    logo
    require
    check_term
    check_lang
    install
    make_vimproc
    make_vimrc
    help
fi

while getopts ":iubln" opts; do
    case $opts in
        i)
            logo
            require
            check_term
            check_lang
            install
            make_vimproc
            make_vimrc
            ;;
        u)
            logo
            require
            update
            ;;
        b)
            logo
            backup_vimrc
            ;;
        l)
            logo
            require
            check_term
            check_lang
            make_vimproc
            make_vimrc
            ;;
        n)
            logo
            check_term
            check_lang
            make_vimproc
            make_vimrc
            close_powerline_fonts
            ;;
        :)
            help;;
        ?)
            help;;
    esac
done
