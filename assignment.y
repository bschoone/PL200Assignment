%{
#include <stdio.h>
#include <string.h>
 
void yyerror(const char *str)
{
        fprintf(stderr,"error: %s\n",str);
}
 
int yywrap()
{
        return 1;
} 
  
main()
{
        yyparse();
} 

%}

%token _ARRAY_ _BEGIN_ _CALL_ _CONST_ _DECLARATION_ _DO_ _END_ _END_DO_ _END_IF_ 
%token _END_FOR_ _END_WHILE_ _FOR_ _FUNCTION_ _IMPLEMENTATION_ _OF_ _PROCEDURE_ 
%token _TYPE_ _VAR_ _WHILE_ _ASSIGN_ _SEMICOLON_ _OSBRAC_ _CSBRAC_ _OCBRAC_ 
%token _CCBRAC_ _ORBRAC_ _CRBRAC_ _TINYDOT_ _TEARDROP_ _EQUALS_ _NUMBER_ 
%token _IDENT_

%% 

ident: 
	_IDENT_
	{
		printf("IDENT");
	}
	;


number:
	_NUMBER_
	{
		printf("NUMBER");
	}
	;

%%