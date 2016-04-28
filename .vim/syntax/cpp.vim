" Vim syntax file
" Language:	C++
" Maintainer:	Katul <marcin.katulski@gmail.com>
" Last Change:	2013 Jun 04
"
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif


"" Read the C syntax to start with
if version < 600
  so <sfile>:p:h/c.vim
else
  runtime! syntax/c.vim
  unlet b:current_syntax
endif
" C++ extensions
syn keyword cppStatement	new delete this friend using
syn keyword cppAccess		public protected private
syn keyword cppType		inline virtual explicit export bool wchar_t
syn keyword cppExceptions	throw try catch
syn keyword cppOperator		operator typeid
syn keyword cppOperator		and bitor or xor compl bitand and_eq or_eq xor_eq not not_eq
syn match cppCast		"\<\(const\|static\|dynamic\|reinterpret\)_cast\s*<"me=e-1
syn match cppCast		"\<\(const\|static\|dynamic\|reinterpret\)_cast\s*$"
syn keyword cppStorageClass	mutable
syn keyword cppStructure	class typename template namespace 
syn keyword cppBoolean		true false

" C++ 11 extensions
syn keyword cppType		override final
syn keyword cppExceptions	noexcept
syn keyword cppStorageClass	constexpr decltype
syn keyword cppConstant	nullptr

" The minimum and maximum operators in GNU C++
syn match cppMinMax "[<>]?"

" Redefining c-like types in order to use mtch than keyword
"
syn match	cStorageClass	"\(static\|register\|auto\|volatile\|extern\|const\)"
" Own types highlighting
"
"syn match cppOwnType2   "^\([a-zA-Z0-9:_&\*]\+\s\+[a-zA-Z0-9:]\+\s\+(\)\?\(\s\|\t\)*[,]\?\zs\(const\|volatile\)*\(\s\|\t\)*[a-zA-Z0-9_:]\+\ze\(\*\|&\|\s\|\t\)\+[\/a-zA-Z0-9_:&\*]\+\(\s\|\t\)*\(,\|)\)\?\(\s\|\t\)*"
syn match cppOwnType20   "\w\+\(\s\|\t\|\n\)\+(\(\s\|\t\|\n\)\+\(const|volatile\)*\(\(\s|\t\|\n\)\+\zs[a-zA-Z0-9_:&*]*\ze\(\s\|\t\|\n\)[a-zA-Z0-9_:&]\)"
syn match cppTypesC     "\(void\)"
" Default highlighting
if version >= 508 || !exists("did_cpp_syntax_inits")
  if version < 508
    let did_cpp_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  HiLink cppAccess		cppStatement
  HiLink cppCast		cppStatement
  HiLink cppExceptions		Exception
  HiLink cppOperator		Operator
  HiLink cppStatement		Statement
  HiLink cppType		Type
  HiLink cppStorageClass	StorageClass
  HiLink cppStructure		Structure
  HiLink cppBoolean		Boolean
  HiLink cppConstant		Constant
  HiLink cStorageClass      StorageClass
"  HiLink cppTypesC        Type
  HiLink cppOwnType20        Type
  delcommand HiLink
endif

let b:current_syntax = "cpp"
