" set options

syntax enable
set autoindent
set tabstop=4 softtabstop=4
set shiftwidth=4
set nohlsearch
set hidden
highlight Cursor guifg=white guibg=black
highlight Normal ctermbg=black
set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor
set expandtab
set incsearch
set cursorline
set relativenumber
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set number
set noerrorbells
set mouse=a
set title
set nowrap
set nu
set colorcolumn=80
set backspace=indent,eol,start
set confirm
set signcolumn=yes
set cmdheight=2
set updatetime=50
set shortmess+=c
set splitright
highlight ColorColumn ctermbg=0 guibg=lightgrey
hi SpellBad cterm=underline
"plugs
call plug#begin('~/.vim/plugged')
Plug 'prettier/vim-prettier'
Plug 'pangloss/vim-javascript'
Plug 'othree/html5.vim'
Plug 'evanleck/vim-svelte', {'branch': 'main'}
Plug 'morhetz/gruvbox'
Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}
Plug 'vim-utils/vim-man'
Plug 'mbbill/undotree'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vimwiki/vimwiki'
Plug 'ionide/Ionide-vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'dhruvasagar/vim-table-mode'
Plug 'udalov/kotlin-vim'
Plug 'jlcrochet/vim-razor'
Plug 'lewis6991/gitsigns.nvim'
call plug#end()

"colorscheme
colorscheme gruvbox
set background=dark
highlight Normal ctermbg=none


lua require('telescope').setup ({defaults = {file_ignore_patterns = {"node_modules",".git","dist","build","venv","__pycache__","bin"},file_sorter =require('telescope.sorters').get_fzy_sorter}})
lua require('gitsigns').setup()

let g:limelight_conceal_ctermfg=238
let g:limelight_default_coefficient = 0.8

let g:netrw_browse_split=2
let g:netrw_banner = 0
let g:netrw_winsize= 20
"let g:completion_enable_auto_popup = 1
let g:tex_flavor = "plaintex"

autocmd FileType vk map <buffer> <F9> :w<CR>:exec '!v' shellescape(@%, 1)<CR>
autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python' shellescape(@%, 1)<CR>
autocmd FileType plaintex map <buffer> <F9> :w<CR>:exec '!texbuildhelper' shellescape(@%, 1)<CR>
autocmd FileType tex map <buffer> <F9> :w<CR>:exec '!texbuildhelper' shellescape(@%, 1)<CR>
autocmd FileType kotlin map <buffer> <F9> :w<CR>:exec '!python3 /home/thomas/Programs/Python/ktrunner.py' shellescape(@%, 1)<CR>
autocmd FileType javascript map <buffer> <F9> :w<CR>:exec '!electron index.html' shellescape(@%, 1) <CR>
autocmd FileType go map <buffer> <F9> :w<CR>exec '!go run' shellescape(@%,1)<CR>
autocmd FileType cs map <buffer> <F9> :w<CR>exec '!dotnet run' shellescape(@%,1)<CR>
map <F5> :setlocal spell! spelllang=en_us<CR>
map <F3> :Goyo<Bar>:set relativenumber<CR>
map <F2> :Limelight!!<CR>






"leader key remaps
let mapleader = " "
nnoremap <leader>gg :Gitsigns blame_line<CR>
nnoremap <leader>pp :lua require('telescope.builtin').find_files()<CR>
nnoremap <leader>ps :lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>
nnoremap <leader>pg :lua require('telescope.builtin').live_grep()<CR>
nnoremap <leader>pb :lua require('telescope.builtin').buffers()<CR>
"navigate windows
nnoremap <leader>s :wincmd l<CR>
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>n :wincmd k<CR>
nnoremap <leader>t :wincmd j<CR>
nnoremap <leader>m :hide<CR>
nnoremap <leader>k :q<CR>
"resize windows
nnoremap <leader>+ :vertical resize +5<CR>
nnoremap <leader>- :vertical resize -5<CR>
nnoremap <leader>b <C-W>h<bar><C-W>L<bar><C-W>L<bar><C-W><bar>
nnoremap <leader><leader> <C-W>L <C-W><bar>
nnoremap <leader>0 :vertical resize 0 <CR>
nnoremap <leader>e <C-w>=

"file navigation
nnoremap <leader>ds :Vexplore<CR>

"yank
nnoremap Y yg$


"dvorak
noremap h h
noremap t j
noremap n k
noremap s l
noremap l n
noremap L N
noremap z s
noremap Z S




autocmd FileType cs map <leader>etv :call ExtractToVariableCSharp()<CR>
fun! ExtractToVariableCSharp()
    let l:name = input("name: ")
    normal da"mzO
    execute "normal! ivar " . l:name . " = \<Esc>"
    normal pa;
    normal `z
    execute "normal! i" . l:name . "\<Esc>"
endfun

autocmd FileType python map <leader>etv :call ExtractToVariablePYharp()<CR>
fun! ExtractToVariablePYharp()
    let l:name = input("name: ")
    normal da"mzO
    execute "normal! i" . l:name . " = \<Esc>"
    normal pa
    normal `z
    execute "normal! i" . l:name . "\<Esc>"
endfun






"this trims whitespace before eof (hopefully...)
fun! TrimWhiteSpace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup YOSHI
    autocmd!
    autocmd BufWritePre * :call TrimWhiteSpace()
augroup END


command! -nargs=0 GenerateComponentSnippet :call GenerateComponentSnippet()


function! GenerateComponentSnippet() abort
    " Get the current filename
    let filename = expand('%:t')

    " Extract the component name from the filename
    let component_name = substitute(filename, '\.tsx$', '', '')

    " Construct the TypeScript snippet
    execute "normal! i" . 'interface ' . component_name . 'Props {' . "\<CR>\<CR>" . '}' . "\<CR>\<CR>" . 'export default function ' . component_name . ' (props: ' . component_name . 'Props) {' . "\<CR>\<CR>" . '    return (' . "\<CR>" . '    <>' . "\<CR>" . '    </>' . "\<CR>" . '    )' . "\<CR>" . '}' . "\<CR>"

    " Paste the snippet into the current buffer

    " Move the cursor to the appropriate position
    execute 'normal! kk'
endfunction
