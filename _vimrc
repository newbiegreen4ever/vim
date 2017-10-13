" {{{ Basic setting
set nocompatible
filetype plugin on
" source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction
" }}}
" {{{ General setting 
set autowrite " enable autosave
set autochdir " change current directory to the file in buffer
set encoding      =utf-8
set fileencodings =utf-8,utf-16,big5,gb2312,gbk,gb18030,euc-jp,euc-kr,latin1

set lazyredraw " Don't redraw while executing macros (good performance config)

set magic " turn magic on for regular express
set mouse     =a " enable mouse support in console
set showcmd

" backup setting
" backupdir is where your backup files are kept
set backup
set writebackup
set backupdir =C:\\Users\\User\\Documents\\gVimPortable_backup
set directory =C:\\Users\\User\\Documents\\gVimPortable_backup\\temp
set confirm
set history   =500

set novisualbell " don't beep
set noerrorbells " don't beep
set textwidth =100 " show wrap sign at 100th character
set wildmenu
" }}}
" {{{ Visual setting
set t_Co=256	" enable 256-color support, nicer colors
colorscheme hydrangea
syntax on
set guifont=consolas:h14
set linespace=3
set cmdheight=2
set colorcolumn=+1
set cursorline	" show the current line
set cursorcolumn
" set foldcolumn=3 " add extra margin to the left
set number " show line numbers
set relativenumber " show relative line numbers
set ruler  
" set rulerformat            =%55(%{strftime('%a\ %b\ %e\ %I:%M\ %p')}\ %5l,%-6(%c%V%)\ %P%)
highlight CursorLine cterm   =bold ctermbg=DarkMagenta ctermfg=DarkMagenta
highlight CursorColumn cterm =reverse ctermbg=DarkMagenta ctermfg=DarkMagenta
highlight FoldColumn cterm   =none ctermbg=DarkGray ctermfg=White
" }}}
" {{{ Statusline setting
set laststatus=2 " show status line
" custom status line
set statusline=\PATH:\ %r%.20F\ \ \ \ 
set statusline+=\LINE:\ %03l/%03L\ \ \ 
set statusline+=%=
set statusline+=\TIME:\ %{strftime('%Y-%m-%d/%H:%M:%S')}
" }}}
" {{{ Search setting
set ignorecase
set smartcase
set incsearch " enable increased search
set hlsearch " highlight search result
" highlight Search cterm     =reverse ctermbg=none ctermfg=none
" }}}
" {{{ Indent setting
set expandtab
set autoindent
set smartindent
set smarttab
set tabstop                  =4
set shiftwidth               =4
" }}}
" {{{ Bracket setting
set showmatch
set mat=2 " How many tenths of a second to blink when matching brackets

vnoremap $1 <esc>`>a)<esc>`<i(<esc>
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $e <esc>`>a"<esc>`<i"<esc>

" Map auto complete of (, ", ', [
inoremap $1 ()<esc>i
inoremap $2 []<esc>i
inoremap $3 {}<esc>i
inoremap $4 {<esc>o}<esc>O
inoremap $q ''<esc>i
inoremap $e ""<esc>i

" }}}
" {{{ Mapping setting
let mapleader = "\<Space>"
set backspace=indent,eol,start

noremap <Ctrl> <Cap>

" swap ; and : 
nnoremap ; :
nnoremap : ;

" fj or jf to enter normal mode
inoremap fj <esc><esc>
inoremap jf <esc><esc>

" easier to switch windows
noremap <C-k> <C-w>k 
noremap <C-j> <C-w>j
noremap <C-h> <C-w>h
noremap <C-l> <C-w>l

" left right arrows for indentation
nmap <Left> <<
nmap <Right> >>
vmap <Left> <gv
vmap <Right> >gv

" move across tab with <tab> key
noremap <C-tab> gt
noremap <S-tab> gT

" apply macros
nnoremap Q @q
vnoremap :norm @q<cr> 
" {{{ Helper functions mapping
" toggle between absolute and relative line number by helper functions
noremap nm :call ToggleNumber()<CR>

" toggle netrw by helper functions 
noremap <Leader><Tab> :call VexToggle(getcwd())<CR>
noremap <Leader>` :call VexToggle("")<CR>
" }}}
" }}}
" {{{ Abbreviation

" timestamp
iab xdate <c-r>=strftime("%Y-%m-%d %H:%M:%S")<cr> 
iab clog console.log();
iab teh the
iab ... _****()_
" }}}
" {{{ Helper function
" {{{ ToggleNumber()
" toggle between number and relativenumber
function! ToggleNumber()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunction
"}}}
" {{{ AlignAssignments()
" align assignment 'x=7'
" https://www.ibm.com/developerworks/library/l-vim-script-4/index.html
function! AlignAssignments ()
    " Patterns needed to locate assignment operators...
    let ASSIGN_OP   = '[-+*/%|&]\?=\@<!=[=~]\@!'
    let ASSIGN_LINE = '^\(.\{-}\)\s*\(' . ASSIGN_OP . '\)\(.*\)$'
 
    " Locate block of code to be considered (same indentation, no blanks)...
    let indent_pat = '^' . matchstr(getline('.'), '^\s*') . '\S'
    let firstline  = search('^\%('. indent_pat . '\)\@!','bnW') + 1
    let lastline   = search('^\%('. indent_pat . '\)\@!', 'nW') - 1
    if lastline < 0
        let lastline = line('$')
    endif
 
    " Decompose lines at assignment operators...
    let lines = []
    for linetext in getline(firstline, lastline)
        let fields = matchlist(linetext, ASSIGN_LINE)
        if len(fields) 
            call add(lines, {'lval':fields[1], 'op':fields[2], 'rval':fields[3]})
        else
            call add(lines, {'text':linetext,  'op':''                         })
        endif
    endfor
 
    " Determine maximal lengths of lvalue and operator...
    let op_lines = filter(copy(lines),'!empty(v:val.op)')
    let max_lval = max( map(copy(op_lines), 'strlen(v:val.lval)') ) + 1
    let max_op   = max( map(copy(op_lines), 'strlen(v:val.op)'  ) )
 
    " Recompose lines with operators at the maximum length...
    let linenum = firstline
    for line in lines
        let newline = empty(line.op)
        \ ? line.text
        \ : printf("%-*s%*s%s", max_lval, line.lval, max_op, line.op, line.rval)
        call setline(linenum, newline)
        let linenum += 1
    endfor
endfunction
" }}}
" {{{ Vex - netrw
    let g:netrw_liststyle = 3
    let g:netrw_banner = 0

    function! VexToggle(dir)
        if exists("t:vex_buf_nr")
            call VexClose()
        else
            call VexOpen(a:dir)
        endif
    endfunction

    function! VexOpen(dir)
        let g:netrw_browse_split = 4 " open files in previous windoe
        let vex_width = 25

        execute "Vexplore " . a:dir
        let t:vex_buf_nr = bufnr("%")
        wincmd H

        call VexSize(vex_width)
    endfunction

    function! VexClose()
        let cur_win_nr = winnr()
        let target_nr = ( cur_win_nr == 1 ? winnr("#") : cur_win_nr)

        1wincmd w
        close
        unlet t:vex_buf_nr

        execute (target_nr - 1) . "wincmd w"
        call NormalizeWidths()
    endfunction

    function! VexSize(vex_width)
        execute "vertical resize" . a:vex_width
        set winfixwidth
        call NormalizeWidths()
    endfunction

    function! NormalizeWidths()
        let eadir_pref = &eadirection
        set equalalways
        " set eadirection = hor
        let &eadirection = eadir_pref
    endfunction
    " }}}
" {{{ TrimWhitespace()
fun! TrimWhitespace()
    let l:save = winsaveview()
    %s/\s\+$//e
    call winrestview(l:save)
endfun
    " }}}
" }}}
"{{{ Autocmd
" augroup align
    " autocmd!
    " autocmd BufWritePre,FileWritePre,FileAppendPre  *  :call AlignAssignments()
" augroup END
"}}}
" {{{ Plugin setting

" nathanaelkane/vim-indent-guides
"""""""""""""""""""""""""""""""""
" enable default mapping <leader>ig
let g:indent_guides_default_mapping = 1 

" exclude filetypes
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'text', 'markdown']

" mattn/emmet-vim
"""""""""""""""""""""""""""""""""
" enable all function in all mode
let g:user_emmet_mode='a'    

" enable just for html/css
" let g:user_emmet_install_global = 0
" autocmd FileType html,css EmmetInstal

" remap the default <C-Y> leader
" let g:user_emmet_leader_key='<C-M>'

" vimwiki/vimwiki
"""""""""""""""""""""""""""""""""
let wiki_1 = {}
let wiki_1.path = 'C:\Users\User\Desktop\JD2017-18_T1\vimwiki-cujdT1'
" markdown to HTML is not suuported by vimwiki yet
" let wiki_1.path_html = '~/vimwiki/vimwiki-personal_html/' 
let wiki_1.syntax = 'markdown'
let wiki_1.ext = '.md'

let wiki_2 = {}
let wiki_2.path = 'C:\Users\User\Documents\gVimPortable\vimwiki\vimwiki-coding'
" markdown to HTML is not suuported by vimwiki yet
" let wiki_1.path_html = '~/vimwiki/vimwiki-personal_html/' 
let wiki_2.syntax = 'markdown'
let wiki_2.ext = '.md'

let wiki_3 = {}
let wiki_3.path = 'C:\Users\User\Documents\gVimPortable\vimwiki\vimwiki-scrapbook'
"let wiki_2.path_html = '~/vimwiki/vimwiki-coding_html/'
let wiki_3.syntax = 'markdown'
let wiki_3.ext = '.md'

let g:vimwiki_list = [wiki_1, wiki_2, wiki_3]
" }}}
" {{{ Folding setting
set foldmethod=marker
set foldlevel=0
set modelines=1
"
" enable markdown folding 
let g:markdown_folding=1 
" }}}
"vim:foldmethod=marker:foldlevel=0

