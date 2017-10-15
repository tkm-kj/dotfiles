" ---NeoBundle---
" NeoBundle起動
set runtimepath+=~/.vim/bundle/neobundle.vim
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

" plugins
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/neocomplcache.vim'
NeoBundle 'Shougo/vimproc.vim', 'ver.9.2'
NeoBundle 'kana/vim-smartinput'
NeoBundle 'cohama/vim-smartinput-endwise'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tmhedberg/matchit'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-rhubarb'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kana/vim-textobj-entire'
NeoBundle 'rking/ag.vim'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'mxw/vim-jsx'
NeoBundle 'mtscout6/vim-cjsx'
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'slim-template/vim-slim.git'
NeoBundle 'vim-scripts/vim-auto-save'
NeoBundle 'rhysd/clever-f.vim'
NeoBundle 'elixir-lang/vim-elixir'
NeoBundle 'kmnk/vim-unite-giti.git'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'derekwyatt/vim-scala'
NeoBundle 'ctrlpvim/ctrlp.vim'

call neobundle#end()

" ---smartinput-endwise---
call smartinput_endwise#define_default_rules() "上の呼び出し"

" ---Unite---
let g:unite_abbr_highlight = 'normal' " アウトライン機能のバグの一時的な処置
"ヒストリー/ヤンク機能を有効化
let g:unite_source_history_yank_enable =1
"prefix keyの設定(スペース)
nmap <Space> [unite]
"スペースキーとaキーでカレントディレクトリを表示
nnoremap <silent> [unite]a :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
"スペースキーとgキーでgrep
nnoremap <silent> [unite]g :<C-u>Unite<Space>grep<CR>
nnoremap <silent> [unite]c :<C-u>Unite<Space>grep:. -buffer-name=search-buffer<CR>
nnoremap <silent> [unite]w :<C-u>Unite<Space>grep:. -buffer-name=search-buffer<CR><C-R><C-W><CR>
"スペースキーとrキーで直近で調べたものを再grep
nnoremap <silent> [unite]r :<C-u>UniteResume -buffer-name=search-buffer<CR>
"スペースキーとdキーで最近開いたディレクトリを表示
nnoremap <silent> [unite]d :<C-u>Unite<Space>directory_mru<CR>
"スペースキーとbキーでバッファを表示
nnoremap <silent> [unite]b :<C-u>Unite<Space>buffer<CR>
"スペースキーとtキーでタブを表示
nnoremap <silent> [unite]t :<C-u>Unite<Space>tab<CR>
"スペースキーとhキーでヒストリ/ヤンクを表示
nnoremap <silent> [unite]h :<C-u>Unite<Space>history/yank<CR>
"スペースキーとoキーでoutline
nnoremap <silent> [unite]o :<C-u>Unite<Space>outline<CR>
"スペースキーとENTERキーでfile_rec:!
nnoremap <silent> [unite]<CR> :<C-u>Unite<Space>file_rec:!<CR>
"unite.vimを開いている間のキーマッピング
autocmd FileType unite call s:unite_my_settings()
" C-cでuniteを終了
function! s:unite_my_settings()"{{{
    nmap <buffer> <C-c> <Plug>(unite_exit)
endfunction"}}}
call unite#custom#source('file',  'matchers',  "matcher_default") " ドットファイル表示
" grepでag使用
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif
augroup unite_key_config
  autocmd!
augroup END
autocmd unite_key_config filetype unite nnoremap <buffer> <C-k> <C-u>

" ---neocomplcache---
let g:neocomplcache_enable_at_startup = 1 " neocomplcacheを起動時に有効化
let g:neocomplcache_enable_smart_case = 1 " 大文字が入力されるまで大文字小文字の区別を無視する
let g:neocomplcache_min_syntax_length = 3 " シンタックスをキャッシュするときの最小文字長
" ディクショナリ設定
let g:neocomplcache_dictionary_filetype_lists = {
      \ 'default' : '',
      \ 'vimshell' : $HOME.'/.vimshell_hist',
      \ 'scheme' : $HOME.'/.gosh_completions'
      \ }
" キーワードパターン
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
" tabでもctrl−nのように選べる
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" ---lightline---
let g:lightline = {
      \ 'colorscheme': 'default',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"⭤":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ }
      \ }

" ---vim-easy-align---
" ビジュアルモードで範囲選択 + Enter + (区切り文字)で頭が並ぶようになる
vmap <Enter> <Plug>(EasyAlign)

" ---vim-indent-guides---
" vimを立ち上げたときに、自動的にvim-indent-guidesをオンにする
let g:indent_guides_enable_on_vim_startup = 1

" ---vim-auto-save---
let g:auto_save = 1
let g:auto_save_in_insert_mode = 0
let g:auto_save_silent = 1

" ---vim-jsx---
let g:jsx_ext_required = 0
