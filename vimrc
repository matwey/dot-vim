" enable syntax highlighting
syntax on

" show matching brackets
set showmatch

" get easier to use and more user friendly vim defaults
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Changed default required by SuSE security team--be aware if enabling this
" that it potentially can open for malicious users to do harmful things.
set nomodeline

" enable 256 colors in vim
set t_Co=256

" always display the status line, even if only one window is displayed
set laststatus=2

let g:airline#extensions#tabline#enabled = 1
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
set tags=tags;/
function! LoadCscope()
	let db = findfile("cscope.out", ".;")
	if (!empty(db))
		let path = strpart(db, 0, match(db, "/cscope.out$"))
		set nocscopeverbose " suppress 'duplicate connection' error
		exe "cs add " . db . " " . path
		set cscopeverbose
		set csto=0
	endif
endfunction
au BufEnter /* call LoadCscope()

let g:did_indent_on = 0
