Best vimrc for CoolCeph team, used for C/C++, Python, PHP and Go.

The design principles of coolceph vimrc is simple, green and easy. Coolceph vimrc is designed running well on Linux and Mac, just need ctags, git and powerline_fonts. And also coolceph vimrc can be copied and installed anywhere by just a tarball.

Enjoy it.

![alt tag](https://raw.github.com/coolceph/vimrc/master/screenshot-2.png)

# Requirements

* Vim/MacVim 7.4.1578 or newer with Python 2 or Python 3 support. If :echo has("python") returns 1, then you're done; otherwise, Mac OSX see below.

```
brew install vim
brew install macvim
```

* Ctags

# Install

* vimrc will install to ~/.vim, require ~/.vim does not exist.

```
bash -c "$( curl https://raw.githubusercontent.com/coolceph/vimrc/master/setup.sh )"
```

# ShortCuts

| Key            | Function                                            |
| -------------- | --------------------------------------------------- |
| F2             | Paste mode toggle(normal/paste)                     |
| F3             | NerdTREE toggle                                     |
| F4             | Tagbar toggle                                       |
| F5             | LineNumber Model Switch                             |
| F6             | Whether or not show listchar                        |
| F7             | Update ctags                                        |
| F8             | Open undotree                                       |
| F9             | Enter multi-cursor-mode                             |
| F10            | Enter Rankring clipboard                            |
| F12            | Mouse mode switch (mouse=a/-a)                      |
| SpaceSpace     | Activate CtrlP Mixed Search                         |
| Ctrl+h/j/k/l   | Switch between windows.                             |
| Ctrl+c         | Completely quit vim without saving                  |

The leader key is ','.

# Quick Commands

| Cmd     | Function                     |
| ------- | ---------------------------- |
| Ctags   | Genrate ctags for pwd        |
| Gotags  | Genrate gotags for pwd       |
| Cscope  | Genrate cscope files for pwd |
| Hex/Asc | Swtich between Asc and Hex   |
| Hexmode | Toggle Hex/Asc mode          |
| Cswp    | Clear swp files              |

# FAQ

- *How should I install vimrc on a Linux server with no internet*

    Vim version 7.4+ is needed on your Linux server, then the steps:

    1) You need install vimrc on a Mac/Linux with internet first.

    2) Then run "~/.vim/setup.sh -b", a "vimrc-2016xxxx-mini.tar.gz" file will appear in your ~ dir.

    3) Copy the "vimrc-2016xxxx-mini.tar.gz" to your user's home dir on Linux server.

    4) Run "cd ~;rm -rf ~/.vim;tar -zxvf vimrc-2016xxxx-mini.tar.gz;.vim/setup.sh -l"

    You now get full-featured vimrc on your Linux server.

- *My state line has strange characters*

    You should install the powerline fonts into your system and update the config of your terminal to use powerline fonts to display the Non-ASCII characters.

    In the fonts dir, there is some powerline fonts you could choose.

    You could found more powerline fonts in [powerline_fonts]

    Remarks: 1. The SourceCodePro-Regular.otf contains all unicode character and new powerline glyphs. If you use a font that not contains powerline glyphs, you could setup your iTerm to use a different font for Non-ASCII text to use SourceCodePro-Regular.
             2. The Menlo-OldPowerline.otf contains old powerline glyphs, installing it will make old powerline display correct on Mac OSX.
             3. The SFMono is licensed to registered third-party developers for the design and development of applications for iOS, macOS and watchOS, please note that it is forbidden to use this typeface for your commercial project.

- *My vim is ugly, it seems some color are missing*

    You should set your env TERM=xterm-256color, you can do this by the following two ways:

    1) run ~/.vim/install.sh, it will set TERM to xterm-256color for bash/zsh. If you use other shells, you need to set TERM yourself.

    2) Your terminal util like iterm is also needed to set for xterm-256color too. You need set it yourself too.

- *MacVim Caught deadly signal SEGV*

    If you install macvim from brew, when you running mvim, you may seee "Caught deadly signal SEGV".

    The reason is brew macvim use the wrong python.

    To solve this problem, we suggest you download MacVim from [http://macvim-dev.github.io/macvim/]


    But after install from [http://macvim-dev.github.io/macvim/], if you also installed python3 on your Mac OS, this MacVim is going to have some new problem of python3.

    To solve this problem, if you want use MacVim with python2.7, just add this config in your ~/.vimrc file:

    ```
    if has('gui_macvim')
        let $PYTHONHOME="/usr/local/Frameworks/Python.framework/Versions/2.7"
    endif
    ```

    Or if you want use MacVim with python3.6:

    1.Compile YouCompleteMe using python3:

    ```
    cd ~/.vim/bundle/YouCompleteMe
    python3 ./install.py --all
    ```

    2.Add this config in your ~/.vimrc file:

    ```
    if has('gui_macvim')
        let $PYTHONHOME="/usr/local/Frameworks/Python.framework/Versions/3.6"
    endif
    ```

    The PYTHONHOME dir is like:
    ```
    Headers   Python    Resources bin       include   lib       share
    ```

# Plugins used in CoolCeph vimrc

[YCM-Generator]

[YankRing.vim]

[YouCompleteMe]

[a.vim]

[ack.vim]

[ag.vim]

[better-indent-support-for-php-with-html]

[csv.vim]

[ctrlp.vim]

[fzf.vim]

[fzf]

[gv.vim]

[hexmode]

[incsearch-easymotion.vim]

[incsearch-fuzzy.vim]

[incsearch.vim]

[indentLine]

[jellybeans.vim]

[molokai]

[neomru.vim]

[nerdcommenter]

[nerdtree-git-plugin]

[nerdtree]

[rainbow]

[rust.vim]

[syntastic]

[tabular]

[tagbar]

[tern_for_vim]

[ultisnips]

[undotree]

[vim-airline-themes]

[vim-airline]

[vim-better-whitespace]

[vim-cpp-enhanced-highlight]

[vim-easymotion]

[vim-exchange]

[vim-expand-region]

[vim-fugitive]

[vim-gitgutter]

[vim-go]

[vim-indexed-search]

[vim-json]

[vim-multiple-cursors]

[vim-operator-user]

[vim-pasta]

[vim-pathogen]

[vim-plist]

[vim-repeat]

[vim-signature]

[vim-snippets]

[vim-surround]

[vim-table-mode]

[vim-template]

[vim-tmux-navigator]

[vim-togglemouse]

[vim-togglenumber]

[vim-visual-star-search]


[YCM-Generator]:https://github.com/rdnetto/YCM-Generator
[YankRing.vim]:https://github.com/vim-scripts/YankRing.vim
[YouCompleteMe]:https://github.com/Valloric/YouCompleteMe
[a.vim]:https://github.com/vim-scripts/a.vim
[ack.vim]:https://github.com/mileszs/ack.vim
[ag.vim]:https://github.com/rking/ag.vim
[better-indent-support-for-php-with-html]:https://github.com/captbaritone/better-indent-support-for-php-with-html
[csv.vim]:https://github.com/chrisbra/csv.vim
[ctrlp.vim]:https://github.com/ctrlpvim/ctrlp.vim
[fzf.vim]:https://github.com/junegunn/fzf.vim
[fzf]:https://github.com/junegunn/fzf
[gv.vim]:https://github.com/junegunn/gv.vim
[hexmode]:https://github.com/fidian/hexmode
[incsearch-easymotion.vim]:https://github.com/haya14busa/incsearch-easymotion.vim
[incsearch-fuzzy.vim]:https://github.com/haya14busa/incsearch-fuzzy.vim
[incsearch.vim]:https://github.com/haya14busa/incsearch.vim
[indentLine]:https://github.com/Yggdroot/indentLine
[jellybeans.vim]:https://github.com/nanotech/jellybeans.vim
[molokai]:https://github.com/tomasr/molokai
[neomru.vim]:https://github.com/Shougo/neomru.vim
[nerdcommenter]:https://github.com/scrooloose/nerdcommenter
[nerdtree-git-plugin]:https://github.com/Xuyuanp/nerdtree-git-plugin
[nerdtree]:https://github.com/scrooloose/nerdtree
[rainbow]:https://github.com/luochen1990/rainbow
[rust.vim]:https://github.com/rust-lang/rust.vim
[syntastic]:https://github.com/vim-syntastic/syntastic
[tabular]:https://github.com/godlygeek/tabular
[tagbar]:https://github.com/majutsushi/tagbar
[tern_for_vim]:https://github.com/ternjs/tern_for_vim
[ultisnips]:https://github.com/SirVer/ultisnips
[undotree]:https://github.com/mbbill/undotree
[vim-airline-themes]:https://github.com/vim-airline/vim-airline-themes
[vim-airline]:https://github.com/vim-airline/vim-airline
[vim-better-whitespace]:https://github.com/ntpeters/vim-better-whitespace
[vim-cpp-enhanced-highlight]:https://github.com/octol/vim-cpp-enhanced-highlight
[vim-easymotion]:https://github.com/easymotion/vim-easymotion
[vim-exchange]:https://github.com/tommcdo/vim-exchange
[vim-expand-region]:https://github.com/terryma/vim-expand-region
[vim-fugitive]:https://github.com/tpope/vim-fugitive
[vim-gitgutter]:https://github.com/airblade/vim-gitgutter
[vim-go]:https://github.com/fatih/vim-go
[vim-indexed-search]:https://github.com/henrik/vim-indexed-search
[vim-json]:https://github.com/elzr/vim-json
[vim-multiple-cursors]:https://github.com/terryma/vim-multiple-cursors
[vim-operator-user]:https://github.com/kana/vim-operator-user
[vim-pasta]:https://github.com/sickill/vim-pasta
[vim-pathogen]:https://github.com/tpope/vim-pathogen
[vim-plist]:https://github.com/darfink/vim-plist
[vim-repeat]:https://github.com/tpope/vim-repeat
[vim-signature]:https://github.com/kshenoy/vim-signature
[vim-snippets]:https://github.com/honza/vim-snippets
[vim-surround]:https://github.com/tpope/vim-surround
[vim-table-mode]:https://github.com/dhruvasagar/vim-table-mode
[vim-template]:https://github.com/aperezdc/vim-template
[vim-tmux-navigator]:https://github.com/christoomey/vim-tmux-navigator
[vim-togglemouse]:https://github.com/nvie/vim-togglemouse
[vim-togglenumber]:https://github.com/tkhoa2711/vim-togglenumber
[vim-visual-star-search]:https://github.com/bronson/vim-visual-star-search
[http://macvim-dev.github.io/macvim/]:http://macvim-dev.github.io/macvim/
