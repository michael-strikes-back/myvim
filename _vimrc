" a huge mess; not much of value here.

if has("win32")
	source $VIMRUNTIME/../_vimrc
	colorscheme zenburn
endif

set nobackup
set noswapfile
set noundofile
if has("gui_running")
	set guioptions -=T
	if has("win32")
		set guifont=Consolas:h10
	endif
	set lines=80
	set columns=140
endif
set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab
set nu
set autoindent
set copyindent
set preserveindent
set textwidth=0 
set hlsearch
set vb
set fo-=t

au BufRead,BufNewFile *.txt set lbr

" newlines in command mode
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

nnoremap @p4a :!p4 add %
nnoremap @p4e :!p4 edit %
nnoremap @p4d :!p4 diff %
nnoremap <C-A> :exe SetCoMaxLine()<CR>

" easier split navigation
nnoremap <C-j> <C-W><C-J>
nnoremap <C-k> <C-W><C-K>
nnoremap <C-l> <C-W><C-L>
nnoremap <C-h> <C-W><C-H>

" my personal log quick helper
nnoremap <C-n><C-d><C-l> :call NewDailyLog()<CR>

" swap lines
nnoremap <M-j> :m .+1<CR>
nnoremap <M-k> :m .-2<CR>

" $TODO - search shortcuts
" nnoremap <F3> 
" nnoremap <C-F3> 

" FUNCTIONS BELOW

function! GetCurrentPath()
	return expand('%:p:h')
endfunction

function! GetMaxLineLength()
  return max(map(range(1, line('$')), "virtcol([v:val, '$'])"))
endfunction

function! SetCoMaxLine()
  " $NOTE - not sure why +3
  let maxLineLength = (GetMaxLineLength()+3)
  " $TODO somehow query full screen column count without going full screen?
  let maxLineLength = max([min([maxLineLength, 260]), 80])
  exe ("set co=" . maxLineLength)
endfunction

function! NewDailyLog()
	" capture position data
	let pos = getpos('.')

	" write some lines
	let lines = [
\		'-----',
\		strftime('%m/%d'),
\		'-----',
\		'',
\		'] ',
\		''
\	]
	call append (line('.'), lines)

	" set cursor to the line with the ]
	let newEntryIndex = index(lines, '] ')
	" $HACK! not sure how otherwise to edit position
	let pos[1] += newEntryIndex + 1
	let pos[2] += len(lines[newEntryIndex]) + 2
	call setpos('.', pos)
endfunction

function! ToPascalCase()
	" $TODO - stub
endfunction
