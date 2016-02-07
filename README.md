Best vimrc for CoolCeph team, used for C/C++, Python, PHP and Go.

Enjoy it.

![alt tag](https://raw.github.com/coolceph/vimrc/master/screenshot-2.png)

# Install

```
git clone https://github.com/coolceph/vimrc.git ~/.vim
cd ~/.vim && ./install.sh
```

# ShortCuts

F2           : Paste Model Switch

F3           : NerdTREE Switch

F4           : Tagbar Switch

F5           : LineNumber Model Switch

F6           : Whether Show Special Characters Such as Enter,Tab

F7           : Update ctags

F8           : Open undotree

F9           : Enter multi cursor mode

F12          : Mouse Model Switch (all or none)

SpaceSpace   : Activate Unite Search Plugin

Ctrl+n/p     : Switch between buffers.

Ctrl+h/j/k/l : Switch between windows.

Ctrl+c       : Quit vim without saving

The leader key is ','.

# Quick Commands

Ctags   : Genrate ctags for pwd

Gotags  : Genrate gotags for pwd

Hex/Asc : Swtich between Asc and Hex

Cswp    : Clear *.swp

# FAQ

- *My state line has strange characters*

    You should install the powerline fonts into your system and update the config of your terminal to use powerline fonts to display the Non-ASCII characters.

    In the fonts dir, there is some powerline fonts you could choose.

- *My vim is ugly, it seems some color are missing*

    You should set your env TERM=xterm-256color, you can do this by the following two ways:

    1) run ~/.vim/install.sh, it will set TERM to xterm-256color for bash/zsh. If you use other shells, you need to set TERM yourself.

    2) Your terminal util like iterm is also needed to set for xterm-256color too. You need set it yourself too.

# Plugins used in CoolCeph vimrc

[STL-Syntax]

[ack.vim]

[ag.vim]

[csv.vim]

[jellybeans.vim]

[neocomplcache.vim]

[neomru.vim]

[neosnippet-snippets]

[neosnippet.vim]

[nerdcommenter]

[nerdtree]

[papercolor-theme]

[rainbow_parentheses.vim]

[tabular]

[tagbar]

[tagbar-phpctags.vim]

[taghighlight]

[undotree]

[unite.vim]

[vim-airline]

[vim-airline-themes]

[vim-colors-solarized]

[vim-easymotion]

[vim-fugitive]

[vim-gitgutter]

[vim-go]

[vim-indexed-search]

[vim-multiple-cursors]

[vim-pathogen]

[vim-signature]

[vim-togglemouse]

[vim-togglenumber]

[vimproc.vim]

[vimshell.vim]

[vim-expand-region]

[vim-trailing-whitespace]

[STL-Syntax]:https://github.com/Mizuchi/STL-Syntax
[ack.vim]:https://github.com/mileszs/ack.vim
[ag.vim]:https://github.com/rking/ag.vim
[csv.vim]:https://github.com/chrisbra/csv.vim
[jellybeans.vim]:https://github.com/nanotech/jellybeans.vim
[neocomplcache.vim]:https://github.com/Shougo/neocomplcache.vim
[neomru.vim]:https://github.com/Shougo/neomru.vim
[neosnippet-snippets]:https://github.com/Shougo/neosnippet-snippets
[neosnippet.vim]:https://github.com/Shougo/neosnippet.vim
[nerdcommenter]:https://github.com/scrooloose/nerdcommenter
[nerdtree]:https://github.com/scrooloose/nerdtree
[papercolor-theme]:https://github.com/NLKNguyen/papercolor-theme
[rainbow_parentheses.vim]:https://github.com/kien/rainbow_parentheses.vim
[tabular]:https://github.com/godlygeek/tabular
[tagbar]:https://github.com/majutsushi/tagbar
[tagbar-phpctags.vim]:https://github.com/vim-php/tagbar-phpctags.vim
[taghighlight]:https://github.com/abudden/taghighlight-automirror
[undotree]:https://github.com/mbbill/undotree
[unite.vim]:https://github.com/Shougo/unite.vim
[vim-airline]:https://github.com/bling/vim-airline
[vim-airline-themes]:https://github.com/vim-airline/vim-airline-themes
[vim-colors-solarized]:https://github.com/altercation/vim-colors-solarized
[vim-easymotion]:https://github.com/easymotion/vim-easymotion
[vim-fugitive]:https://github.com/tpope/vim-fugitive
[vim-gitgutter]:https://github.com/airblade/vim-gitgutter
[vim-go]:https://github.com/fatih/vim-go
[vim-indexed-search]:https://github.com/henrik/vim-indexed-search
[vim-multiple-cursors]:https://github.com/terryma/vim-multiple-cursors
[vim-pathogen]:https://github.com/tpope/vim-pathogen
[vim-signature]:https://github.com/kshenoy/vim-signature
[vim-togglemouse]:https://github.com/nvie/vim-togglemouse
[vim-togglenumber]:https://github.com/tkhoa2711/vim-togglenumber
[vimproc.vim]:https://github.com/Shougo/vimproc.vim.git
[vimshell.vim]:https://github.com/Shougo/vimshell.vim
[vim-expand-region]://github.com/terryma/vim-expand-region
[vim-trailing-whitespace]:https://github.com/bronson/vim-trailing-whitespace

