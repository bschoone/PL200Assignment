%{
#include <stdio.h>
#include "y.tab.h"
%}
%%

"ARRAY"					return _ARRAY_; 
"BEGIN"					return _BEGIN_;
"CALL"					return _CALL_;
"CONST"					return _CONST_;
"DECLARATION"			return _DECLARATION_;
"DO"					return _DO_;	
"END"					return _END_;
"END DO"				return _END_DO_;
"END IF"				return _END_IF_;
"END FOR"				return _END_FOR_;
"END WHILE"				return _END_WHILE_;
"FOR"					return _FOR_;
"FUNCTION"				return _FUNCTION_;
"IMPLEMENTATION"		return _IMPLEMENTATION_;
"OF"					return _OF_
"PROCEDURE"				return _PROCEDURE_;
"TYPE"					return _TYPE_;
"VAR"					return _VAR_;
"WHILE"					return _WHILE_;
":="					return _ASSIGN_;
";"						return _SEMICOLON_;
"["						return _OSBRAC_;
"]"						return _CSBRAC_;
"{"						return _OCBRAC_;
"}"						return _CCBRAC_;
"("						return _ORBRAC_;
")"						return _CRBRAC_;
"."						return _TINYDOT_;
","						return _TEARDROP_;
"="						return _EQUALS_;
"*"						return '*';
"/"						return '/';
"+"						return '+';			
"-"						return '-';
[0-9]+					return _NUMBER_;
[a-z]+					return _IDENT_;

%%
