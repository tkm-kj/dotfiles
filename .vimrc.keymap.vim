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
inoremap <C-h> <BS>
inoremap <C-d> <DEL>
inoremap <C-l> <Right>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-n> <Down>
inoremap <C-p> <Up>
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

" 編集系
noremap c<C-h> c^
noremap c<C-l> c$

nnoremap <C-[> :! ctags --langmap=RUBY:.rb --exclude="*.js"  --exclude=".git*" -R .<CR>
" NERDTree起動ショートカット && 画面を均等に
nnoremap <silent> <C-@> :NERDTreeToggle<CR><C-w>=
" 検索時のハイライト消す
noremap <silent> <C-c> :noh<CR>
" ファイル更新
noremap <silent> <C-e> :e!<CR>
" 検索はvery magicで
nnoremap / /\v
