" Vim syntax file
" Language:	ChucK
" Maintained:	Eduard Aylon <eduard.aylon@gmail.com>
" Last Change:	28/02/2006
" Filenames:	*.ck
" Version:	0.1
" Adapted by Eduard Aylon <eduard.aylon@gmail.com> from the c.vim syntax file from Bram Moolenar <Bram@vim.org>

" NOTE: in order to obtain syntax highlighting in Chuck programs just follow the
"       steps below or in case you don't have root privileges follow Graham Percival's tip : 
"	1. copy this file into /usr/share/vim/vim62/syntax.
"	2. add the following line in /usr/share/vim/filetype.vim, 
"       
"		au BufNewFile,BufRead *.ck          setf ck
"		


"Tip from Graham Percival:
" If you cannot write to /usr/share/  (lacking root privileges),
    "   enter these commands:
    "     $ echo "syntax on" >> ~/.vimrc
    "     $ mkdir ~/.vim
    "     $ mkdir ~/.vim/syntax
    "     $ cp ck.vim ~/.vim/syntax/
    "     $ echo "if exists(\"did_load_filetypes\")
    "           finish
    "         endif
    "         augroup filetypedetect
    "          au! BufNewFile,BufRead *.ck setf ck
    "          augroup END" >> ~/.vim/filetype.vim




" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

"catch errors caused by wrong parenthesis and brackets
" also accept <% for {, %> for }, <: for [ and :> for ] (C99)
syn cluster     cParenGroup contains=cParenError,cIncluded,cSpecial,cCommentSkip,cCommentString,cComment2String,@cCommentGroup,cCommentStartError,cUserCont,cUserLabel,cBitField,cCommentSkip,cOctalZero,cCppOut,cCppOut2,cCppSkip,cFormat,cNumber,cFloat,cOctal,cOctalError,cNumbersCom
if exists("c_no_bracket_error")
  syn region    cParen          transparent start='(' end=')' contains=ALLBUT,@cParenGroup,cCppParen,cCppString
  " cCppParen: same as cParen but ends at end-of-line; used in cDefine
  syn region    cCppParen       transparent start='(' skip='\\$' excludenl end=')' end='$' contained contains=ALLBUT,@cParenGroup,cParen,cString
  syn match     cParenError     display ")"
  syn match     cErrInParen     display contained "[{}]\|<%\|%>"
else
  syn region    cParen          transparent start='(' end=')' contains=ALLBUT,@cParenGroup,cCppParen,cErrInBracket,cCppBracket,cCppString
  " cCppParen: same as cParen but ends at end-of-line; used in cDefine
  syn region    cCppParen       transparent start='(' skip='\\$' excludenl end=')' end='$' contained contains=ALLBUT,@cParenGroup,cErrInBracket,cParen,cBracket,cString
  syn match     cParenError     display "[\])]"
  syn match     cErrInParen     display contained "[\]{}]\|<%\|%>"
  syn region    cBracket        transparent start='\[\|<:' end=']\|:>' contains=ALLBUT,@cParenGroup,cErrInParen,cCppParen,cCppBracket,cCppString
  " cCppBracket: same as cParen but ends at end-of-line; used in cDefine
  syn region    cCppBracket     transparent start='\[\|<:' skip='\\$' excludenl end=']\|:>' end='$' contained contains=ALLBUT,@cParenGroup,cErrInParen,cParen,cBracket,cString
  syn match     cErrInBracket   display contained "[);{}]\|<%\|%>"
endif



if exists("c_no_cformat")
  syn region    cString         start=+L\="+ skip=+\\\\\|\\"+ end=+"+ contains=cSpecial
  " cCppString: same as cString, but ends at end of line
  syn region    cCppString      start=+L\="+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end='$' contains=cSpecial
else
  syn match     cFormat         display "%\(\d\+\$\)\=[-+' #0*]*\(\d*\|\*\|\*\d\+\$\)\(\.\(\d*\|\*\|\*\d\+\$\)\)\=\([hlL]\|ll\)\=\([diuoxXDOUfeEgGcCsSpn]\|\[\^\=.[^]]*\]\)" contained
  syn match     cFormat         display "%%" contained
  syn region    cString         start=+L\="+ skip=+\\\\\|\\"+ end=+"+ contains=cSpecial,cFormat
  " cCppString: same as cString, but ends at end of line
  syn region    cCppString      start=+L\="+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end='$' contains=cSpecial,cFormat
endif


if exists("c_comment_strings")
  " A comment can contain cString, cCharacter and cNumber.
  " But a "*/" inside a cString in a cComment DOES end the comment!  So we
  " need to use a special type of cString: cCommentString, which also ends on
  " "*/", and sees a "*" at the start of the line as comment again.
  " Unfortunately this doesn't very well work for // type of comments :-(
  syntax match  cCommentSkip    contained "^\s*\*\($\|\s\+\)"
  syntax region cCommentString  contained start=+L\=\\\@<!"+ skip=+\\\\\|\\"+ end=+"+ end=+\*/+me=s-1 contains=cSpecial,cCommentSkip
  syntax region cComment2String contained start=+L\=\\\@<!"+ skip=+\\\\\|\\"+ end=+"+ end="$" contains=cSpecial
  syntax region  cCommentL      start="//" skip="\\$" end="$" keepend  contains=@cCommentGroup,cComment2String,cCharacter,cNumbersCom,cSpaceError
  syntax region cComment        matchgroup=cCommentStart start="/\*" end="\*/" contains=@cCommentGroup,cCommentStartError,cCommentString,cCharacter,cNumbersCom,cSpaceError
else
  syn region    cCommentL       start="//" skip="\\$" end="$" keepend contains=@cCommentGroup,cSpaceError
  syn region    cComment        matchgroup=cCommentStart start="/\*" end="\*/" contains=@cCommentGroup,cCommentStartError,cSpaceError
endif


syn match ckNone                "\w\+\.\w\+"
syn match   ckNumber      "\<0x\x\+[Ll]\=\>"
syn match   ckNumber      "\<\d\+[LljJ]\=\>"
syn match   ckNumber      "\.\d\+\([eE][+-]\=\d\+\)\=[jJ]\=\>"
syn match   ckNumber      "\<\d\+\.\([eE][+-]\=\d\+\)\=[jJ]\=\>"
syn match   ckNumber      "\<\d\+\.\d\+\([eE][+-]\=\d\+\)\=[jJ]\=\>"


" CHUCK extentions
syn keyword ckStatement	        new goto break return continue spork 
syn keyword ckConditional       if else switch
syn keyword ckLoop		while for do until
syn keyword ckNow               now 
syn keyword ckType              dur time Shred UGen Event Object 
syn keyword cType               int float string void
syn keyword ckAccess		public protected private
syn keyword ckOperator		and bitor or xor compl bitand and_eq or_eq xor_eq not not_eq
syn match ckCast               "\s*\$\s*\(int\|float\)\s"
syn keyword ckStructure	        class fun 
syn keyword ckUgen		gain noise impulse step phasor sinosc pulseosc triosc sqrosc sawosc halfrec fullrect zerox delayp sndbuf pan2      
syn keyword ckSDK               bandedWG blowbotl BlowHole Bowed Brass Clarinet Flute Mandolin ModalBar Moog Saxofony Shakers Sitar StifKarp VoicForm FM BeeThree FMVoices HevyMetl PercFlut Rhodey TubeBell Wurley Delay DelayA DelayL Echo Envelope ADSR biquad Filter OnePole TwoPole OneZero TwoZero PoleZero JCRev NRev PRCRev Chorus Modulate PitShift SubNoise WvIn WvOut WaveLoop
syn keyword ckBoolean		true false
syn keyword ckShreds            me machine
syn keyword ckInheritance       subClass extends 
syn keyword ckIO                dac adc blackhole 
syn keyword ckNetwork           netin netout
syn keyword ckCommunication     MidiIn MidiOut MidiMsg OSC_Recv OSC_Addr OSC_Send
syn keyword ckConstants 	pi
syn match   ckOperator          "\s*=\(>\|<\)\s*"          

" The minimum and maximum operators in GNU C++
syn match cppMinMax "[<>]?"

" Default highlighting
if version >= 508 || !exists("did_cpp_syntax_inits")
  if version < 508
    let did_cpp_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink ckCommunication        Special
  HiLink ckNetwork              Special
  HiLink cCommentL		cComment
  HiLink cCommentStart		cComment
  HiLink cComment 		Comment
  HiLink cCppString             cString
  HiLink cString		String
  HiLink ckConditional          Conditional
  HiLink ckLoop			Repeat
  HiLink ckAccess		ckStatement
  HiLink ckUgen                 ckType
  HiLink ckSDK                  ckType
  HiLink ckStatement		Statement
  HiLink ckCast 		ckStatement
  HiLink ckNow			Special
  HiLink ckType		        Type
  HiLink cType		        Type
  HiLink ckStructure		Structure
  HiLink ckOperator		Operator	
  HiLink ckShreds		ckStatement
  HiLink ckInheritance		ckStatement
  HiLink ckBoolean		Boolean
  HiLink ckIO			Include
  HiLink cParenError		cError
  HiLink cErrInBracket		cError
  HiLink cErrInParen		cError
  HiLink cParen			cError
  HiLink cCppParen		cError
  HiLink cBracket	  	cError
  HiLink cCppBracket	  	cError
  HiLink cError			Error
  HiLink ckNumber		Number
  HiLink ckConstants		Constant
  
  delcommand HiLink
endif

let b:current_syntax = "ck"

" vim: ts=8
