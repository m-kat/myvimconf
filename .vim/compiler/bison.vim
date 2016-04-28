" parser.y:26.40: syntax error, unexpected =
" parser.y:54.23: nieprawid³owy znak: `>'
" parser.y:32.44-46: symbol num is used

if exists('current_compiler')
  finish
endif
let current_compiler = 'bison'

setlocal errorformat=
      \%f:%l.%c:\ %m,
      \%f:%l.%c-%*[0-9]:\ %m,
