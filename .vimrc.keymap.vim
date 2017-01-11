" ---キーバインド---
inoremap <C-b> <Left>
inoremap <C-f> <Right>
vnoremap $ $h

nnoremap <C-[> :! ctags --langmap=RUBY:.rb --exclude="*.js"  --exclude=".git*" -R .<CR>
" 検索時のハイライト消す
noremap <silent> <C-c> :noh<CR>
" ファイル更新
noremap <silent> <C-e> :e!<CR>
" 検索はvery magicで
nnoremap / /\v
