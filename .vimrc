" ===========================
" General Settings
" ===========================
 
" Use space as <Leader> key
let mapleader = " "
 
" Enable syntax highlighting
syntax on
 
" Show line numbers
set number
 
" Show relative line numbers
set relativenumber
 
" Keep 5 lines visible above/below cursor
set scrolloff=5
 
" Highlight the current line
set cursorline
 
" Case-insensitive search
set ignorecase
 
" Case-sensitive if capitals used
set smartcase
 
" Highlight search matches
set hlsearch
 
" Incremental search while typing
set incsearch
 
" Use system clipboard
set clipboard=unnamedplus
 
" Enable mouse support
set mouse=a
 
" Disable old Vi compatibility
set nocompatible
 
" Disable swap files
set noswapfile
 
" Disable backup files
set nobackup
 
" ===========================
" Plugins (vim-plug)
" ===========================
 
call plug#begin('~/.vim/plugged')
 
" File explorer
Plug 'preservim/nerdtree'
 
" Syntax-based highlighting
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
 
" Filetype icons (requires Nerd Font)
Plug 'ryanoasis/vim-devicons'
 
call plug#end()
 
" ===========================
" NERDTree Highlighting
" ===========================
 
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
let g:NERDTreeHighlightFolders = 1
let g:NERDTreeHighlightFoldersFullName = 1
 
" ===========================
" NERDTree Settings
" ===========================
 
" Show hidden files
let NERDTreeShowHidden=1
 
" Minimal UI
let NERDTreeMinimalUI=1
 
" Toggle NERDTree
nnoremap <silent> <leader>e :NERDTreeToggle<CR>
 
" ===========================
" File Management Shortcuts
" ===========================
 
" Save file
nnoremap <silent> <leader>w :w<CR>
 
" Quit
nnoremap <silent> <leader>q :q<CR>
 
" Quit without saving
nnoremap <silent> <leader>Q :q!<CR>
 
" ===========================
" Navigation Improvements
" ===========================
 
" Half-page down (Shift+j)
nnoremap <S-j> <C-d>
 
" Half-page up (Shift+k)
nnoremap <S-k> <C-u>
 
" Half-page down in visual mode
xnoremap J <C-d>
 
" Half-page up in visual mode
xnoremap K <C-u>
 
" Keep cursor centered after half-page down
nnoremap <C-d> <C-d>zz
 
" Keep cursor centered after half-page up
nnoremap <C-u> <C-u>zz
 
" Center screen after search next
nnoremap n nzzzv
 
" Center screen after search previous
nnoremap N Nzzzv
 
" ===========================
" Window Navigation
" ===========================
 
" Move left
nnoremap <C-h> <C-w>h
 
" Move down
nnoremap <C-j> <C-w>j
 
" Move up
nnoremap <C-k> <C-w>k
 
" Move right
nnoremap <C-l> <C-w>l
 
" ===========================
" Search & Replace Helpers
" ===========================
 
" Clear search highlight
nnoremap <silent> <leader>/ :nohlsearch<CR>
 
" Quick search/replace
nnoremap <leader>r :%s/<C-r>///g<Left><Left>
 
" ===========================
" Clipboard Integration
" ===========================
 
" Yank to system clipboard
nnoremap <leader>y "+y
 
" Yank selection to system clipboard
vnoremap <leader>y "+y
 
" Yank current line to system clipboard
nnoremap <leader>yy "+yy
