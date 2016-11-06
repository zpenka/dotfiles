" ----------
" Vim Config
" ----------
"
"
" How this works:
"
" This file is minimal.  Most of the vim settings and initialization is in
" several files in .vim/init.  This makes it easier to find things and to
" merge between branches and repos.
"
" Please do not add configuration to this file, unless it *really* needs to
" come first or last, like Pathogen and sourcing the machine-local config.
" Instead, add it to one of the files in .vim/init, or create a new one.


" Pathogen (This must happen first.)
" --------

filetype off                    " Avoid a Vim/Pathogen bug
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

set nocompatible                " Don't maintain compatibility with vi
syntax on                       " Highlight known syntaxes
filetype plugin indent on


" Source initialization files
" ---------------------------

runtime! init/**.vim

" Set Colors
" ----------
set term=screen-256color
set t_Co=256
set background=dark
colorscheme triplejelly

"let g:jsbeautify = {'indent_size': 2, 'indent_char': ' '}
"autocmd FileType javascript nmap <leader>= :call JsBeautify()<CR>

set cursorcolumn
"set cursorline
hi CursorLine cterm=NONE ctermbg=238
hi CursorColumn cterm=NONE ctermbg=238

set foldlevel=3
set foldnestmax=2
augroup vimrc
  au BufReadPre * setlocal foldmethod=indent
  au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END

set novisualbell
set t_vb=

" tab navigation like firefox
nnoremap <C-S-tab> :tabprevious<CR>
nnoremap <C-tab>   :tabnext<CR>
nnoremap <C-t>     :tabnew<CR>
inoremap <C-S-tab> <Esc>:tabprevious<CR>i
inoremap <C-tab>   <Esc>:tabnext<CR>i
inoremap <C-t>     <Esc>:tabnew<CR>

set fileformat=unix

" Machine-local vim settings - keep this at the end
" --------------------------
silent! source ~/.vimrc.local
