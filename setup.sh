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
    echo "Usage: setup.sh -i/-u/-b"
    echo "-i -- install vimrc"
    echo "-u -- update vimrc's plugins"
    echo "-b -- backup ~/.vim"
    exit 0
}

make_vimproc() {
    cd $vim_fullpath/bundle/vimproc.vim/
    make
    cd -
    color_print "Make vimproc.vim finished"
}

make_vimrc() {
    unlink $HOME/.vimrc
    echo "source $vim_fullpath/vimrc" > $HOME/.vimrc
    color_print "Make vimrc finished"
}

backup_vimrc() {
    cd $vim_dir
    backup_date=`date +%Y%m%d`
    color_print $backup_date
    tar --exclude .git -czvf vimrc-$backup_date-mini.tar.gz $vim_path
    tar -czvf vimrc-$backup_date-full.tar.gz $vim_path
    cd -
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

init_plugins() {
    if [ ! -d "$vim_fullpath/bundle" ]
    then
        color_print "$vim_fullpath/bundle is not existed, vimrc will create"
        mkdir -p $vim_fullpath/bundle
    else
        if [ ! -f $vim_init_file ]; then
            color_print "$vim_fullpath/bundle is existed and not created by vimrc, stop"
            exit -1
        fi
        color_print "$vim_fullpath/bundle is existed and created by vimrc, not init_plugins is needed"
        return 0
    fi

    color_print "Start init_plugins"
    cp vimrc $vim_fullpath
    cp setup.sh $vim_fullpath

    cd $vim_fullpath/bundle

    plugin_list=(
    "https://github.com/Mizuchi/STL-Syntax"
    "https://github.com/mileszs/ack.vim"
    "https://github.com/rking/ag.vim"
    "https://github.com/chrisbra/csv.vim"
    "https://github.com/nanotech/jellybeans.vim"
    "https://github.com/Shougo/neocomplcache.vim"
    "https://github.com/Shougo/neomru.vim"
    "https://github.com/Shougo/neosnippet-snippets"
    "https://github.com/Shougo/neosnippet.vim"
    "https://github.com/Shougo/vimshell.vim"
    "https://github.com/scrooloose/nerdcommenter"
    "https://github.com/scrooloose/nerdtree"
    "https://github.com/kien/rainbow_parentheses.vim"
    "https://github.com/majutsushi/tagbar"
    "https://github.com/vim-php/tagbar-phpctags.vim"
    "https://github.com/abudden/taghighlight-automirror"
    "https://github.com/mbbill/undotre"
    "https://github.com/Shougo/unite.vim"
    "https://github.com/bling/vim-airline"
    "https://github.com/easymotion/vim-easymotion"
    "https://github.com/tpope/vim-fugitive"
    "https://github.com/fatih/vim-go"
    "https://github.com/henrik/vim-indexed-search"
    "https://github.com/tpope/vim-pathogen"
    "https://github.com/kshenoy/vim-signature"
    "https://github.com/nvie/vim-togglemouse"
    "https://github.com/tkhoa2711/vim-togglenumber"
    "https://github.com/Shougo/vimproc.vim.git"
    "https://github.com/vim-airline/vim-airline-themes"
    "https://github.com/airblade/vim-gitgutter"
    "https://github.com/godlygeek/tabular"
    "https://github.com/terryma/vim-multiple-cursors"
    "https://github.com/terryma/vim-expand-region"
    "https://github.com/ntpeters/vim-better-whitespace"
    "https://github.com/tpope/vim-surround"
    "https://github.com/tpope/vim-repeat"
    "https://github.com/vim-scripts/a.vim"
    "https://github.com/tomasr/molokai"
    )

    plugin_cnt=${#plugin_list[@]}
    x=0
    for i in "${plugin_list[@]}"
    do
        let "x+=1"
        color_print "Installing [$x/$plugin_cnt] $i"
        git clone $i
    done

    init_date=`date +%Y-%m-%d\_%H:%M:%S`
    echo "init_date="$init_date > $vim_init_file
    cd -
    color_print "All plugins init finished!"
}

update_plugins() {
    cd $vim_fullpath/bundle
    x=0
    y=1

    for filename in `ls`
    do
        array[$x]=$filename
        let "x+=1"
    done

    for i in "${array[@]}"
    do
        cd $i
        color_print "Updating [$y/$x] $i"
        git pull
        cd ..
        let "y+=1"
    done

    cd -
    color_print "Update finished!"
}

if [ $# -ne 1 ]; then
    help
fi

while getopts ":iub" opts; do
    case $opts in
        i)
            logo
            require
            check_term
            init_plugins
            make_vimproc
            make_vimrc
            ;;
        u)
            logo
            require
            update_plugins
            ;;
        b)
            logo
            backup_vimrc
            ;;
        :)
            help;;
        ?)
            help;;
    esac
done
