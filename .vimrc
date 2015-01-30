set whichwrap=b,s,h,l,<,>,[,] "行を跨いで移動出来る様にする

set virtualedit=block
syntax on "シンタックスハイライトを有効にする
set encoding=utf-8 "デフォルトの文字コード
set ffs=unix,dos,mac 
" set fileencoding=utf-8
set smartindent "新しい行を開始した時に、新しい行のインデントを現在行と同じ量にする
set cindent "Cプログラムの自動インデント
set wrap "検索がファイル末尾まで行ったら最初に戻る
set wildmenu    "コマンドの補完候補を表示
set number "行番号を表示する
set incsearch "インクリメンタルサーチ
set ignorecase "検索時に大文字小文字を無視する
set showmatch "対応する括弧のハイライト表示する
set showmode "モード表示する
set title "編集中のファイル名を表示する
set ruler "ルーラーの表示する
set t_Co=256
set background=dark
set tabstop=2 "タブを表示するときの幅
set autoindent "オートインデント
set expandtab "タブ文字挿入"
set shiftwidth=2 "タブを挿入するときの幅
set showcmd "コマンド表示
set clipboard+=unnamed "クリップボードにコピーされる
set nocompatible
"マウス操作可能にする
set mouse=a
set ttymouse=xterm2
set guioptions+=a
set noswapfile
"ハイライト設定
hi MatchParen cterm=bold ctermbg=darkgray 
colorscheme jellybeans

"neobundle
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#begin(expand('~/.vim/bundle/'))
  NeoBundleFetch 'Shougo/neobundle.vim'
  call neobundle#end()
endif

" ここにインストールしたいプラグインのリストを書く
NeoBundle 'Shougo/unite.vim'
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'Align'
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
"smartinput-endwise
call smartinput_endwise#define_default_rules() "上の呼び出し"
filetype plugin on
filetype indent on

" ファイル指定で開かれた場合はNERDTreeは表示しない
if !argc()
  autocmd vimenter * NERDTree|normal gg3j
endif
" NERDTreeだけの場合は勝手に閉じる
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

"削除
nnoremap d "1d
vnoremap d "1d
vnoremap x "1d
"コピーで常にヤンクしたものを貼り付けられる
nnoremap p "0p
"直近にデリートした行をペーストする
nnoremap dp "1p
"コピーで常にヤンクしたものを貼り付けられる
nnoremap P "0P
"直近にデリートした単語をペーストする
nnoremap dP "1P
"通常移動に関して
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
"NERDTree起動ショートカット
nnoremap <silent> <C-@> :NERDTreeToggle<CR> 
let loaded_matchparen = 1 "対応カッコの強調表示解除
let g:syntastic_enable_signs=1 "syntastic入れるのに必要
let g:syntastic_auto_loc_list=2 "syntastic入れるのに必要
let NERDTreeShowHidden=1 "NERDTreeでdotfile表示
"rubyのdo~end間移動を%で対応（あんまり正確じゃないっぽい）
source $VIMRUNTIME/macros/matchit.vim
augroup matchit
  au!
  au FileType ruby let b:match_words = '\<\(module\|class\|def\|begin\|do\|if\|unless\|case\)\>:\<\(elsif\|when\|rescue\)\>:\<\(else\|ensure\)\>:\<end\>'
augroup END

