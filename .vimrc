" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2011 Apr 15
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Vundle and Plugins"{{{
filetype off
" set the runtime path to inclue Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'Lokaltog/vim-easymotion'
"Plugin 'L9'
Plugin 'scrooloose/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'mbbill/undotree'
Plugin 'mileszs/ack.vim'

" Syntax checking and autocomplete
" Plugin 'scrooloose/syntastic'
Plugin 'Valloric/YouCompleteMe'

Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'Raimondi/delimitMate'

" HTML related
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'


" java scripts
Plugin 'maksimr/vim-jsbeautify'
Plugin 'ternjs/tern_for_vim'
Plugin 'jQuery'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'

" notes and markdown
Plugin 'reedes/vim-pencil'

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" C/C++ stuff
Plugin 'majutsushi/tagbar'
Plugin 'yegappan/lid'

" Color schemes
"Plugin 'altercation/vim-colors-solarized'
"Plugin 'Lokaltog/vim-distinguished'
Plugin 'tomasr/molokai'
call vundle#end()
"}}}

" add c-support(C IDE)
set rtp+=~/.vim/c.vim

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END
endif " has("autocmd")


set autoindent		" always set autoindenting on


" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif

"
" Plugin Settings
" Worthless mapping
let g:vimrplugin_assign = 0
" Disable ridiculous mappings
let g:vimrplugin_insert_mode_cmds = 0


" powerline setting"{{{
"set rtp+=~/.local/lib/python2.7/site-packages/powerline/bindings/vim
"set noshowmode
"set showtabline=2
"let g:Powerline_symbols = 'fancy'
"let Powerline_symbols = 'compatible'
"}}}

" Airline options"{{{
let g:airline_enable_branch = 1
let g:airline_enable_syntastic = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
"}}}
set laststatus=2
if has("gui_running")
  set guifont=Droid\ Sans\ Mono\ Dotted\ for\ Powerline\ 9
endif

" Syntastic setting"{{{
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
" c/c++ part
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = '-std=c++11 -stdlib=libc++'
" java part
let g:syntastic_java_javac_delete_output = 1
let g:syntastic_java_checkers = ['checkstyle', 'javac']
let g:syntastic_java_checkstyle_classpath = "~/.local/lib/checkstyle-6.15-all.jar"
let g:syntastic_java_checkstyle_conf_file = "~/.local/lib/sun_checks.xml"
"let g:syntastic_javascript_eslint_exec = 'eslint_d'
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_disabled_filetypes=['html']

"let g:syntastic_check_on_wq = 0
"let g:syntastic_mode_map = { 'mode': 'active','passive_filetypes': ['java'] }
"}}}
" ctrlP settings"{{{
nmap <leader>p :CtrlP<cr>
let g:ctrlp_user_command = {
            \ 'types': {
            \ 1: ['.git', 'cd %s && git ls-files --exclude-standard --others --cached'],
            \ 2: ['.hg', 'hg --cwd %s locate -I .'],
            \ },
            \ 'fallback': 'find %s -type f'
            \ }
let g:ctrlp_working_path_mode = 'r'   " Use nearest .git dir
"}}}
" Easymotion"{{{
let g:EasyMotion_smartcase = 1
let g:EasyMotion_startofline = 0
map <space> <Plug>(easymotion-prefix)
map <space>h <Plug>(easymotion-linebackward)
map <space>l <Plug>(easymotion-lineforward)
map <space>j <Plug>(easymotion-j)
map <space>k <Plug>(easymotion-k)
map <space>s <Plug>(easymotion-s)
"}}}

" vim-jsx"{{{
let g:jsx_ext_required = 0 " let vim-jsx handle .js file as well
"}}}

" CScope "{{{
"
" Cheat Sheet:
"
"   's'   symbol: find all references to the token under cursor
"   'g'   global: find global definition(s) of the token under cursor
"   'c'   calls:  find all calls to the function name under cursor
"   't'   text:   find all instances of the text under cursor
"   'e'   egrep:  egrep search for the word under cursor
"   'f'   file:   open the filename under cursor
"   'i'   includes: find files that include the filename under cursor
"   'd'   called: find functions that function under cursor calls
"if has("cscope")
  " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
"  set cscopetag

  " check cscope for definition of a symbol before checking ctags: set to 1
  " if you want the reverse search order.
"  set csto=0

  " add any cscope database in current directory
"  if filereadable("cscope.out")
"    cs add cscope.out
"  elseif $CSCOPE_DB != ""
"    cs add $CSCOPE_DB
"  endif
"  set cscopeverbose
"  nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
"  nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
"  nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
"  nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
"  nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
"  nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
"  nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
"  nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
"endif
"}}}
  " Undotree "{{{
  nmap <leader>u :UndotreeToggle<cr>
  let g:undotree_SplitWidth = 30
  let g:undotree_WindowLayout = 3
"}}}
" NerdTree"{{{
map <up> :NERDTreeMirror<CR>
map <up> :NERDTreeToggle<CR>
"}}}

" lid
"nnoremap <silent> <F4> :Lid <C-R><C-W><CR>

" Tagbar
map <down> :TagbarToggle<CR>

"<Left><Right>Arrow show next buffer :bd to delete buffer"{{{
map <left> :bnext<CR>
map <right> :bprevious<CR>
" :bd to delete the current buffer
"or map to tab if u use tab instead of buff.
"map <left> :tabn<CR>
"map <right> :tabp<CR>
"}}}
" vim-pencil config"{{{
augroup pencil
  autocmd!
  autocmd FileType markdown,mkd call pencil#init()
  autocmd FileType text,txt call pencil#init()
augroup END
"}}}
" vim-javascript"{{{
let g:javascript_enable_domhtmlcss=1
let g:javascript_conceal_function   = "ƒ"
let g:javascript_conceal_null       = "ø"
let g:javascript_conceal_this       = "@"
let g:javascript_conceal_return     = "⇚"
let g:javascript_conceal_undefined  = "¿"
let g:javascript_conceal_NaN        = "ℕ"
let g:javascript_conceal_prototype  = "¶"
let g:javascript_conceal_static     = "•"
let g:javascript_conceal_super      = "Ω"
"}}}

" YouCompleteMe Options"{{{
let g:ycm_register_as_syntastic_checker = 1 "default 1

"default .ycm_extra_conf.py if not found
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0 "default 1

let g:ycm_goto_buffer_command = 'horizontal-split' "[ 'same-buffer', 'horizontal-split', 'vertical-split', 'new-tab' ]
"let g:ycm_filetype_whitelist = { '*': 1 }
"let g:ycm_key_invoke_completion = '<C-Space>'

nnoremap <F12> :YcmForceCompileAndDiagnostics <CR>
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
"}}}

"UltiSnips Options"{{{
let g:UltiSnipsExpandTrigger='<C-SPACE>'
let g:UltiSnipsJumpForwardTrigger='<C-J>'
let g:UltiSnipsListSnippets='<C-K>'
let g:UltiSnipsSnippetDirectories = ["UltiSnips", "ultisnips-snippets"]
"}}}

" tern_for_vim"{{{
let g:tern#command=["node", '/opt/JS/bin/tern', '-no-port-file']
"}}}

if has("gui_running")
  set background=light
else
  set background=dark
endif
" colorschemes"{{{
" solarized settings
"let g:solarized_termcolors=   256
"let g:solarized_termtrans =   1
"colorscheme solarized

" molokai color scheme
"let g:molokai_original = 1
let g:rehash256 = 1
colorscheme molokai

" Distinguish colorschem
"colorscheme distinguished
"}}}
" Omnicomplete settings"{{{
"autocmd FileType java set omnifunc=javacomplete#Complete
"autocmd Filetype java map <leader>b :call javacomplete#GoToDefinition()<CR>
"setlocal completefunc=javacomplete#CompleteParamsInfo

"autocmd FileType python set omnifunc=pythoncomplete#Complete
"autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
"autocmd FileType css set omnifunc=csscomplete#CompleteCSS
"autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
"autocmd FileType php set omnifunc=phpcomplete#CompletePHP
"autocmd FileType c set omnifunc=ccomplete#Complete
"}}}
" indent-guides"{{{
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level=1
"}}}
" Folder structure"{{{
if !isdirectory(expand('~/.vim/undo/', 1))
  silent call mkdir(expand('~/.vim/undo', 1), 'p')
endif

if !isdirectory(expand('~/.vim/backup/', 1))
  silent call mkdir(expand('~/.vim/backup', 1), 'p')
endif

if !isdirectory(expand('~/.vim/swap/', 1))
  silent call mkdir(expand('~/.vim/swap', 1), 'p')
endif
"}}}
"   setup backup dir"{{{
"   Use backups
"   Source:
"   http://stackoverflow.com/a/15317146
if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
  set writebackup
  set backupdir=~/.vim/backup//
endif
"}}}
" Persistent undo"{{{
" Thanks, Mr Wadsten: github.com/mikewadsten/dotfiles/
if has('persistent_undo')
  set undodir=~/.vim/undo//
  set undofile
  set undolevels=1000
  set undoreload=5000
endif
"}}}
" Custom Functions
" Append modeline to file <Leader>ml."{{{
" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX
" files.
function! AppendML_TCL()
    let l:ml = printf(" vim: set ts=%d sw=%d tw=%d %set :",
                \ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
    set buf $::vim::current(buffer)
    $buf append end l:ml
endfunction
function! AppendML()
  let l:mdline = printf(" vim: set ts=%d sw=%d tw=%d %set :",
        \ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
  let l:mdline = substitute(&commentstring, "%s", l:mdline, "")
  call append(line("$"), l:mdline)
"  let l:mdline2 = " vim: set foldmethodm=marker foldlevel=0 :"
"  let l:mdline2 = substitute(&commentstring, "%s", l:mdline2, "")
"  call append(line("$"), l:mdline2)
endfunction
if has("tcl")
    nnoremap<Leader>ml :call AppendML_TCL()<CR>
else
    nnoremap<Leader>ml :call AppendML()<CR>
endif
"}}}
"Remove trailing whitespace"{{{
" http://vim.wikia.com/wiki/Remove_unwanted_spaces
"function! StripTrailingWhitespace()
"  if !&binary && &filetype != 'diff'
"    normal mz
"    normal Hmy
"    %s/\s\+$//e
"    normal 'yz<cr>
"    normal `z
"  endif
"endfunction
"nmap<leader>tW :cal StripTrailingWhitespace()<cr>
"}}}
" toggle last search highlights by press<F2>"{{{
nnoremap <Leader><SPACE> :set hlsearch!<CR>
"}}}
" ignore some defaults "{{{
set wildignore=*.o,*.obj,*~,*.pyc
set wildignore+=.env
set wildignore+=.env[0-9]+
set wildignore+=.git,.gitkeep
set wildignore+=.tmp
set wildignore+=.coverage
set wildignore+=*DS_Store*
set wildignore+=.sass-cache/
set wildignore+=__pycache__/
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=.tox/**
set wildignore+=.idea/**
set wildignore+=*.egg,*.egg-info
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=*.so,*.swp,*.zip,*/.Trash/**,*.pdf,*.dmg,*/Library/**,*/.rbenv/**
set wildignore+=*/.nx/**,*.app
"}}}
" Disable Arrow key "{{{
"map <up> <nop>
"map <down> <nop>
"map <left> <nop>
"map <right> <nop>
"}}}
" Fold setting"{{{
"set nofoldenable   " Turn off fold on start
" Indent seems to work the best
set foldmethod=marker
set foldlevel=20
"}}}
" Misc settings "{{{
" The default 20 isn't nearly enough
set history=9999
" Show the matching when doing a search
set showmatch
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
" allow load another buffer when current buffer is dirty
set hidden
set wildmenu
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set encoding=utf-8
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set number
set nowrapscan
"}}}

set secure
" include header file in src/include for c and c++
set path+=src/include
" include header for c++ 4.8 lib
if isdirectory('/usr/include/c++/4.8')
  set path+=/usr/include/c++/4.8
" elseif isdirectory(...)
" other library
endif


