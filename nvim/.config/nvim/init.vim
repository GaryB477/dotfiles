set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching 
set ignorecase              " case insensitive 
set mouse=v                 " middle-click paste with 
set hlsearch                " highlight search 
set incsearch               " incremental search
set tabstop=4               " number of columns occupied by a tab 
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
filetype plugin indent on   "allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
filetype plugin on
set ttyfast                 " Speed up scrolling in Vim
set foldmethod=indent
set foldlevel=99


" # 
" # General settings
" # 

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif


" # 
" # Keybinds
" # 

let mapleader=" "
nnoremap <leader>t :NERDTreeToggle<CR>
nnoremap <leader> f za


" # 
" # Plugin manager
" # 

" Installed vim-plug (plugin manager) with:
" sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
"       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
" See: https://github.com/junegunn/vim-plug

call plug#begin()

" List your plugins here
    Plug 'tpope/vim-sensible'
    Plug 'neoclide/coc.nvim', {'branch': 'release'} " Not Cast On Crit. Instead, its a code completion plugin
    Plug 'preservim/nerdtree'                       " https://github.com/preservim/nerdtree
    Plug 'glepnir/oceanic-material'
    Plug 'marko-cerovac/material.nvim'
    Plug 'tmhedberg/SimpylFold'
    "Plug 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
call plug#end()


" # 
" # Theme
" # 
" Note: Needs to be set after the plugin is installed
set background=dark
colorscheme material
set termguicolors " needed for the theme and color to be rendered properly


" # 
" # Nice to know stuff
" # 
"
" - Source current file ->      ":so %"
" - Install plugins ->          "PlugInstall"
