syntax on " シンタックスハイライトを有効にする
set nocompatible " vi互換を無くす
set modifiable
set write
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
set showmatch " 対応する括弧のハイライト表示する
set showmode " モード表示する
set title " 編集中のファイル名を表示する
set ruler " ルーラーの表示する
set t_Co=256 " 256色
set background=dark " 背景
set tabstop=2 " タブを表示するときの幅
set expandtab " タブ文字挿入"
set shiftwidth=2 " タブを挿入するときの幅
set showcmd " コマンド表示
set clipboard=unnamed,autoselect " クリップボードにコピーされる"
set mouse=a " マウス操作可能にする
set ttymouse=xterm2 " 端末vimでマウスを使う
set guioptions+=a " クリップボード連携
set noswapfile " swpファイル作らない
set noundofile " undo情報を保持するファイルを作らない
set nobackup " バックアップを作らない
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
set autoread
set vb t_vb=

" ファイル変更後の自動更新
augroup vimrc-checktime
  autocmd!
  autocmd WinEnter * checktime
augroup END

" コメント行から改行した行をコメントにしないようにする
augroup auto_comment_off
  autocmd!
  autocmd BufEnter * setlocal formatoptions-=r
  autocmd BufEnter * setlocal formatoptions-=o
augroup END

" 行末の空白を除去する処理。
function! RemoveBlank()
  " 改行する度に行末のスペース削除
  call smartinput#define_rule({
        \ 'at': '\s\+\%#',
        \ 'char': '<CR>',
        \ 'input': "<C-o>:call setline('.', substitute(getline('.'), '\\s\\+$', '', ''))<CR><CR>",
        \ })
endfunction

" autocmd BufReadPre * call RemoveBlank()

" jbuilderをrubyシンタックスとして見るようにする
au BufNewFile,BufRead *.json.jbuilder set ft=ruby

" commitメッセージを日本語で書くとエラーが起きる現象の対応
au BufNewFile,BufRead COMMIT_EDITMSG set fileencoding=utf-8 encoding=utf-8 filetype=gitcommit

" goのインデント設定
au BufNewFile,BufRead *.go set noexpandtab tabstop=4 shiftwidth=4

" ---見た目---
highlight CursorLine cterm=underline
let loaded_matchparen = 1 " 対応カッコの強調表示解除
