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
%token _PROCEDURE_ _TYPE_ _VAR_ _WHILE_ _ASSIGN_ _SEMICOLON_
%token _EQUALS_ _NUMBER_ 
%token _IDENT_ _DOTDOT_

%start specification_part
%%

enumerated_type
		'{' ident 

range_type:
		'[' range ']'
		{printf("[ range ]\n")}
	;

array_type:
		ARRAY ident '[' range ']' _OF_ array_type
		{printf("ARRAY ident [ range ] of array_type\n")}
	;

range:
		number _DOTDOT_ number
		{printf("number DOTDOT number\n")}
	;
implementation_unit: 
		_IMPLEMENTATION_ _OF_ ident block '.'
		{printf("IMPLEMENTATION OF ident block .\n")}
	;

variable_declaration:
		ident ':' ident ';' 
	;

constant_declaration:
		ident _EQUALS_ number ';' 
	;
block: 
		specification_part implementation_part
		{printf("specification_part implementation_part\n")}
	;
specification_part:
		_CONST_ constant_declaration
	|	_VAR_ variable_declaration
	|	procedure_declaration
	|	function_declaration
	|
	{printf("i dunno what to wriote here\n")}
	;

procedure_declaration:
		_PROCEDURE_ ident ';' block ';'
		{printf("PROCEDURE ident ; block ; \n")}
	;

function_declaration:
		_FUNCTION_ ident ';' block ';'
		{printf("FUNCTION ident ; block ;\n")}
	;

implementation_part:
		statement
		{printf("implementation_part\n")}
	;

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