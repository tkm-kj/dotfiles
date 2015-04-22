" ---基本設定---
" ファイルタイプ関連を無効化
filetype off
filetype plugin indent off
syntax on " シンタックスハイライトを有効にする
set laststatus=2 " 編集中のファイル名を常に表示
set whichwrap=b,s,h,l,<,>,[,] " 行を跨いで移動出来る様にする
set virtualedit=block " 短形選択の時便利なやつ
set encoding=utf-8 " デフォルトの文字コード
set ffs=unix,dos,mac  " 改行文字
" set fileencoding=utf-8
set smartindent " 新しい行を開始した時に、新しい行のインデントを現在行と同じ量にする
set cindent " Cプログラムの自動インデント
set wrap " 検索がファイル末尾まで行ったら最初に戻る
set wildmenu    " コマンドの補完候補を表示
set number " 行番号を表示する
set incsearch " インクリメンタルサーチ
" set ignorecase " 検索時に大文字小文字を無視する
set showmatch " 対応する括弧のハイライト表示する
set showmode " モード表示する
set title " 編集中のファイル名を表示する
set ruler " ルーラーの表示する
set t_Co=256 " 256色
set background=dark " 背景
set tabstop=2 " タブを表示するときの幅
set autoindent " オートインデント
set expandtab " タブ文字挿入"
set shiftwidth=2 " タブを挿入するときの幅
set showcmd " コマンド表示
set clipboard+=unnamed " クリップボードにコピーされる
set mouse=a " マウス操作可能にする
set ttymouse=xterm2 " 端末vimでマウスを使う
set guioptions+=a " クリップボード連携
set noswapfile " swpファイル作らない
set pastetoggle=<C-^> " pasteモードの切替
set hlsearch " 検索結果のハイライト
" 折りたたみ設定
" zo: カーソル下にある折りたたみをひとつ開く
" zO: カーソル下にある折りたたみを全て開く
" zc: カーソル下にある折りたたみをひとつ閉じる
" zC: カーソル下にある折りたたみを全て閉じる
set foldmethod=syntax
let perl_fold=1
set foldlevel=100

" コメント行から改行した行をコメントにしないようにする
augroup auto_comment_off
  autocmd!
  autocmd BufEnter * setlocal formatoptions-=r
  autocmd BufEnter * setlocal formatoptions-=o
augroup END
" 行末の空白を保存時に削除
autocmd BufWritePre * :%s/\s\+$//e


" ---見た目---
colorscheme jellybeans
set cursorline
highlight CursorLine cterm=underline
let loaded_matchparen = 1 " 対応カッコの強調表示解除

" ---NeoBundle---
" NeoBundle起動
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#begin(expand('~/.vim/bundle/'))
  NeoBundleFetch 'Shougo/neobundle.vim'
  call neobundle#end()
endif
" ここにインストールしたいプラグインのリストを書く
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/neocomplcache.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'jistr/vim-nerdtree-tabs'
NeoBundle 'git://github.com/scrooloose/syntastic.git'
NeoBundle 'kana/vim-smartinput'
NeoBundle 'cohama/vim-smartinput-endwise'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tmhedberg/matchit'
" NeoBundle 'jelera/vim-javascript-syntax', { 'autoload': { 'filetypes': ['javascript'] } }
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kana/vim-textobj-entire'
NeoBundle 'rking/ag.vim'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'rhysd/clever-f.vim'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'mxw/vim-jsx'

" ---smartinput---
" 改行する度に行末のスペース削除
call smartinput#define_rule({
      \ 'at': '\s\+\%#',
      \ 'char': '<CR>',
      \ 'input': "<C-o>:call setline('.', substitute(getline('.'), '\\s\\+$', '', ''))<CR><CR>",
      \ })

" ---smartinput-endwise---
call smartinput_endwise#define_default_rules() "上の呼び出し"

" ---NERDTree---
" ファイル指定で開かれた場合はNERDTreeは表示しない
if !argc()
  autocmd vimenter * NERDTree|normal gg3j
endif
" NERDTreeだけの場合は勝手に閉じる
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDTreeShowHidden=1 " NERDTreeでドットファイル表示

" ---Unite---
let g:unite_abbr_highlight = 'normal' " アウトライン機能のバグの一時的な処置
"ヒストリー/ヤンク機能を有効化
let g:unite_source_history_yank_enable =1
"prefix keyの設定
nmap <Space> [unite]
"スペースキーとaキーでカレントディレクトリを表示
nnoremap <silent> [unite]a :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
"スペースキーとfキーでバッファと最近開いたファイル一覧を表示
nnoremap <silent> [unite]f :<C-u>Unite<Space>buffer file_mru<CR>
"スペースキーとdキーで最近開いたディレクトリを表示
nnoremap <silent> [unite]d :<C-u>Unite<Space>directory_mru<CR>
"スペースキーとbキーでバッファを表示
nnoremap <silent> [unite]b :<C-u>Unite<Space>buffer<CR>
"スペースキーとrキーでレジストリを表示
nnoremap <silent> [unite]r :<C-u>Unite<Space>register<CR>
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
" ドットファイル表示
call unite#custom#source('file',  'matchers',  "matcher_default")

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

" ---syntastic---
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_mode_map = { 'mode': 'passive' } " 自動でsyntax checkが走らないようにする
" let g:syntastic_mode_map = { 'mode': 'active',
"                            \ 'passive_filetypes': ['sass', 'scss', 'c'] } " 特定の拡張子だけsyntax checkを行わないようにする
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" ---lightline---
let g:lightline = {
      \ 'colorscheme': 'jellybeans',
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


" ---キーバインド---
" 削除した時のレジスタ設定
nnoremap d "1d
vnoremap d "1d
vnoremap x "1d
" ペースト設定
nnoremap p "0p
vnoremap p "0p
nnoremap dp "1p
vnoremap dp "1p
nnoremap P "0P
vnoremap P "0P
nnoremap dP "1P
vnoremap dP "1P

" 移動系, 選択系
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap <C-j> <C-n>
inoremap <C-k> <C-p>
inoremap <Down> <C-n>
inoremap <Up> <C-p>
noremap <C-h> ^
nnoremap <C-l> $
vnoremap <C-l> $h
noremap <C-j> <C-d>
noremap <C-k> <C-u>
noremap <C-w><C-g> <C-w>t
noremap <C-w>g <C-w>t
" vimrc更新
nnoremap <C-]> :source ~/.vimrc<CR>
" NERDTree起動ショートカット && 画面を均等に
nnoremap <silent> <C-@> :NERDTreeToggle<CR><C-w>=
" 検索時のハイライト消す
noremap <silent> <C-c> :noh<CR>
noremap <silent> <C-e> :e!<CR>

" 最後にファイルタイプ関連を有効にする
filetype plugin indent on
