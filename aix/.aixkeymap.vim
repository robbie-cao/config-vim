" ========================= KeyFire Setting Start =========================

" -------------- Tooling Function Binding ------------------

" Lookup HighLight Syntax Define
function! <SID>SynStack()
	echo map(synstack(line('.'),col('.')),'synIDattr(v:val, "name")')
endfunc

" Return indent (all whitespace at start of a line), converted from
" tabs to spaces if what = 1, or from spaces to tabs otherwise.
" When converting to tabs, result has no redundant spaces.
function! Indenting(indent, what, cols)
	let spccol = repeat(' ', a:cols)
	let result = substitute(a:indent, spccol, '\t', 'g')
	let result = substitute(result, ' \+\ze\t', '', 'g')
	if a:what == 1
		let result = substitute(result, '\t', spccol, 'g')
	endif
	return result
endfunction

" Convert whitespace used for indenting (before first non-whitespace).
" what = 0 (convert spaces to tabs), or 1 (convert tabs to spaces).
" cols = string with number of columns per tab, or empty to use 'tabstop'.
" The cursor position is restored, but the cursor will be in a different
" column when the number of characters in the indent of the line is changed.
function! IndentConvert(line1, line2, what, cols)
	let savepos = getpos('.')
	let cols = empty(a:cols) ? &tabstop : a:cols
	execute a:line1 . ',' . a:line2 . 's/^\s\+/\=Indenting(submatch(0), a:what, cols)/e'
	call histdel('search', -1)
	call setpos('.', savepos)
endfunction

" Space2Tab
" Tab2Space
" RetabIndent
command! -nargs=? -range=% Space2Tab call IndentConvert(<line1>,<line2>,0,<q-args>)
command! -nargs=? -range=% Tab2Space call IndentConvert(<line1>,<line2>,1,<q-args>)
command! -nargs=? -range=% RetabIndent call IndentConvert(<line1>,<line2>,&et,<q-args>)

" -------------- Tooling Function Ending ------------------

nnoremap <F2> :NERDTreeToggle<CR>
nnoremap <F3> :TableModeToggle<CR>
nnoremap <F4> :exec exists('syntax_on') ? 'syn off': 'syn on'<CR>
nnoremap <F5> :TagbarToggle<CR>
nnoremap <F6> :SyntasticToggleMode <CR>
nnoremap <F7> :GundoToggle<CR>
nnoremap <F8> mzgg=G`z
nnoremap <F9> ggVG:RetabIndent<CR>
" Full Fucking Window ^M ending line file!
nnoremap <F10> :%s/

" Normal Key Map
nnoremap U :redo<CR>
nnoremap Q :q!<CR>
nnoremap W :w!<CR>

" Window VertSplit switcher
nnoremap <leader>h  <C-w>h
nnoremap <leader>hh <C-w>h
nnoremap <leader>j  <C-w>j
nnoremap <leader>jj <C-w>j
nnoremap <leader>k  <C-w>k
nnoremap <leader>kk <C-w>k
nnoremap <leader>l  <C-w>l
nnoremap <leader>ll <C-w>l

" Set as toggle foldcomment
nnoremap zc @=((foldclosed(line('.')) < 0) ? 'zc' :'zo')<CR>
nnoremap zc @=((foldclosed(line('.')) < 0) ? 'zc' :'zo')<CR>
nnoremap zr zR
" Fast searcher
nnoremap z, :FZF --no-mouse .<CR>

nnoremap ' `
nnoremap ` '
nnoremap <silent> zj o<ESC>k
nnoremap <silent> zk O<ESC>j

" Format Jump
nnoremap <silent> g; g;zz
nnoremap <silent> g: g:zz

" Smooth Scroll the terminal
nnoremap <silent> <C-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
nnoremap <silent> <C-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>

" Cursor Moving
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

inoremap <M-h> <Left>
inoremap <M-j> <Down>
inoremap <M-k> <Up>
inoremap <M-l> <Right>

cnoremap <A-j> <Down>
cnoremap <A-k> <Up>
cnoremap <A-h> <Left>
cnoremap <A-l> <Right>

cnoremap <M-j> <Down>
cnoremap <M-k> <Up>
cnoremap <M-h> <Left>
cnoremap <M-l> <Right>

" Like Emacs
inoremap <C-e> <End>
inoremap <C-b> <Home>

inoremap <M-e> <End>
inoremap <M-b> <Home>

" Buftabline Config
nnoremap <A-j> :bnext<CR>
nnoremap <A-k> :bprev<CR>
nnoremap <A-l> :bnext<CR>
nnoremap <A-h> :bprev<CR>
nnoremap <A-x> :bdelete<CR>
nnoremap <A-w> :bwipeout<CR>

nnoremap <M-j> :bnext<CR>
nnoremap <M-k> :bprev<CR>
nnoremap <M-l> :bnext<CR>
nnoremap <M-h> :bprev<CR>
nnoremap <M-x> :bdelete<CR>
nnoremap <M-w> :bwipeout<CR>

" Check Vim Syntax name Fn
nnoremap <leader>yi :call <SID>SynStack()<CR>
nnoremap <leader>w  :w!<CR>
nnoremap <leader>q  :q<CR>
nnoremap <leader>hs :MRU<CR>

" Command
nnoremap <leader>cd :cd %:p:h<CR>
nnoremap <leader>cx :%s///gm

noremap <silent> <C-v> <ESC>"+gpi
" repeat Prev Command
nnoremap <leader>. @:
vnoremap <leader>. :normal .<CR>

" Unite file configure
" Ag searcher
nnoremap <leader>uf :Unite -buffer-name=files -start-insert file_rec/async:!<CR>
nnoremap <leader>ug :Unite grep:.<CR>
nnoremap <leader>ub :Unite file buffer<CR>
nnoremap <leader>vf :VimFiler<CR>

" Split faster
nnoremap <leader>\ :vs<CR>
nnoremap <leader>- :sp<CR>
" End Split

" first to copy files path
" copy path
nnoremap <leader>p "+gp
vnoremap <Leader>p "+p
vnoremap <leader>y "+y
vnoremap <Leader>d "+d
nnoremap <leader>cp :let @+=expand("%:p")<CR>:echo "Copied current file
			\ path '".expand("%:p")."' to clipboard"<CR>

" Vundle keyfire
nnoremap <leader>vi :PluginInstall<CR>
nnoremap <leader>vu :PluginUpdate<CR>

" Tabluer Format
vnoremap <leader>t :Tabularize/
vnoremap <leader>t= :Tabularize/=<CR>
vnoremap <leader>t, :Tabularize/,<CR>
vnoremap <leader>t: :Tabularize/:<CR>
vnoremap <leader>t; :Tabularize/;<CR>

" <leader>s: Spell checking shortcuts
" fold enable settings
nnoremap <leader>ss :setlocal spell!<CR>
nnoremap <leader>sj ]szz
nnoremap <leader>sk [szz
nnoremap <leader>sa zg]szz
nnoremap <leader>sd 1z=
nnoremap <leader>sf z=
"Vim Shell Faster
nnoremap <leader>sh :VimShell<CR>

" Multi Cursor Find
vnoremap <leader>mf :MultipleCursorsFind 

" Multi Expand Region
map K <Plug>(expand_region_expand)
map J <Plug>(expand_region_shrink)

" For Git fire
nnoremap <leader>gs : Gstatus<CR>
nnoremap <leader>gc : Gcommit
nnoremap <leader>gb : Gblame
nnoremap <leader>gv : Gitv<CR>
nnoremap <leader>gp : Git push origin master<CR>
nnoremap <leader>gu : Git pull -u<CR>

" For SVN fire
nnoremap <leader>sc :!svn ci -m ""<CR>
nnoremap <leader>su :!svn up<CR>
nnoremap <leader>st :!svn st<CR>

" Editor dotfile
nnoremap <leader>en :e! ~/.nvimrc<CR>
nnoremap <leader>ev :e! ~/.vimrc<CR>

" Incsearch
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

map n <Plug>(incsearch-nohl-n)zzzv
map N <Plug>(incsearch-nohl-N)zzzv
"map * <Plug>(incsearch-nohl-*)zzzv
"map # <Plug>(incsearch-nohl-#)zzzv
map g* <Plug>(incsearch-nohl-g*)zzzv
map g# <Plug>(incsearch-nohl-g#)zzzv

" Mark vim Plugin
nnoremap <Leader>M <Plug>MarkToggle
nnoremap <Leader>N <Plug>MarkAllClear

"Sneak
"replace 'f' with 1-char Sneak
"nmap f <Plug>Sneak_f
"nmap F <Plug>Sneak_F
"xmap f <Plug>Sneak_f
"xmap F <Plug>Sneak_F
"omap f <Plug>Sneak_f
"omap F <Plug>Sneak_F
"replace 't' with 1-char Sneak
"nmap t <Plug>Sneak_t
"nmap T <Plug>Sneak_T
"xmap t <Plug>Sneak_t
"xmap T <Plug>Sneak_T
"omap t <Plug>Sneak_t
"omap T <Plug>Sneak_T

" ========================= KeyFire Setting End =========================