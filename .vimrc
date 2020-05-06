""""" VUNDLE
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" Plugin 'psf/black'
Plugin 'scrooloose/syntastic'
Plugin 'rjr'
" Plugin 'YouCompleteMe'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
""""" VUNDLE


" execute pathogen#infect()

set modeline
set modelines=5

" Syntastic
" https://github.com/scrooloose/syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"if $VIMINIT != ''
"    let g:syntastic_javascript_jshint_exec = &runtimepath . '/node_modules/.bin/jshint'
"else
    let g:syntastic_javascript_jshint_exec = $HOME. '/.vim/node_modules/.bin/jshint'
"endif

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_flake8_args = "--max-line-length=160"
" Ignore this in erb
let g:syntastic_eruby_ruby_quiet_messages = {'regex': 'possibly useless use of .* in void context' }
"let g:syntastic_python_flake8_args = "--ignore=E501"

" Flake8
"let g:flake8_max_line_length=160
"let g:flake8_ignore="E501,W293"
"autocmd BufWritePost *.py call Flake8()

map  <F1> <Esc>
map! <F1> <Esc>

map <F3> !} fmt -78 -c

function Comment() range
    execute a:firstline.",".a:lastline.'s/^/#/'
endfunction

map <f4> :call Comment()<cr>


" toggle paste mode with F2
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" this interferes with pyflakes plugin: set t_Co=256
set background=dark
colors koehler
"colors desert256
"colors inkpot


set expandtab
set tabstop=8 " show real tabs as 8
set shiftwidth=4 " auto-indent amount when using cindent,
                 " >>, << and stuff like that
set softtabstop=4 " when hitting tab or backspace, how many spaces
                  "should a tab be (see expandtab)

autocmd Filetype ruby setlocal shiftwidth=2 softtabstop=2

set shiftround " when at 3 spaces, and I hit > ... go to 4, not 5

set list " we do what to show tabs, to ensure we get them
         " out of my files
set listchars=tab:>-,trail:- " show tabs and trailing 

set ruler

" map <f10> :make<cr>
" map <f11> :cnext<cr>
" map <f12> :cprevious<cr>

"This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>

" http://stackoverflow.com/questions/356126/how-can-you-automatically-remove-trailing-whitespace-in-vim
"autocmd BufWritePre *.py :%s/\s\+$//e

"afun! <SID>StripTrailingWhitespaces()
"    let l = line(".")
"    let c = col(".")
"    %s/\s\+$//e
"    call cursor(l, c)
"endfun
"
"autocmd BufWritePre *.h :call <SID>StripTrailingWhitespaces()

highlight Search cterm=NONE ctermfg=NONE ctermbg=grey

if exists('+colorcolumn')
    " add 80th column highlight
    set colorcolumn=90
    hi colorcolumn ctermbg=darkred
else
    " Highlight text over 80 characters
    highlight OverLength ctermbg=red ctermfg=white guibg=gray
    match OverLength /\%81v.\+/
endif

" use listchars instead!
"highlight TrailingSpaces ctermbg=red ctermfg=white guibg=#592929
"match TrailingSpaces /\s\+$/

function ShowSpaces(...)
  let @/="\\v(\\s+$)|( +\\ze\\t)"
  let oldhlsearch=&hlsearch
  if !a:0
    let &hlsearch=!&hlsearch
  else
    let &hlsearch=a:1
  end
  return oldhlsearch
endfunction

function TrimSpaces() range
  let oldhlsearch=ShowSpaces(1)
  execute a:firstline.",".a:lastline."substitute ///gec"
  let &hlsearch=oldhlsearch
endfunction

command -bar -nargs=? ShowSpaces call ShowSpaces(<args>)
command -bar -nargs=0 -range=% TrimSpaces <line1>,<line2>call TrimSpaces()

"autocmd FileType python compiler pylint
"let g:pylint_onwrite = 0
"augroup Python
"        au!
"        filetype indent on
"        au FileType python set foldmethod=indent
"        " do I want everything collapsed when I open the file?
"        "au FileType python set foldenable
"        au FileType python set nofoldenable
"        " save fold states
"        au BufWinLeave * mkview
"        au BufWinEnter * silent loadview
"augroup END

filetype on
filetype plugin indent on
au BufNewFile,BufRead *.djhtml set filetype=htmldjango
au BufNewFile,BufRead *.less set filetype=css
au BufNewFile,BufRead *.sc set filetype=python
au BufNewFile,BufRead *.j2html set filetype=htmljinja

au Filetype htmldjango setlocal ts=2 sts=2 sw=2 expandtab
au Filetype htmljinja setlocal ts=2 sts=2 sw=2 expandtab
au Filetype html setlocal ts=2 sts=2 sw=2 expandtab
au Filetype typescript setlocal ts=2 sts=2 sw=2 expandtab

"perforce integration
"let g:p4CmdPath = '/build/apps/bin/p4'
"let g:p4ClientRoot = '/Perforce'
"let g:p4Presets = 'P4CONFIG'
"let g:p4CurDirExpr = "(isdirectory(expand('%')) ? substitute(expand('%:p'), \ '\\\\$', '', '') : '')"

set viminfo='20,"10000

" http://stackoverflow.com/questions/6980749/simpler-way-to-put-pdb-breakpoints-in-python-code
au FileType python map <silent> <leader>b oimport ipdb; ipdb.set_trace()<esc>
au FileType python map <silent> <leader>B Oimport ipdb; ipdb.set_trace()<esc>
au FileType python map <f10> :%! black -q -<cr>
