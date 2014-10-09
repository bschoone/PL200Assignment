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
%token _END_FOR_ _END_WHILE_ _FOR_ _FUNCTION_ _IF_ _IMPLEMENTATION_ _THEN_ _OF_ 
%token _PROCEDURE_ _TYPE_ _VAR_ _WHILE_ _ASSIGN_ _SEMICOLON_ _OSBRAC_ _CSBRAC_ _OCBRAC_ 
%token _CCBRAC_ _ORBRAC_ _CRBRAC_ _TINYDOT_ _TEARDROP_ _EQUALS_ _NUMBER_ 
%token _IDENT_

%start statement
%%

statement:
		assignment | procedure_call | if_statement | while_statement | do_statement
	|	for_statement | compound_statement
		{printf("statement\n")}
	;

assignment:
		ident _ASSIGN_ expression
		{printf("ident := expression\n")}
	;

procedure_call:
		_CALL_ ident
		{printf("CALL ident\n")}
	;

if_statement:
		_IF_ expression _THEN_ statement _END_IF_
		{printf("IF expression THEN statment END_IF\n")}
	;

while_statement:
		_WHILE_ expression _DO_ statement_loop _END_WHILE_
		{printf("WHILE expression DO statement_loop END_WHILE\n")}
	;

do_statement:
		_DO_ statement_loop _WHILE_ expression _END_DO_
		{printf("DO statement_loop WHILE expression END_DO\n")}
	;

for_statement:
		_FOR_ ident _ASSIGN_ expression _DO_ statement_loop _END_FOR_
		{printf("FOR ident := expression DO statment_loop END FOR\n")}
	;

compound_statement:
		_BEGIN_ statement_loop _END_
		{printf("BEGIN STATMENT_LOOP END\n")}
	;

statement_loop:
		statement
		{printf("STATEMENT\n")}
	|
		statement ';' statement
		{printf("STATEMENT ; STATEMENT\n")}
	;

expression:
		term
		{printf("TERM\n")} 
	|
		term '+' term
		{printf("TERM + TERM\n")}

	| 
		term '-' term		
		{printf("TERM - TERM\n")}
	;

term:
		id_num
		{printf("ID_NUM\n")} 
	|
		id_num '*' id_num
		{printf("ID_NUM * ID_NUM\n")}

	| 
		id_num '/' id_num		
		{printf("ID_NUM / ID_NUM\n")}
	;

id_num:
		ident
		{ printf("ID_NUM\n") } 
	| 
		number
		{ printf("ID_NUM\n") }
	;

ident: 
	_IDENT_
	{
		printf("IDENT\n");
	}
	;


number:
	_NUMBER_
	{
		printf("NUMBER\n");
	}
	;


%%