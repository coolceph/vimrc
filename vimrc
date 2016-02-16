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
" Last change:	2016.02.16
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

set nowrap       "禁用自动折行

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

"set clipboard+=unnamed "use System clipboard on Mac
set number                  "显示行号
set autoread                "文件在Vim之外修改过，自动重新读入
set showbreak=↪             "显示换行符
set completeopt=longest,menuone,preview "更好的insert模式自动完成
set modeline    "允许被编辑的文件以注释的形式设置Vim选项
set hidden              "switching buffers without saving
set ruler               " show the cursor position all the time
set showcmd             " display incomplete commands
set wildmenu            " show enhanced completion
set wildmode=list:longest "together with wildmenu
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit
set wildignore+=*.pyc                            " Python byte code
set wildignore+=*.orig                           " Merge resolution files
set visualbell          "flash screen when bell rings
set cursorline          "highline cursor line
set ttyfast             "indicate faster terminal connection
set laststatus=2        "always show status line
set cpoptions+=J
set linebreak           " break the line by words
set scrolloff=3         " show at least 3 lines around the current cursor position
set sidescroll=1
set sidescrolloff=10
set virtualedit+=block
set lazyredraw
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

        echo "set edit mode"
    else
        let s:old_pastemode = "0"
        set nonumber
        set norelativenumber
        set nolist
        set paste
        :DisableWhitespace
        :IndentLinesDisable
        call gitgutter#disable()

        let s:old_pastemouse = &mouse
        let &mouse=""

        echo "set copy/paste mode"
    endif
endfunction

"使用F2切换复制/粘帖模式和正常编辑模式
"set pastetoggle=<F2> "old mode, deprecated
noremap <F2> :call TogglePasteMode()<CR>

"使用F5切换行号模式
noremap <F5> :ToggleNumber<CR>

"使用F6开关list字符
noremap <F6> :set list!<CR>

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

"使用F12切换鼠标模式
noremap <F12> :call ToggleMouse()<CR>
inoremap <F12> <Esc>:call ToggleMouse()<CR>a

"快速退出vim
    nnoremap <C-c> :qall!<CR>

"设置mapleader前缀
    let mapleader = ','

"搜索相关的设置
    "set gdefault   "由于设置gdefault之后会导致%s/abc/abc/g最后的g参数反义，影响直觉，因此禁用
    set showmatch  " show matching brackets/parenthesis
    set incsearch  " find as you type search
    set magic      " 根据vim说明默认开启此参数
    set ignorecase " 忽略大小写
    set smartcase  " case sensitive when uc present
    nnoremap <leader>/ :nohlsearch<CR> "清空搜索结果高亮显示

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

"Buffer navigation mappings
    nnoremap <C-n> :bn<CR>
    nnoremap <C-p> :bp<CR>

"For code reviewing
    "nnoremap j jzz
    "nnoremap k kzz

"代码折叠相关配置
"    set foldmethod=syntax       "代码折叠 共有6中方式如下
        "1. manual 手工定义折叠
        "2. indent 用缩进表示折叠
        "3. expr　 用表达式来定义折叠
        "4. syntax 用语法高亮来定义折叠
        "5. diff   对没有更改的文本进行折叠
        "6. marker 用标志折叠
"    vnoremap <Space> zah "空格键折叠，h是为了解决Space会导致焦点右移一位的问题
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
    colorscheme jellybeans

" Airline ------------------------------
    let g:airline_powerline_fonts = 1
    let g:airline_detect_paste=1
    " let g:airline_theme = 'powerlineish'
    " let g:airline_theme = 'jellybeans'
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
    noremap <silent> <F4> :TagbarToggle<CR>
    let g:tagbar_autofocus = 1

" NeoComplCache ------------------------------
    " most of them not documented because I'm not sure how they work
    " (docs aren't good, had to do a lot of trial and error to make
    " it play nice)
    let g:neocomplcache_enable_at_startup = 1
    let g:neocomplcache_enable_ignore_case = 1
    let g:neocomplcache_enable_smart_case = 1
    let g:neocomplcache_enable_auto_select = 1
    let g:neocomplcache_enable_fuzzy_completion = 1
    let g:neocomplcache_enable_camel_case_completion = 1
    let g:neocomplcache_enable_underbar_completion = 1
    let g:neocomplcache_fuzzy_completion_start_length = 1
    let g:neocomplcache_auto_completion_start_length = 1
    let g:neocomplcache_manual_completion_start_length = 1
    let g:neocomplcache_min_keyword_length = 1
    let g:neocomplcache_min_syntax_length = 1
    " complete with workds from any opened file
    let g:neocomplcache_same_filetype_lists = {}
    let g:neocomplcache_same_filetype_lists._ = '_'

"NerdTree配置
    map <F3> :NERDTreeToggle<CR>
    map <leader>e :NERDTreeFind<CR>
    nmap <leader>nt :NERDTreeFind<CR>

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

"Autoclose自动成对补充括号插件
    nmap <Leader>x <Plug>ToggleAutoCloseMappings

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
    "
    " Called once right before you start selecting multiple cursors
    function! Multiple_cursors_before()
      if exists(':NeoComplcacheUnLock')==2
        exe 'NeoComplcacheUnLock'
      endif
    endfunction

    " Called once only when the multiple selection is canceled (default <Esc>)
    function! Multiple_cursors_after()
      if exists(':NeoComplcacheUnLock')==2
        exe 'NeoComplcacheUnLock'
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
    map K <Plug>(expand_region_expand)
    map J <Plug>(expand_region_shrink)

"vim-better-whitespace
"need this hack code to make everything OK now
    autocmd VimEnter * DisableWhitespace
    autocmd VimEnter * EnableWhitespace
    map <leader><space> :StripWhitespace<CR>

"indentLine
    " let g:indentLine_char = '┆'
    let g:indentLine_char = '¦'

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
"    let g:tagbar_phpctags_bin='PATH_TO_phpctags'
    let g:tagbar_phpctags_memory_limit = '256M'

"自定义命令
command! Ctags !ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .
command! Gotags !gotags -R . >tags

command! Hex %!xxd
command! Asc %!xxd -r

command! Cswp !rm -f ~/.cache/swap_dir/*

