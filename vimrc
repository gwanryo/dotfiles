"""""""""""""""""
" Sets          "
"""""""""""""""""
filetype plugin indent on
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab
set smartindent autoindent number title cursorline
set incsearch ignorecase smartcase hlsearch
set ruler laststatus=2 showcmd showmode
set list listchars=trail:»,tab:»-
set fillchars+=vert:\ 
set wrap breakindent
set encoding=utf-8
set fileencoding=utf-8

" Remove ALL autocommands for the current group. This prevents having the
" autocommands defined twice (e.g., after sourcing the .vimrc file again).
autocmd!

"""""""""""""""""
" Shortcuts     "
"""""""""""""""""
" Save
nnoremap <silent> <C-S> :w<cr>

" NERDTree
nnoremap <C-t> :NERDTreeToggle<CR>

" Page navigation
nnoremap <C-Up> <C-u>
nnoremap <C-Down> <C-d>

" Easier window navigation
nnoremap <A-Left> <C-w>h
nnoremap <A-Up> <C-w>j
nnoremap <A-Down> <C-w>k
nnoremap <A-Right> <C-w>l

" Git
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>ga :Gwrite<CR>
noremap <Leader>gc :Gcommit<CR>
noremap <Leader>gsh :Gpush<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gr :Gremove<CR>
noremap <Leader>gll :Gpull<CR>
noremap <Leader>gd :Gvdiff<CR>

" Asyncrun
augroup vimrcCompileMap
  autocmd FileType c noremap <silent> <C-b> :AsyncRun gcc -Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
  autocmd FileType c noremap <silent> <F5> :AsyncRun -raw -cwd=$(VIM_FILEDIR) -mode=term "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
  autocmd FileType cpp noremap <silent> <C-b> :AsyncRun g++ -Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
  autocmd FileType cpp noremap <silent> <F5> :AsyncRun -raw -cwd=$(VIM_FILEDIR) -mode=term "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
  autocmd FileType python map <F5> :AsyncRun -mode=term -raw python3 % <cr>
  autocmd FileType javascript map <F5> :AsyncRun -mode=term -raw node % <cr>
augroup END

"""""""""""""""""
" Plugins       "
"""""""""""""""""
call plug#begin()
  " Theme
  Plug 'junegunn/seoul256.vim'
  " nerdtree
  Plug 'preservim/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  " devicons
  Plug 'ryanoasis/vim-devicons'
  " airline
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  " Tag appender
  Plug 'Raimondi/delimitMate'
  " Runner
  Plug 'skywind3000/asyncrun.vim'
  " Lint
  Plug 'dense-analysis/ale'
  Plug 'davidhalter/jedi-vim'
call plug#end()

"""""""""""""""""
" Plugin Config "
"""""""""""""""""
""" NERDTree """
" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
  \ quit | endif

" Config
let NERDTreeShowHidden=1
let g:NERDTreeDirArrowExpandable = '↠'
let g:NERDTreeDirArrowCollapsible = '↡'
let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }
""""""""""""""""

""" Airline """
let g:airline_powerline_fonts = 1
let g:airline_section_z = ' %{strftime("%-I:%M %p")}'
let g:airline_section_warning = ''
"""""""""""""""

""" delimitMate """
let g:delimitMate_autoclose = 1
let g:delimitMate_matchpairs = "(:),[:],{:},<:>"
let g:delimitMate_jump_expansion = 1
let g:delimitMate_expand_space = 1
let g:delimitMate_expand_cr = 2
let g:delimitMate_expand_inside_quotes = 1
"""""""""""""""""""

""" Asyncrun """
" open quickfix window automatically when AsyncRun is executed
" set the quickfix window 6 lines height.
let g:asyncrun_open = 6

" ring the bell to notify you job finished
let g:asyncrun_bell = 1

" F10 to toggle quickfix window
nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr>
""""""""""""""""

""" Ale """
let g:ale_lint_on_save = 1
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'
let g:ale_statusline_format =[' %d E ', ' %d W ', '']
"""""""""""

""" jedi-vim """
" let g:jedi#show_call_signatures=0
" let g:jedi#popup_select_first="0"
" let g:jedi#force_py_version=3
""""""""""""""""

"""""""""""""""""
" Global Config "
"""""""""""""""""
""" Indent """
augroup vimrc-javascript
  autocmd!
  autocmd FileType javascript set tabstop=2|set shiftwidth=2|set expandtab softtabstop=2 smartindent
  autocmd FileType vue set tabstop=2|set shiftwidth=2|set expandtab softtabstop=2 smartindent
  autocmd FileType jsx set tabstop=2|set shiftwidth=2|set expandtab softtabstop=2 smartindent
  autocmd FileType tsx set tabstop=2|set shiftwidth=2|set expandtab softtabstop=2 smartindent
  autocmd FileType typescript set tabstop=2|set shiftwidth=2|set expandtab softtabstop=2 smartindent
  autocmd FileType less set tabstop=2|set shiftwidth=2|set expandtab softtabstop=2 smartindent
  autocmd FileType scss set tabstop=2|set shiftwidth=2|set expandtab softtabstop=2 smartindent
  autocmd FileType html set tabstop=2|set shiftwidth=2|set expandtab softtabstop=2 smartindent
  autocmd FileType css set tabstop=2|set shiftwidth=2|set expandtab softtabstop=2 smartindent
augroup END

" Markdown and Journal
autocmd FileType markdown setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType journal setlocal shiftwidth=2 tabstop=2 softtabstop=2
""""""""""""""
