" 基本設定

set laststatus=2 " 編集中のファイル名を常に表示
set whichwrap=b,s,h,l,<,>,[,] " 行を跨いで移動出来る様にする
set virtualedit=block " 短形選択の時便利なやつ
set encoding=utf-8 " デフォルトの文字コード
set fileencoding=utf-8 " ファイルの文字コード
set ffs=unix,dos,mac  " 改行文字
set smartindent " 新しい行を開始した時に、新しい行のインデントを現在行と同じ量にする
set wrap " 検索がファイル末尾まで行ったら最初に戻る
set wildmenu    " コマンドの補完候補を表示
set number " 行番号を表示する
set incsearch " インクリメンタルサーチ
set showmode " モード表示する
set title " 編集中のファイル名を表示する
set t_Co=256 " 256色
set clipboard+=unnamedplus " クリップボードにコピー"
set mouse=a " マウス操作可能にする
set noswapfile " swpファイル作らない
set noundofile " undo情報を保持するファイルを作らない
set nobackup " バックアップを作らない
set pastetoggle=<C-^> " pasteモードの切替
set hlsearch " 検索結果のハイライト
set termguicolors

" dein.vimの設定

if &compatible
  set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

  call dein#load_toml(expand('~/.config/nvim') . '/dein.toml', {'lazy': 0})
  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable
colorscheme tender

" キーバインド

inoremap <C-b> <Left>
inoremap <C-f> <Right>
vnoremap $ $h
noremap <silent> <C-c> :noh<CR>
nnoremap / /\v
