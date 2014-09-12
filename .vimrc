
call pathogen#infect()

let g:flake8_max_line_length=160
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

map <f10> :make<cr>
map <f11> :cnext<cr>
map <f12> :cprevious<cr>

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


if exists('+colorcolumn')
    " add 80th column highlight
    set colorcolumn=80
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

"perforce integration
"let g:p4CmdPath = '/build/apps/bin/p4'
"let g:p4ClientRoot = '/Perforce'
"let g:p4Presets = 'P4CONFIG'
"let g:p4CurDirExpr = "(isdirectory(expand('%')) ? substitute(expand('%:p'), \ '\\\\$', '', '') : '')"


set viminfo='20,"10000
