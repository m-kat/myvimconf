" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
if has('vim_starting')
    set nocompatible               " Be iMproved

    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" allow backspacing over everything in insert mode
set backspace=indent,eol,start
" let &errorformat="%f:%l:%c: %t%*[^:]:%m,%f:%l: %t%*[^:]:%m," . &errorformat
if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif

set    history=500		" keep 50 lines of command line history
set    ruler		" show the cursor position all the time
set    showcmd		" display incomplete commands
set    incsearch		" do incremental searching
syntax enable
set    number
set    relativenumber
set    ruler
set    tabstop=4
set    shiftwidth=4
set    expandtab
set    nowrap

"improving jedi error due to wrong python path
"
py3 import sys
py3 import jedi
set rtp+=~/.vim/bundle/vundle/

" My Bundles here:
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle "powerline/powerline"
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc.vim'
NeoBundle 'SirVer/ultisnips'
NeoBundle 'Valloric/YouCompleteMe'
NeoBundle 'adimit/prolog.vim'
NeoBundle 'adragomir/javacomplete'
NeoBundle 'alfredodeza/pytest.vim.git'
NeoBundle 'c9s/vimomni.vim'
NeoBundle 'chrisbra/Replay'
NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'dbext.vim'
NeoBundle 'elzr/vim-json'
NeoBundle 'farseer90718/vim-taskwarrior'
NeoBundle 'fatih/vim-go'
NeoBundle 'fs111/pydoc.vim.git'
NeoBundle 'honza/vim-snippets'
NeoBundle 'hsanson/vim-android'
NeoBundle 'jacquesbh/vim-showmarks'
NeoBundle 'jansenm/vim-cmake'
NeoBundle 'jiangmiao/auto-pairs'
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'm-kat/aws-vim'
NeoBundle 'marijnh/tern_for_vim'
NeoBundle 'mattn/calendar-vim'
NeoBundle 'megaannum/forms'
NeoBundle 'megaannum/self'
NeoBundle 'mileszs/ack.vim.git'
NeoBundle 'millermedeiros/vim-statline'
NeoBundle 'mitechie/pyflakes-pathogen.git'
NeoBundle 'myhere/vim-nodejs-complete'
NeoBundle 'peterhoeg/vim-qml'
NeoBundle 'reinh/vim-makegreen'
NeoBundle 'rosenfeld/conque-term'
NeoBundle 'rstacruz/sparkup', {'rtp': 'vim/'}
NeoBundle 'samsonw/vim-task'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'syntastic'
NeoBundle 't9md/vim-chef'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'thinca/vim-template'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-rails.git'
NeoBundle 'vim-latex/vim-latex'
NeoBundle 'vim-scripts/DoxygenToolkit.vim'
NeoBundle 'vim-scripts/FuzzyFinder'
NeoBundle 'vim-scripts/L9'
NeoBundle 'vim-scripts/errormarker.vim'
NeoBundle 'vim-scripts/ide'
NeoBundle 'vim-scripts/pep8.git'
NeoBundle 'vim-scripts/taglist.vim'
NeoBundle 'vim-scripts/vcscommand.vim'
NeoBundle 'vim-scripts/vimcommander'
NeoBundle 'vimwiki/vimwiki'
NeoBundle 'wincent/command-t.git'
NeoBundle 'rust-lang/rust.vim'
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'idanarye/vim-vebugger'
" NeoBundleLazy 'vim-scripts/project.vim'
" ...
call neobundle#end()
NeoBundleCheck

if exists('+colorcolumn')
  set colorcolumn=100
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>100v.\+', -1)
endif

function! g:UltiSnips_Complete()
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res == 0
        if pumvisible()
            return "\<C-n>"
        else
            call UltiSnips#JumpForwards()
            if g:ulti_jump_forwards_res == 0
                return "\<TAB>"
            endif
        endif
    endif
    return ""
endfunction

" ctags
set tags=./tags;/,tags;/

set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
" Always show statusline
"
 set laststatus=2
 set term=xterm-256color
 set termencoding=utf-8
 let g:Powerline_symbols = 'unicode'

 let g:ycm_rust_src_path = '/usr/src/rustc-1.21.0/src'
 "" let g:Powerline_symbols = 'fancy'
""
""
"
au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-e>"
let g:UltiSnipsSnippetDirectories=["UltiSnips", "./bundle/aws-vim/snips"]

let g:AWSSnips = "Alarm Authentication Base64 CreationPolicy FindInMap GetAtt Init Instance InstanceProfile Join LaunchConfiguration LoadBalancer Param Policy RDSIngress Ref Role SGEgress SGIngress ScalingPolicy ScheduledAction SecurityGroup Select Stack Subnet VPC Volume VolumeAttachment WaitCondition WaitConditionHandle asg cft init_command init_file init_group init_user"
let g:AWSVimValidate = 1

inoremap <expr>  <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

filetype plugin indent on     " required!
autocmd FileType php set omnifunc=phpcomplete#CompletePHP

" Lazy initialized plugins
"
autocmd FileType c,cpp,cmake NeoBundleSource project.vim

"au! BufNewFile,BufRead *.template set ft=json.aws
"===========================
"
map      <F10> :call VimCommanderToggle()<CR>
nnoremap <F6>  :Dox<CR>
nnoremap <S-F5>  :YcmDiags<CR>

autocmd CursorMovedI * if pumvisible()==0|pclose|endif
autocmd InsertLeave  * if pumvisible()==0|pclose|endif

 let g:MakeDoxygenComment_paramTag="@Param "
 let g:MakeDoxygenComment_returnTag="@Returns   "

 " In many terminal emulators the mouse works just fine, thus enable it.
set mouse=a

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
"  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on
  filetype indent on
  set      nocp
  filetype plugin on
  let      g:tex_flavor='latex'
  set      iskeyword+=:
  autocmd  FileType c,cpp,slang set cindent
  "  autocmd  FileType c,cpp set fdm=indent
  " Put these in an autocmd group, so that we can delete them easily.
  augroup  vimrcEx
  au!


  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=128
  autocmd FileType tex  setlocal textwidth=128
  autocmd FileType cpp  setlocal textwidth=128
  autocmd FileType c    setlocal textwidth=128
  autocmd FileType python setlocal textwidth=79

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END
else
  set autoindent		" always set autoindenting on
endif " has("autocmd")

set shellslash
set grepprg=grep\ -nH\ $*

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" set autoindent
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
	 	\ | wincmd p | diffthis

colorscheme elflord


"" Templates settings
"
"function! LoadTemplate()
"    silent! 0r ~/.vim/skel/tmpl.%:t:r:e.%:e
"    let lines = line($)
"    let lines2 = search(^$)
"    if lines == 1 && lines2 == 1
"        silent! 0r ~/.vim/skel/tmpl.%:e
"    endif
"    syn match Todo %\u\+% containedIn=ALL
"endfunction
"nnoremap <c-p> /%\u.\{-1,}%<cr>c/%/e<cr>
"inoremap <c-p> <ESC>/%\u.\{-1,}%<cr>c/%/e<cr>
"autocmd! BufNewFile * call LoadTemplate()


autocmd FileType c,cpp,java,php,python,aws.json,json,make,doxygen,markdown autocmd BufWritePre <buffer> :%s/\s\+$//g
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set list

"simple helper functions
"
func! Mconv16()
    let @r=substitute( system("echo \"obase=16;" . expand("<cword>") . "\"| bc -l"), "\n","", "" )
    echom @r
endfunc

func! Mconv10()
    let @r=substitute( toupper( expand("<cword>") ), "0X","","")
    let @r=substitute( system("echo \"obase=10;ibase=16;" . @r . "\"| bc -l"), "\n","", "" )
    echom @r
endfunc

func! Mconv2x()
    let @r=substitute( toupper( expand("<cword>") ), "0X","","")
    let @r=substitute( system("echo \"obase=2;ibase=16;" . @r . "\"| bc -l"), "\n","", "" )
    echom @r
endfunc

func! Mconv2d()
    let @r=substitute( system("echo \"obase=2;" . expand("<cword>") . "\"| bc -l"), "\n","", "" )
    echom @r
endfunc

func! Mconvx2()
    let @r=substitute( toupper( expand("<cword>") ), "0X","","")
    let @r=substitute( system("echo \"obase=16;ibase=2;" . @r . "\"| bc -l"), "\n","", "" )
    echom @r
endfunc

func! Mconvd2()
    let @r=substitute( system("echo \"obase=10;ibase=2;" . expand("<cword>") . "\"| bc -l"), "\n","", "" )
    echom @r
endfunc

func! Calc(print, prefix )
    let line=getline(".")
    let @r=substitute( system("echo \"" . a:prefix . line  . "\" | bc -l" ),"\n","","")
    if a:print==1
        echom @r
    else
        return @r
    endif
endfunc


nnoremap <LocalLeader><c-x> :call Mconv16()<CR>
nnoremap <LocalLeader><c-d> :call Mconv10()<CR>
nnoremap <LocalLeader><c-b><c-d> :call Mconv2d()<CR>
nnoremap <LocalLeader><c-b><c-x> :call Mconv2x()<CR>
nnoremap <LocalLeader><c-d><c-b> :call Mconvd2()<CR>
nnoremap <LocalLeader><c-x><c-b> :call Mconvx2()<CR>

" kolorowanie zaznaczonego tekstu
func! Mcolor(color)
    let t=getpos("'<")
    let y=getpos("'>")
    let line=getline( t[1] )
    let pat=strpart( line, t[2]-1, y[2]-t[2]+1)
    let c=matchadd( a:color, ".*" . pat . ".*" )
endfunc

highlight Mxr cterm=bold ctermfg=1       gui=bold guifg=Red
highlight Mxg cterm=bold ctermfg=2       gui=bold guifg=Green
highlight Mxb cterm=bold ctermfg=Blue    gui=bold guifg=Blue
highlight Mxy cterm=bold ctermfg=Yellow  gui=bold guifg=Yellow
highlight Mxa cterm=bold ctermfg=Magenta gui=bold guifg=Magenta


vnoremap <LocalLeader><c-r> :call Mcolor("Mxr")<CR>
nnoremap <LocalLeader><c-m> :call clearmatches()<CR>
vnoremap <LocalLeader><c-b> :call Mcolor("Mxb")<CR>
vnoremap <LocalLeader><c-y> :call Mcolor("Mxy")<CR>
vnoremap <LocalLeader><c-g> :call Mcolor("Mxg")<CR>
vnoremap <LocalLeader><c-a> :call Mcolor("Mxa")<CR>


" valendar settings
let g:calendar_weeknm = 1


" wiki's set up

let wiki = {}
let wiki.path = '~/.vim/dev_wiki/'
let wiki.nested_syntaxes = {'cmake': 'cmake', 'c++': 'cpp'}

let wiki2 = {}
let wiki2.path = '~/vimwiki/'
let wiki2.nested_syntaxes = {'cmake': 'cmake', 'c++': 'cpp'}

let g:vimwiki_list = [wiki,wiki2]

"   neocomplete configuration
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"
let g:neocomplete#enable_auto_select = 1
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

set encoding=utf-8
