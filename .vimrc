set whichwrap=b,s,h,l,<,>,[,] " 行を跨いで移動出来る様にする
set virtualedit=block " 短形選択の時便利なやつ
syntax on " シンタックスハイライトを有効にする
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
set noswapfile " swpフィアル作らない
set pastetoggle=<C-p> " pasteモードの切替
" コメント行から改行した行をコメントにしないようにする
augroup auto_comment_off
  autocmd!
  autocmd BufEnter * setlocal formatoptions-=r
  autocmd BufEnter * setlocal formatoptions-=o
augroup END

" ハイライト設定
hi MatchParen cterm=bold ctermbg=darkgray 

" カーソルライン
hi LineNr ctermbg=0 ctermfg=0
hi CursorLineNr ctermbg=4 ctermfg=0
set cursorline
hi clear CursorLine

colorscheme jellybeans 

autocmd InsertCharPre <buffer> if v:char == '　' | let v:char = " " | endif  " 全角スペースを全部半角スペースに変換

" NeoBundle起動
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#begin(expand('~/.vim/bundle/'))
  NeoBundleFetch 'Shougo/neobundle.vim'
  call neobundle#end()
endif

" ここにインストールしたいプラグインのリストを書く
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/neocomplcache.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'jistr/vim-nerdtree-tabs'
NeoBundle 'Lokaltog/powerline'
NeoBundle 'git://github.com/scrooloose/syntastic.git'
NeoBundle 'Townk/vim-autoclose'
NeoBundle 'kana/vim-smartinput'
NeoBundle 'cohama/vim-smartinput-endwise'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tmhedberg/matchit'
NeoBundle 'jelera/vim-javascript-syntax', {'autoload':{'filetypes':['javascript']}}
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kana/vim-textobj-entire'
NeoBundle 'rking/ag.vim'
NeoBundle 'kchmck/vim-coffee-script'
" smartinput-endwise
call smartinput_endwise#define_default_rules() "上の呼び出し"
filetype plugin on
filetype indent on

" ファイル指定で開かれた場合はNERDTreeは表示しない
if !argc()
  autocmd vimenter * NERDTree|normal gg3j
endif
" NERDTreeだけの場合は勝手に閉じる
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" unite, ag
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
function! s:unite_my_settings()"{{{
    " ESCでuniteを終了
    nmap <buffer> <ESC> <Plug>(unite_exit)
endfunction"}}}

" neocomplcache
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
" 移動系
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
noremap <C-h> ^
nnoremap <C-l> $
vnoremap <C-l> $h
noremap <C-j> <C-d>
noremap <C-k> <C-u>
noremap <C-w><C-g> <C-w>t
noremap <C-w>g <C-w>t
" vimrc更新
nnoremap <C-[> :source ~/.vimrc<CR> 
" NERDTree起動ショートカット
nnoremap <silent> <C-@> :NERDTreeToggle<CR> 
" NERDTree閉じて起動した後にウインドウを均等にしてくれるコマンド
nnoremap <C-w>. <C-w>t<C-w>l15<C-w>>

let loaded_matchparen = 1 " 対応カッコの強調表示解除
let g:syntastic_enable_signs=1 " syntastic入れるのに必要
let g:syntastic_auto_loc_list=2 " syntastic入れるのに必要
let NERDTreeShowHidden=1 " NERDTreeでdotfile表示

" rubyのdo~end間移動を%で対応（あんまり正確じゃないっぽい）
source $VIMRUNTIME/macros/matchit.vim
augroup matchit
  au!
  au FileType ruby let b:match_words = '\<\(module\|class\|def\|begin\|do\|if\|unless\|case\)\>:\<\(elsif\|when\|rescue\)\>:\<\(else\|ensure\)\>:\<end\>'
augroup END

