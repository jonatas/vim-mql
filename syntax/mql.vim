" Language:    MetaTrader Language: MQL
" Maintainer:  Jônatas Davi Paganini <jonatasdp@gmail.com>
" URL:         http://github.com/jonatasdp/vim-mql
" License:     WTFPL

if exists("b:current_syntax")
  finish
endif

if version < 600
  syntax clear
endif

let b:current_syntax = "mql"


syntax keyword mqlStatement return break continue
highlight default link mqlStatement Statement

syntax keyword mqlRepeat for while until
highlight default link repeat Repeat

syntax keyword mqlConditional if else unless switch when then
highlight default link mqlConditional Conditional

syntax keyword mqlException try catch finally
highlight default link mqlException Exception

syntax keyword mqlOperator instanceof typeof delete
highlight default link mqlOperator Operator

syntax keyword mqlKeyword new in of by where and or not is isnt
\                            class extends super
highlight default link mqlKeyword Keyword

syntax keyword mqlBoolean true on yes false off no
highlight default link mqlBoolean Boolean

syntax keyword mqlGlobal null undefined
highlight default link mqlGlobal Type

syntax keyword mqlVar this prototype arguments
syntax match mqlVar /@\%(\I\i*\)\?/
highlight default link mqlVar Type

" Matches class-like names that start with a capital letter, like Array or
" Object
syntax match mqlObject /\<\u\w*\>/
highlight default link mqlObject Structure

" Matches constant-like names in SCREAMING_CAPS
syntax match mqlConstant /\<\u[A-Z0-9_]\+\>/
highlight default link mqlConstant Constant

syntax match mqlPrototype /::/
highlight default link mqlPrototype SpecialChar

" What can make up a variable name
syntax cluster mqlIdentifier contains=mqlVar,mqlObject,mqlConstant,
\                                        mqlPrototype

syntax match mqlAssignmentChar /:/ contained
highlight default link mqlAssignmentChar SpecialChar

syntax match mqlAssignment /@\?\I\%(\i\|::\|\.\)*\s*::\@!/
\                             contains=@mqlIdentifier,mqlAssignmentChar
highlight default link mqlAssignment Identifier

syntax match mqlFunction /->/
syntax match mqlFunction /=>/
syntax match mqlFunction /<-/
highlight default link mqlFunction Function

syntax keyword mqlTodo TODO FIXME XXX contained
highlight default link mqlTodo Todo

syntax match mqlComment /#.*/ contains=@Spell,mqlTodo
syntax match mqlComment /####\@!\_.\{-}###/ contains=@Spell,mqlTodo
highlight default link mqlComment Comment

syntax region mqlEmbed start=/`/ end=/`/
highlight default link mqlEmbed Special

" Matches numbers like -10, -10e8, -10E8, 10, 10e8, 10E8
syntax match mqlNumber /\<-\?\d\+\%([eE][+-]\?\d\+\)\?\>/
" Matches hex numbers like 0xfff, 0x000
syntax match mqlNumber /\<0[xX]\x\+\>/
highlight default link mqlNumber Number

" Matches floating-point numbers like -10.42e8, 10.42e-8
syntax match mqlFloat /\<-\?\d\+\.\d\+\%([eE][+-]\?\d\+\)\?/
highlight default link mqlFloat Float

syntax region mqlInterpolation matchgroup=mqlInterpDelim
\                                 start=/\${/ end=/}/
\                                 contained contains=TOP
highlight default link mqlInterpDelim Delimiter

syntax match mqlInterpSimple /\$@\?\K\%(\k\|\.\)*/ contained
highlight default link mqlInterpSimple Identifier

syntax match mqlEscape /\\\d\d\d\|\\x\x\{2\}\|\\u\x\{4\}\|\\./ contained
highlight default link mqlEscape SpecialChar

syntax cluster mqlSimpleString contains=@Spell,mqlEscape
syntax cluster mqlInterpString contains=@mqlSimpleString,mqlInterpSimple,
\                                          mqlInterpolation

syntax region mqlRegExp start=/\// skip=/\\\// end=/\/[gimy]\{,4}/ oneline
\                          contains=@mqlInterpString
highlight default link mqlRegExp String

syntax region mqlString start=/"/ skip=/\\\\\|\\"/ end=/"/ contains=@mqlInterpString
syntax region mqlString start=/'/ skip=/\\\\\|\\'/ end=/'/ contains=@mqlSimpleString
highlight default link mqlString String

syntax region mqlHeredoc start=/"""/ end=/"""/ contains=@mqlInterpString
syntax region mqlHeredoc start=/'''/ end=/'''/ contains=@mqlSimpleString
highlight default link mqlHeredoc String

" Displays an error for trailing whitespace
syntax match mqlSpaceError /\s\+$/ display
highlight default link mqlSpaceError Error

" Displays an error for trailing semicolons
syntax match mqlSemicolonError /;$/ display
highlight default link mqlSemicolonError Error

" Displays an error for reserved words
syntax keyword mqlReservedError case default do function var void with const
let enum export import native
highlight default link mqlReservedError Error
