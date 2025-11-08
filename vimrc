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

let g:did_indent_on = 0

" Vim Language Server Protocol

" pip install python-lsp-server
if executable('pylsp')
	au User lsp_setup call lsp#register_server({'name': 'pylsp', 'cmd': {server_info->['pylsp']}, 'allowlist': ['python']})
endif

let compile_commands = findfile('compile_commands.json', 'build;')
if !empty(compile_commands) && executable('clangd')
	let s:compile_commands_dir = fnamemodify(compile_commands, ':p:h')

	au User lsp_setup call lsp#register_server({'name': 'clangd', 'cmd': {server_info->['clangd', '--background-index', '--compile-commands-dir=' . s:compile_commands_dir]}, 'allowlist': ['c', 'cpp', 'objc', 'objcpp']})
endif

function! s:on_lsp_buffer_enabled() abort
	setlocal omnifunc=lsp#complete
	if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif

	nmap <buffer> gd <plug>(lsp-definition)
	nmap <buffer> gr <plug>(lsp-references)
	nmap <buffer> K <plug>(lsp-hover)
endfunction

augroup lsp_install
	au!
	au User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" Enable native lsp client support
let g:lsp_use_native_client = has('patch-8.2.4780')
" Delay milliseconds to highlight references.
let g:lsp_document_highlight_delay = 1000
" Disable code action signs
let g:lsp_document_code_action_signs_enabled = 0
" Disable diagnostics signs
let g:lsp_diagnostics_signs_enabled = 0
