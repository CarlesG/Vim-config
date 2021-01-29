" Vim with all enhancements
"
source $VIMRUNTIME/vimrc_example.vim
" Use the internal diff if available.
" Otherwise use the special 'diffexpr' for Windows.
"colorscheme desert
try                             " En caso de no encuentre el tema isotopo, carga un tema por defecto del editor
  colorscheme molokai
  catch
  try 
    colorscheme desert
    catch
  endtry
endtry
"set background=dark

"-----Cargamos el directorio del plugin manager-----
filetype off
set shellslash
set rtp+=$HOME/vimfiles/bundle/Vundle.vim
call vundle#begin('$HOME/vimfiles/bundle')
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"colorscheme gruvbox
"colorscheme mitheme 
"colorscheme zenburn
"colorscheme solarized
"colorscheme Tomorrow-Night-Eighties
syntax on 
set number
set ruler
set nocompatible
set tabstop=4
set sw=4
set linespace=6
"set guifont=Lucida_Console:h8
"set guifont=DaddyTimeMono_Nerd_Font_Mono:h8
"set guifont = Hack_NF:h8
"set guifont =Monofur_NF:h8
set guifont=Consolas:h8                     " cambiar la letra y el tamaño de esta
set laststatus=2                            " para poder ver la línea de estatus
set cursorline                              " resalta la línea actual 
set wrap linebreak nolist                   " soft wrap, respeta la terminación de palabras
"set textwidth=80                           " hard wrap, configurando el número de columnas máximo
set formatoptions+=t

" Folding (ocultado de bloques anidados)
set foldenable    " Activa folding
set foldlevelstart=10 " Dobla a partir de 10.
set foldnestmax=10  " Máximo de 10
set foldmethod=indent " Basado en identado

""==============Configuración del status bar=====================
set statusline+=%#IncSearch#
set statusline+=\ %.25f
set statusline+=\ %m                        " indica si el archivo ha sido modificado
set statusline+=%#Visual#
set statusline+=%=
set statusline+=\ %y                        " tipo de fichero
set statusline+=\ Ln:\ %-3l\/%-3L[%p%%]     " senyala la linea actual respecto al porcentaje total
set statusline+=\ Col:%-2c                  " Columna actual
set statusline+=\ Buf:%n                    " Buffer number
set expandtab

"==============Personalización del cursor de escritura========
"set guicursor=n-v-c:block-Cursor
"set guicursor+=i:ver100-iCursor              " Para que el cursor sea una linea vertical en el modo insertar
"set guicursor+=n-v-c:blinkon0                " Desactivamos el parpadeo para el todos los modos

set noerrorbells                              " Eliminamos la campana del error
set autoindent
set showmatch
set hlsearch
set ignorecase
set incsearch
set guioptions-=r                           " Para quitar la barra de scroll lateral del GUI
set guicursor+=i:blinkwait20                " Incrementamos el parpadeo para el modo INSERTAR

"----------Configuración nerdtree, plugin que viene por defecto en vim
let g:netrw_browse_split = 2                " para que se abra el explorador de archivos en un tab vertical. Podemos realizar 1,2,3,4
let g:netrw_altv = 1
let g:netrw_banner = 0                      " quita el banner que está siempre ocupando el inicio de la pantalla
let g:netrw_liststyle = 3                   " estilo del arbol de directorio 
let g:netrw_list_hide = netrw_gitignore#Hide()
let g:netrw_list_hide.=',\|\s\s\)\zs\.\S\+'
let g:netrw_winsize = 25                    " ancho en porcentaje que queremos que ocupe el árbol de directorios
if &diffopt !~# 'internal'
  set diffexpr=MyDiff()
endif
function MyDiff()
  let opt = '-a --binary '
  f expand("%") == ""|browse confirm w|else|confirm w|endif
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  
                document.getElementById("moretext").style.fontSize="50px";
            };
		</script>
	</body>
</html>
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

"=========Para compilar en C dentro de VIM=============
map <F3> : call CompileGcc()<CR>
func! CompileGcc()
  exec "w"
  exec "!gcc % -o %<"
endfunc

map <F4> :call CompileRunGcc()<CR>
func! CompileRunGcc()
  exec "w"
  exec "!gcc % -o %<"
  exec "! %<.exe"
endfunc

" para poder utilizar 
nmap <C-V> "+gP
imap <C-V> <ESC><C-V>ia
vmap <C-C> "+y

