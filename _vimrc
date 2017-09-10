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
set encoding=utf-8
set fileencodings=utf-8,utf-16,big5,gb2312,gbk,gb18030,euc-jp,euc-kr,latin1

set lazyredraw " Don't redraw while executing macros (good performance config)

set magic " turn magic on for regular express
set mouse=a " enable mouse support in console
set showcmd

set backup
set writebackup
set backupdir=C:\\Users\\User\\Documents\\gVimPortable_backup
set directory=C:\\Users\\User\\Documents\\gVimPortable_backup\\temp
set confirm
set history=100

set novisualbell " don't beep
set noerrorbells " don't beep

set wildmenu
" }}}
" {{{ Visual setting
set t_Co=256	" enable 256-color support, nicer colors
colorscheme dracula
syntax on
set guifont=consolas:h14
set linespace=3
set cmdheight=2
set cursorline	" show the current line
set cursorcolumn
" set foldcolumn=3 " add extra margin to the left
set number " show line numbers
set relativenumber " show relative line numbers
set ruler  
" set rulerformat=%55(%{strftime('%a\ %b\ %e\ %I:%M\ %p')}\ %5l,%-6(%c%V%)\ %P%)
highlight CursorLine cterm=bold ctermbg=DarkMagenta ctermfg=DarkMagenta
highlight CursorColumn cterm=reverse ctermbg=DarkMagenta ctermfg=DarkMagenta
highlight FoldColumn cterm=none ctermbg=DarkGray ctermfg=White
" }}}
" {{{ Statusline setting
set laststatus=2 " show status line
" custom status line
set statusline=\PATH:\ %r%F\ \ \ \ \LINE:\ %l/%L/%P\ TIME:\ %{strftime('%Y-%m-%d/%H:%M:%S')}
" }}}
" {{{ Search setting
set ignorecase
set smartcase
set incsearch " enable increased search
set hlsearch " highlight search result
" highlight Search cterm=reverse ctermbg=none ctermfg=none
" }}}
" {{{ Indent setting
set expandtab
set autoindent
set smartindent
set smarttab
set tabstop=4
set shiftwidth=4
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

" }}}zo
" {{{ Mapping setting
let mapleader = "\<Space>"
set backspace=indent,eol,start
" swap ; and : 
nnoremap ; :
nnoremap : ;
" }}}
" {{{ Abbreviation

iab xdate <c-r>=strftime("%y-%m-%d %H:%M:%S")<cr>
iab clog console.log();
iab teh the

" }}}
" {{{ Helper functions

" toggle between number and relativenumber
function! ToggleNumber()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunc

" strips trailing whitespace at the end of files. this
" is called on buffer write in the autogroup above.
function! <SID>StripTrailingWhitespaces()
    " save last search & cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction
" }}}
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
let g:user_emmet_install_global = 0 "
autocmd FileType html,css EmmetInstal

" remap the default <C-Y> leader
let g:user_emmet_leader_key='<C-M>'

" vimwiki/vimwiki
"""""""""""""""""""""""""""""""""
let wiki_1 = {}
let wiki_1.path = 'C:\Users\User\Documents\gVimPortable\vimwiki\vimwiki-coding'
" markdown to HTML is not suuported by vimwiki yet
" let wiki_1.path_html = '~/vimwiki/vimwiki-personal_html/' 
let wiki_1.syntax = 'markdown'
let wiki_1.ext = '.md'

let wiki_2 = {}
let wiki_2.path = 'C:\Users\User\Documents\gVimPortable\vimwiki\vimwiki-clipbook'
"let wiki_2.path_html = '~/vimwiki/vimwiki-coding_html/'
let wiki_2.syntax = 'markdown'
let wiki_2.ext = '.md'

let g:vimwiki_list = [wiki_1, wiki_2]
" }}}
" {{{ Folding setting

set foldmethod=marker
set foldlevel=0
set modelines=1

" }}}
" vim:foldmethod=marker:foldlevel=0


