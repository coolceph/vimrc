let g:my_complete_plugin = "YouCompleteMe"

"YouCompleteMe
    let g:acp_enableAtStartup = 0
    "let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"
    let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py'
    let g:ycm_extra_conf_globlist=['~/.vim/*']
    let g:ycm_collect_identifiers_from_tags_files = 1
    let g:ycm_filetype_blacklist={
                \ 'tagbar' : 1,
                \ 'qf' : 1,
                \ 'notes' : 1,
                \ 'unite' : 1,
                \ 'vimwiki' : 1,
                \ 'pandoc' : 1,
                \ 'infolog' : 1,
                \ 'objc' : 1,
                \ 'mail' : 1
                \}
    nnoremap <silent> <Leader>yc :YcmCompleter GetDoc<CR>
    nnoremap <silent> <Leader>yf :YcmCompleter FixIt<CR>
    nnoremap <silent> <Leader>yg :YcmCompleter GoTo<CR>
    nnoremap <silent> <Leader>yi :YcmCompleter GoToInclude<CR>
    nnoremap <silent> <Leader>yt :YcmCompleter GetType<CR>
    nnoremap <silent> <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>

    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
    autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

    " 回车键选中补全项(有冲突，关闭此设置）
    "inoremap <expr> <CR>       pumvisible() ? '<C-y>' : '\<CR>'
