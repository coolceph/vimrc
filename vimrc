"|------------------------|
"|    Coolceph VIMRC      |
"|------------------------|
"|           _            |
"|   __   __(_)___ ___    |
"|   | | / / / __ `__ \   |
"|   | |/ / / / / / / /   |
"|   |___/_/_/ /_/ /_/    |
"|                        |
"|------------------------|
"
" Maintainer:	coolceph <https://github.com/coolceph/vimrc>
" Last change:	2016.03.21
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc
"
" +----------+---------------------+
" | Key      | Function            |
" +----------+---------------------+
" | F2       | paste模式开关       |
" | F3       | NerdTREE开关        |
" | F4       | tagbar开关          |
" | F5       | 行号模式切换        |
" | F6       | 是否显示特殊字符    |
" | F7       | 更新ctags文件       |
" | F8       | 打开undotree        |
" | F9       | 进入MultiCursor模式 |
" | F10      | 打开YankRin剪贴板   |
" | F12      | 鼠标模式切换        |
" | <Ctrl+c> | 快速推出VIM(:qall!) |
" +----------+---------------------+

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

"代码缩进设置
set smarttab      "开启时，在行首按TAB将加入sw个空格，否则加入ts个空格
set tabstop=4     "编辑时一个TAB字符占多少个空格的位置
set softtabstop=4 "方便在开启了et后使用退格（backspace）键，每次退格将删除X个空格
set shiftwidth=4  "使用每层缩进的空格数
set expandtab     "是否将输入的TAB自动展开成空格。开启后要输入TAB，需要Ctrl-V<TAB>
set updatetime=250

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse-=a
endif


" Only do this part when compiled with support for autocommands.
if has("autocmd")

    " Enable file type detection.
    " Use the default filetype settings, so that mail gets 'tw' set to 72,
    " 'cindent' is on in C files, etc.
    " Also load indent files, to automatically do language-dependent indenting.
    filetype plugin indent on

    " Put these in an autocmd group, so that we can delete them easily.
    augroup vimrcEx
    au!

    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78
    autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
    autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2 softtabstop=2
    autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2
    autocmd FileType make setlocal noexpandtab
    autocmd FileType python setlocal et sta sw=4 sts=4

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost *
        \ if line("'\"") >= 1 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif

    augroup END

else

    set autoindent		" always set autoindenting on

endif " has("autocmd")

set history=1024
set number                                       " 显示行号
set autoread                                     " 文件在Vim之外修改过，自动重新读入
set showbreak=↪                                  " 显示换行符
set completeopt=longest,menuone                  " 更好的insert模式自动完成
set modeline                                     " 允许被编辑的文件以注释的形式设置Vim选项
set hidden                                       " switching buffers without saving
set ruler                                        " show the cursor position all the time
set showcmd                                      " display incomplete commands
set wildmenu                                     " show enhanced completion
set wildmode=list:longest                        " together with wildmenu
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit
set wildignore+=*.pyc                            " Python byte code
set wildignore+=*.orig                           " Merge resolution files
set visualbell                                   " flash screen when bell rings
set cursorline                                   " highline cursor line
set ttyfast                                      " indicate faster terminal connection
set laststatus=2                                 " always show status line
set cpoptions+=J
set linebreak                                    " break the line by words
set scrolloff=3                                  " show at least 3 lines around the current cursor position
set sidescroll=1
set sidescrolloff=10
set virtualedit+=block
set lazyredraw
set nolist
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
set splitbelow
set splitright
set fillchars=diff:⣿
" Make Vim able to edit crontab files again.
set backupskip=/tmp/*,/private/tmp/*"

" Resize splits when the window is resized
au VimResized * :wincmd =

"开关复制模式
fun! TogglePasteMode()
    if !exists("s:old_pastemode")
        let s:old_pastemode = "1"
    endif

    if s:old_pastemode == "0"
        let s:old_pastemode = "1"
        set number
        set nopaste
        :EnableWhitespace
        :IndentLinesEnable
        call gitgutter#enable()

        if exists("s:old_pastemouse")
            let &mouse = s:old_pastemouse
        endif

        if exists("s:old_pastelist")
            let &list=s:old_pastelist
        endif

        echo "set edit mode"
    else
        let s:old_pastemode = "0"
        set nonumber
        set norelativenumber
        set paste
        :DisableWhitespace
        :IndentLinesDisable
        call gitgutter#disable()

        let s:old_pastemouse = &mouse
        let &mouse=""

        let s:old_pastelist = &list
        let &list="0"

        echo "set copy/paste mode"
    endif
endfunction

"使用F2切换复制/粘帖模式和正常编辑模式
noremap <F2> :call TogglePasteMode()<CR>
inoremap <F2> <ESC>:call TogglePasteMode()<CR>i

"使用F5切换行号模式
noremap <F5> :ToggleNumber<CR>

"使用F6开关list字符
noremap <F6> :set invlist<CR>:set list?<CR>

"使用F7更新Taghighlight
fun! UpdateCtagsAndFileTypes()
"    !ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .
    UpdateTypesFile
    echo "UpdateTypesFile OK!"
endfunction

noremap <F7> :call UpdateCtagsAndFileTypes()<CR>

"鼠标模式切换
fun! ToggleMouse()
    if &mouse == ""
        let &mouse = "a"
        echo "Mouse is for Vim (" . &mouse . ")"
    else
        let &mouse = ""
        echo "Mouse is for Vim (" . &mouse . ")"
    endif
endfunction

"开关YankRing剪贴板缓冲区
nnoremap <F10> :YRShow<CR>

"使用F12切换鼠标模式
noremap <F12> :call ToggleMouse()<CR>
inoremap <F12> <Esc>:call ToggleMouse()<CR>a

" With a map leader it's possible to do extra key combinations
    let mapleader=","

" Instead of reverting the cursor to the last position in the buffer, we
" set it to the first line when editing a git commit message
    au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

"快速退出vim
    nnoremap <C-c> :qall!<CR>
    nnoremap <Leader>q :qall!<CR>

"搜索相关的设置
    set showmatch  " show matching brackets/parenthesis
    set magic      " 根据vim说明默认开启此参数
    set ignorecase " 忽略大小写
    set smartcase  " case sensitive when uc present

    "清空搜索结果高亮显示
    nnoremap <leader>/ :nohlsearch<CR>

"Window navigation mappings
    noremap <C-h> <C-w>h
    noremap <C-j> <C-w>j
    noremap <C-k> <C-w>k
    noremap <C-l> <C-w>l

"Tab navigation mappings
    map tn :tabn<CR>
    map tp :tabp<CR>
    map tm :tabm
    map tt :tabnew<cr>
    map ts :tab split<CR>
    map <C-S-Right> :tabn<CR>
    imap <C-S-Right> <ESC>:tabn<CR>
    map <C-S-Left> :tabp<CR>
    imap <C-S-Left> <ESC>:tabp<CR>

"Code View Mode
    fun! ToggleCodeViewMode()
        if !exists("s:codeviewmode")
            let s:codeviewmode = "0"
        endif

        if s:codeviewmode == "0"
            nmap j jzz
            nmap k kzz
            let s:codeviewmode = "1"
            echo "Code View Mode"
        else
            unmap j
            unmap k
            let s:codeviewmode = "0"
            echo "Code Edit Mode"
        endif
    endfunction
    nnoremap <Leader>jk :call ToggleCodeViewMode()<CR>

" upper/lower word
    nmap <leader>u mQviwU`Q
    nmap <leader>d mQviwu`Q

" upper/lower first char of word
    nmap <leader>U mQgewvU`Q
    nmap <leader>D mQgewvu`Q

" set text wrapping toggles
    nmap <silent> <leader>tw :set invwrap<CR>:set wrap?<CR>

" find merge conflict markers
    nmap <silent> <leader>fc <ESC>/\v^[<=>]{7}( .*\|$)<CR>

" 在命令行里面, 用%%表示当前文件路径
    cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>

" 使用系统剪贴板复制粘帖(仅用于Mac)
    map <leader>y "+y
    map <leader>p "+p

" command mode, ctrl-a to head， ctrl-e to tail
	cnoremap <C-j> <t_kd>
	cnoremap <C-k> <t_ku>
	cnoremap <C-a> <Home>
	cnoremap <C-e> <End>

"代码折叠相关配置
"    set foldmethod=syntax       "代码折叠 共有6中方式如下
        "1. manual 手工定义折叠
        "2. indent 用缩进表示折叠
        "3. expr　 用表达式来定义折叠
        "4. syntax 用语法高亮来定义折叠
        "5. diff   对没有更改的文本进行折叠
        "6. marker 用标志折叠

"设置菜单和帮助的语言，默认改为英语
    set fileencodings=utf-8,gbk "使用utf-8或gbk打开文件
    set encoding=utf8
    set langmenu=en_US.UTF-8
    language message en_US.UTF-8
    let $LC_ALL='en_US.UTF-8'
    let $LANG='en_US.UTF-8'

"pathogen是Vim用来管理插件的插件
    source ~/.vim/bundle/vim-pathogen/autoload/pathogen.vim
    execute pathogen#infect('bundle/{}', '~/.vim/bundle/{}')

"jellybeans配色方案配置
    try
        if $TERM =~ '-256color$'
            colorscheme jellybeans
        else
          colorscheme default
        endif
    catch
    endtry

" Airline ------------------------------
    let g:airline_powerline_fonts = 1
    let g:airline_detect_paste=1
    let g:airline_theme = 'powerlineish'
    let g:airline#extensions#whitespace#enabled = 0
    let g:airline#extensions#whitespace#symbol = '!'
    let g:airline#extensions#syntastic#enabled = 1
    let g:airline#extensions#branch#enabled = 1
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#buffer_nr_show = 1
    "let g:airline#extensions#tabline#left_sep = ' '
    "let g:airline#extensions#tabline#left_alt_sep = '|'

    " to use fancy symbols for airline, uncomment the following lines and use a
    " patched font (more info on the README.rst)
    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif

    " unicode symbols
    "let g:airline_left_sep = '»'
    "let g:airline_left_sep = '▶'
    "let g:airline_right_sep = '«'
    "let g:airline_right_sep = '◀'
    "let g:airline_symbols.crypt = '🔒'
    "let g:airline_symbols.linenr = '␊'
    "let g:airline_symbols.linenr = '␤'
    "let g:airline_symbols.linenr = '¶'
    "let g:airline_symbols.branch = '⎇'
    "let g:airline_symbols.paste = 'ρ'
    "let g:airline_symbols.paste = 'Þ'
    "let g:airline_symbols.paste = '∥'
    "let g:airline_symbols.whitespace = 'Ξ'

    " powerline symbols
    "let g:airline_left_sep = ''
    "let g:airline_left_alt_sep = ''
    "let g:airline_right_sep = ''
    "let g:airline_right_alt_sep = ''
    "let g:airline_symbols.branch = ''
    "let g:airline_symbols.readonly = ''
    "let g:airline_symbols.linenr = ''

    " old vim-powerline symbols
    "let g:airline_left_sep = '⮀'
    "let g:airline_left_alt_sep = '⮁'
    "let g:airline_right_sep = '⮂'
    "let g:airline_right_alt_sep = '⮃'
    "let g:airline_symbols.branch = '⭠'
    "let g:airline_symbols.readonly = '⭤'
    "let g:airline_symbols.linenr = '⭡'

"Unite 聚合搜索
    call unite#filters#matcher_default#use(['matcher_fuzzy'])
    call unite#filters#sorter_default#use(['sorter_rank'])
    call unite#set_profile('files', 'context.smartcase', 1)

    let g:unite_data_directory='~/.cache/unite'
    let g:unite_enable_start_insert=1
    let g:unite_source_history_yank_enable=1
    let g:unite_source_rec_max_cache_files=5000

    let g:unite_source_grep_max_candidates = 200

    if executable('ag')
        " Use ag (the silver searcher)
        " https://github.com/ggreer/the_silver_searcher
        let g:unite_source_grep_command = 'ag'
        let g:unite_source_grep_default_opts =
        \ '-i --vimgrep --hidden --ignore ' .
        \ '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
        let g:unite_source_grep_recursive_opt = ''
    elseif executable('ack')
        " Use ack
        " http://beyondgrep.com/
        let g:unite_source_grep_command = 'ack-grep'
        let g:unite_source_grep_default_opts =
        \ '-i --no-heading --no-color -k -H'
        let g:unite_source_grep_recursive_opt = ''
    elseif executable('ack-grep')
        " Use ack
        " http://beyondgrep.com/
        let g:unite_source_grep_command = 'ack-grep'
        let g:unite_source_grep_default_opts =
        \ '-i --no-heading --no-color -k -H'
        let g:unite_source_grep_recursive_opt = ''
    elseif executable('hw')
        " Use hw (highway)
        " https://github.com/tkengo/highway
        let g:unite_source_grep_command = 'hw'
        let g:unite_source_grep_default_opts = '--no-group --no-color'
        let g:unite_source_grep_recursive_opt = ''
    elseif executable('pt')
        " Use pt (the platinum searcher)
        " https://github.com/monochromegane/the_platinum_searcher
        let g:unite_source_grep_command = 'pt'
        let g:unite_source_grep_default_opts = '--nogroup --nocolor'
        let g:unite_source_grep_recursive_opt = ''
    elseif executable('jvgrep')
        " Use jvgrep
        " https://github.com/mattn/jvgrep
        let g:unite_source_grep_command = 'jvgrep'
        let g:unite_source_grep_default_opts =
        \ '-i --exclude ''\.(git|svn|hg|bzr)'''
        let g:unite_source_grep_recursive_opt = '-R'
    endif

    function! s:unite_settings()
        nmap <buffer> Q <plug>(unite_exit)
        nmap <buffer> <esc> <plug>(unite_exit)
        imap <buffer> <esc> <plug>(unite_exit)
        imap <buffer> <C-j>   <Plug>(unite_select_next_line)
        imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
    endfunction
    autocmd FileType unite call s:unite_settings()

    nmap <space> [unite]
    nnoremap [unite] <nop>

    nnoremap <silent> [unite]<space> :<C-u>Unite -toggle -auto-resize -buffer-name=mixed file_mru file_rec/async buffer bookmark<cr><c-u>
    nnoremap <silent> [unite]f :<C-u>Unite -toggle -auto-resize -buffer-name=files file_rec/async<cr><c-u>
    nnoremap <silent> [unite]y :<C-u>Unite -buffer-name=yanks history/yank<cr>
    nnoremap <silent> [unite]l :<C-u>Unite -auto-resize -buffer-name=line line<cr>
    nnoremap <silent> [unite]b :<C-u>Unite -auto-resize -buffer-name=buffers buffer<cr>
    nnoremap <silent> [unite]/ :<C-u>Unite -no-quit -buffer-name=search grep:.<cr>
    nnoremap <silent> [unite]m :<C-u>Unite -auto-resize -buffer-name=mappings mapping<cr>
    nnoremap <silent> [unite]s :<C-u>Unite -quick-match buffer<cr>

"Ack选项
    let g:ack_default_options = " -s -H --nocolor --nogroup --column --ignore-file=is:tags --ignore-file=ext:taghl"

"Tagbar配置
    let g:tagbar_width=26
    let g:tagbar_autofocus = 1
    noremap <silent> <F4> :TagbarToggle<CR>

" Neocomplete (need LUA)
   " Disable AutoComplPop.
    let g:acp_enableAtStartup = 0
    " Use neocomplete.
    let g:neocomplete#enable_at_startup = 1
    " Use smartcase.
    let g:neocomplete#enable_smart_case = 1
    " Set minimum syntax keyword length.
    let g:neocomplete#sources#syntax#min_keyword_length = 3
    let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

    let g:neocomplete#sources#tags#cache_limit_size = 4194304

    " Define dictionary.
    let g:neocomplete#sources#dictionary#dictionaries = {
        \ 'default' : '',
        \ 'vimshell' : $HOME.'/.vimshell_hist',
        \ 'scheme' : $HOME.'/.gosh_completions'
            \ }

    " Define keyword.
    if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns['default'] = '\h\w*'

    " Plugin key-mappings.
    inoremap <expr><C-g>     neocomplete#undo_completion()
    inoremap <expr><C-l>     neocomplete#complete_common_string()

    " Recommended key-mappings.
    " <CR>: close popup and save indent.
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
      " return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
      " For no inserting <CR> key.
      return pumvisible() ? "\<C-y>" : "\<CR>"
    endfunction
    " <TAB>: completion.
    " inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
    " Close popup by <Space>.
    " inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

    " AutoComplPop like behavior.
    let g:neocomplete#enable_auto_select = 1

    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

    " Enable heavy omni completion.
    if !exists('g:neocomplete#sources#omni#input_patterns')
      let g:neocomplete#sources#omni#input_patterns = {}
    endif
    let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
    " let g:neocomplete#sources#omni#input_patterns.c   = '[^.[:digit:] *\t]\%(\.\|->\)'
    " let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

    " For perlomni.vim setting.
    " https://github.com/c9s/perlomni.vim
    let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" vim-clang (work with neocomplete)
    "vim-clang supports relative include path in .clang configuration file.
    " disable auto completion for vim-clang
    let g:clang_auto = 0
    " default 'longest' can not work with neocomplete
    let g:clang_c_completeopt = 'menuone'
    let g:clang_cpp_completeopt = 'menuone'
    let g:clang_debug = 0
    let g:clang_exec = 'clang'
    let g:clang_c_options = '-std=gnu11'
    let g:clang_cpp_options = '-std=c++11 -stdlib=libc++'
    if !exists('g:neocomplete#force_omni_input_patterns')
            let g:neocomplete#force_omni_input_patterns = {}
    endif
    " for c and c++
    let g:neocomplete#force_omni_input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)\w*'
    let g:neocomplete#force_omni_input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'

    map <silent> <Leader>x <Esc>:ClangCloseWindow<CR>

"NerdTree配置
    map <F3> :NERDTreeToggle<CR>

    let NERDTreeShowBookmarks=1
    let NERDTreeIgnore=['\.o','\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
    let NERDTreeChDirMode=2     "setting root dir in NT also sets VIM's cd
    let NERDTreeQuitOnOpen=0 "the Nerdtree window will be close after a file is opend.
    let NERDTreeShowHidden=1
    let NERDTreeKeepTreeInNewTab=1

"rainbow_parentheses括号匹配着色插件配置
    nnoremap <leader>R :RainbowParenthesesToggle<cr>
    let g:rbpt_colorpairs = [
        \ ['brown',       'RoyalBlue3'],
        \ ['Darkblue',    'SeaGreen3'],
        \ ['darkgray',    'DarkOrchid3'],
        \ ['darkgreen',   'firebrick3'],
        \ ['darkcyan',    'RoyalBlue3'],
        \ ['darkred',     'SeaGreen3'],
        \ ['darkmagenta', 'DarkOrchid3'],
        \ ['brown',       'firebrick3'],
        \ ['gray',        'RoyalBlue3'],
        \ ['black',       'SeaGreen3'],
        \ ['darkmagenta', 'DarkOrchid3'],
        \ ['Darkblue',    'firebrick3'],
        \ ['darkgreen',   'RoyalBlue3'],
        \ ['darkcyan',    'SeaGreen3'],
        \ ['darkred',     'DarkOrchid3'],
        \ ['red',         'firebrick3'],
        \ ]
    let g:rbpt_max = 16
    let g:rbpt_loadcmd_toggle = 0

    au VimEnter * RainbowParenthesesToggle
    au Syntax * RainbowParenthesesLoadRound
    au Syntax * RainbowParenthesesLoadSquare
    au Syntax * RainbowParenthesesLoadBraces

"Fugitive配置
    nnoremap <Leader>gs :Gstatus<CR>
    nnoremap <Leader>gr :Gremove<CR>
    nnoremap <Leader>gl :Glog<CR>
    nnoremap <Leader>gb :Gblame<CR>
    nnoremap <Leader>gm :Gmove
    nnoremap <Leader>gp :Ggrep
    nnoremap <Leader>gR :Gread<CR>
    nnoremap <Leader>gg :Git
    nnoremap <Leader>gd :Gdiff<CR>

"vim-go & gotags config
    let g:go_highlight_functions = 1
    let g:go_highlight_methods = 1
    let g:go_highlight_structs = 1
    let g:go_highlight_operators = 1
    let g:go_highlight_build_constraints = 1

    if executable('goimports')
        let g:go_fmt_command = "goimports"
    endif

    let g:go_fmt_autosave = 1

    au FileType go nmap <leader>r <Plug>(go-run)
    au FileType go nmap <leader>b <Plug>(go-build)
    au FileType go nmap <leader>t <Plug>(go-test)
    au FileType go nmap <leader>c <Plug>(go-coverage)
    let g:tagbar_type_go = {
        \ 'ctagstype' : 'go',
        \ 'kinds'     : [
            \ 'p:package',
            \ 'i:imports:1',
            \ 'c:constants',
            \ 'v:variables',
            \ 't:types',
            \ 'n:interfaces',
            \ 'w:fields',
            \ 'e:embedded',
            \ 'm:methods',
            \ 'r:constructor',
            \ 'f:functions'
        \ ],
        \ 'sro' : '.',
        \ 'kind2scope' : {
            \ 't' : 'ctype',
            \ 'n' : 'ntype'
        \ },
        \ 'scope2kind' : {
            \ 'ctype' : 't',
            \ 'ntype' : 'n'
        \ },
        \ 'ctagsbin'  : 'gotags',
        \ 'ctagsargs' : '-sort -silent'
    \ }

"neosnippet
    " Plugin key-mappings.
    imap <C-k>     <Plug>(neosnippet_expand_or_jump)
    smap <C-k>     <Plug>(neosnippet_expand_or_jump)
    xmap <C-k>     <Plug>(neosnippet_expand_target)

    " SuperTab like snippets behavior.
    imap <expr><TAB>
     \ pumvisible() ? "\<C-n>" :
     \ neosnippet#expandable_or_jumpable() ?
     \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
    smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

    " For conceal markers.
    if has('conceal')
      set conceallevel=2 concealcursor=niv
    endif

"vim-signature
let g:SignatureMap = {
        \ 'Leader'             :  "m",
        \ 'PlaceNextMark'      :  "m,",
        \ 'ToggleMarkAtLine'   :  "m.",
        \ 'PurgeMarksAtLine'   :  "m-",
        \ 'DeleteMark'         :  "dm",
        \ 'PurgeMarks'         :  "m<Space>",
        \ 'PurgeMarkers'       :  "m<BS>",
        \ 'GotoNextLineAlpha'  :  "']",
        \ 'GotoPrevLineAlpha'  :  "'[",
        \ 'GotoNextSpotAlpha'  :  "`]",
        \ 'GotoPrevSpotAlpha'  :  "`[",
        \ 'GotoNextLineByPos'  :  "]'",
        \ 'GotoPrevLineByPos'  :  "['",
        \ 'GotoNextSpotByPos'  :  "mn",
        \ 'GotoPrevSpotByPos'  :  "mp",
        \ 'GotoNextMarker'     :  "[+",
        \ 'GotoPrevMarker'     :  "[-",
        \ 'GotoNextMarkerAny'  :  "]=",
        \ 'GotoPrevMarkerAny'  :  "[=",
        \ 'ListLocalMarks'     :  "ms",
        \ 'ListLocalMarkers'   :  "m?"
        \ }

"vim-commentary
    "use <BackSpace> to comment/uncomment a line
    nmap <BS> gcc
    vmap <BS> gc

"easymotion
    let g:EasyMotion_do_mapping = 0 " Disable default mappings
    let g:EasyMotion_smartcase  = 1 " Turn on case insensitive feature
    let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion

    " Move to anywhere of current line
    map <Leader>l <Plug>(easymotion-lineanywhere)

    " Move to line
    map <Leader>L <Plug>(easymotion-bd-jk)

    " Move to word
    map  <Leader>w <Plug>(easymotion-bd-w)

    " <Leader>f{char} to move to {char}
    map  <Leader>f <Plug>(easymotion-bd-f)

    " <Leader>f{char}{char} to move to {char}{char}
    map  <Leader>F <Plug>(easymotion-bd-f2)

    " Repeat last motion!
    map <Leader><leader>, <Plug>(easymotion-repeat)

"undotree
    function! s:get_undotree_dir() "{{{
        let s:undotree_dir=
            \ substitute(substitute(fnamemodify(
            \ get(s:, 'undotree_dir',
            \  ($XDG_CACHE_HOME != '' ?
            \   $XDG_CACHE_HOME . '/undotree' : expand('~/.cache/undotree'))),
            \  ':p'), '\\', '/', 'g'), '/$', '', '')

        if !isdirectory(s:undotree_dir)
            call mkdir(s:undotree_dir, 'p')
        endif

        return s:undotree_dir
    endfunction"}}}

    nnoremap <F8> :UndotreeToggle<cr>
    if has("persistent_undo")
        let s:undotree_dir = "~/.cache/undotree"
        call s:get_undotree_dir()
        let &undodir = s:undotree_dir
        set undofile
    endif

"vim-multiple-cursors
    "
    "Other plugins may trigger on keypresses when in insert mode. These plugins
    "generally provide a means to toggle their active state. These hooks allow the
    "user to provide functions in their .vimrc to do this when
    "multiple-cursor-mode is entered.
    "With this locking and unlocking we prevent neocomplete to trigger it's
    "function calls until we are finished with multiple cursors editing.

    " Called once right before you start selecting multiple cursors
    function! Multiple_cursors_before()
      if exists(':NeoCompleteLock')==2
        exe 'NeoCompleteLock'
      endif
    endfunction

    " Called once only when the multiple selection is canceled (default <Esc>)
    function! Multiple_cursors_after()
      if exists(':NeoCompleteUnlock')==2
        exe 'NeoCompleteUnlock'
      endif
    endfunction

    "If you don't like the plugin taking over your favorite key bindings, you
    "can turn off the default with
    let g:multi_cursor_use_default_mapping=0

    " Default mapping
    let g:multi_cursor_next_key='<C-n>'
    let g:multi_cursor_prev_key='<C-p>'
    let g:multi_cursor_skip_key='<C-x>'
    let g:multi_cursor_quit_key='<Esc>'

    "By default, the 'next' key is also used to enter multicursor mode. If you
    "want to use a different key to start multicursor mode than for selecting
    "the next location, do like the following:
    " Map start key separately from next key
    let g:multi_cursor_start_key='<F9>'

    "Note that when multicursor mode is started, it selects current word with
    "boundaries, i.e. it behaves like *. If you want to avoid word boundaries in
    "Normal mode (as g* does) but still have old behaviour up your sleeve, you can
    "do the following
    "let g:multi_cursor_start_key='<C-n>'
    let g:multi_cursor_start_word_key='g<C-n>'

    "You can also map your own keys to quit, if g:multi_cursor_quit_key won't
    "work:
    "let g:multi_cursor_quit_key='<C-c>'
    "nnoremap <C-c> :call multiple_cursors#quit()<CR>

"vim-expand-region
    "Press '+' to expand the visual selection and '_' to shrink it.

"vim-better-whitespace
    "need this hack code to make everything OK now
    autocmd VimEnter * DisableWhitespace
    autocmd VimEnter * EnableWhitespace
    map <leader><space> :StripWhitespace<CR>

"indentLine
    " let g:indentLine_char = '┆'
    let g:indentLine_char = '¦'

"vim-visual-star-search
    "This plugin allows you to select some text using Vim's visual mode, then hit
    "* and # to search for it elsewhere in the file
    "If you hit <leader>* (\* unless you changed the mapleader), vim recursively
    "vimgreps for the word under the cursor or the visual selection.

"统一swapdir&backupdir
    function! s:get_swap_dir() "{{{
        let s:swap_dir=
            \ substitute(substitute(fnamemodify(
            \ get(s:, 'swap_dir',
            \  ($XDG_CACHE_HOME != '' ?
            \   $XDG_CACHE_HOME . '/swap_dir' : expand('~/.cache/swap_dir'))),
            \  ':p'), '\\', '/', 'g'), '/$', '', '')

        if !isdirectory(s:swap_dir)
            call mkdir(s:swap_dir, 'p')
        endif

        return s:swap_dir
    endfunction"}}}

    let s:swap_dir = "~/.cache/swap_dir//"
    call s:get_swap_dir()
    "let &directory = s:swap_dir
    "为了实现同名文件可以同时存在swapfile，先写死
    set directory=~/.cache/swap_dir//
    set backupdir=~/.cache/swap_dir//

"tagbar-phpctags
    let g:tagbar_phpctags_bin='~/.vim/bundle/tagbar-phpctags.vim/bin/phpctags'
    let g:tagbar_phpctags_memory_limit = '128M'

"Syntastic
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

    " let g:syntastic_always_populate_loc_list = 0
    " let g:syntastic_auto_loc_list = 0
    let g:syntastic_check_on_open = 0
    let g:syntastic_check_on_wq = 0
    let g:syntastic_loc_list_height = 5

    "set error or warning signs
    let g:syntastic_error_symbol = '✗'
    let g:syntastic_warning_symbol = '⚠'
    "whether to show balloons
    let g:syntastic_enable_balloons = 1

    " let g:syntastic_enable_highlighting=1
    " let g:syntastic_python_checkers=['pyflakes'] " 使用pyflakes,速度比pylint快
    " let g:syntastic_javascript_checkers = ['jsl', 'jshint']
    " let g:syntastic_html_checkers=['tidy', 'jshint']"

    nnoremap <Leader>s :SyntasticCheck<CR>:Errors<CR>

" YankRing 剪贴板增量，支持256个最近剪贴
    function! s:get_yankring_dir() "{{{
        let s:yankring_dir=
            \ substitute(substitute(fnamemodify(
            \ get(s:, 'yankring_dir',
            \  ($XDG_CACHE_HOME != '' ?
            \   $XDG_CACHE_HOME . '/yankring_dir' : expand('~/.cache/yankring_dir'))),
            \  ':p'), '\\', '/', 'g'), '/$', '', '')

        if !isdirectory(s:yankring_dir)
            call mkdir(s:yankring_dir, 'p')
        endif

        return s:yankring_dir
    endfunction"}}}

    let s:yankring_dir = "~/.cache/yankring_dir//"
    call s:get_yankring_dir()

    let g:yankring_history_dir="~/.cache/yankring_dir//"
    let g:yankring_max_history=256
    " let g:yankring_replace_n_pkey='<C-K>'
    " let g:yankring_replace_n_nkey='<C-J>'

" incsearch.vim x fuzzy x vim-easymotion
    "insearch.vim
    map /  <Plug>(incsearch-forward)
    map ?  <Plug>(incsearch-backward)
    map g/ <Plug>(incsearch-stay)

    "insearch with no hlsearch
    let g:incsearch#auto_nohlsearch = 1
    map n  <Plug>(incsearch-nohl-n)
    map N  <Plug>(incsearch-nohl-N)
    map *  <Plug>(incsearch-nohl-*)
    map #  <Plug>(incsearch-nohl-#)
    map g* <Plug>(incsearch-nohl-g*)
    map g# <Plug>(incsearch-nohl-g#)

    "incsearch + easymotion
    " map z/ <Plug>(incsearch-easymotion-/)
    " map z? <Plug>(incsearch-easymotion-?)
    " map zg/ <Plug>(incsearch-easymotion-stay)

    "fuzzy search
    map z/ <Plug>(incsearch-fuzzy-/)
    map z? <Plug>(incsearch-fuzzy-?)
    map zg/ <Plug>(incsearch-fuzzy-stay)

    function! s:config_easyfuzzymotion(...) abort
      return extend(copy({
      \   'converters': [incsearch#config#fuzzy#converter()],
      \   'modules': [incsearch#config#easymotion#module()],
      \   'keymap': {"\<CR>": '<Over>(easymotion)'},
      \   'is_expr': 0,
      \   'is_stay': 1
      \ }), get(a:, 1, {}))
    endfunction

    "fuzzy search + easymotion
    noremap <silent><expr> <Space>z incsearch#go(<SID>config_easyfuzzymotion())

"vim-extradite 查看gitlog
    nnoremap <Leader>gl :Extradite<CR>

"vim-plist
    let g:plist_display_format = 'xml'
    let g:plist_save_format = ''

"vim-json
    let g:vim_json_syntax_conceal = 0

"自定义命令
command! Ctags !ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .
command! Gotags !gotags -R . >tags

command! Hex %!xxd
command! Asc %!xxd -r

command! Cswp !rm -f ~/.cache/swap_dir/*

