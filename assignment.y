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
		int returncode;
        returncode = yyparse();
        return returncode;
} 

%}

%token _ARRAY_ _BEGIN_ _CALL_ _CONST_ _DECLARATION_ _DO_ _END_ _END_DO_ _END_IF_ 
%token _END_FOR_ _END_WHILE_ _FOR_ _FUNCTION_ _IF_ _IMPLEMENTATION_ _THEN_ _OF_ 
%token _PROCEDURE_ _TYPE_ _VAR_ _WHILE_ _ASSIGN_ _SEMICOLON_
%token _NUMBER_ 
%token _IDENT_ _DOTDOT_

%start basic_program
%%

basic_program:
		declaration_unit
		{printf("basic_program\n");}
	|	implementation_unit
		{printf("basic_program\n");}
	;

/*declaration_unit and its relevant rules*/
optional_const:
		_CONST_	constant_declaration
	|
		{}
	;
optional_var:
		_VAR_ variable_declaration
	|
		{}

	;

optional_type_declaration:
		type_declaration
	|
		{}

	;

optional_procedure_interface:
		procedure_interface
	|
		{}

	;

optional_function_interface:
		function_interface
	|
		{}

	;

declaration_unit:
		_DECLARATION_ _OF_ ident 
			optional_const optional_var 
			optional_type_declaration 
			optional_procedure_interface
			optional_function_interface 
		_DECLARATION_ _END_
		{printf("declaration_unit\n");}
	;
/* -----------------------------------------------*/

procedure_interface:
		_PROCEDURE_ ident
	|	_PROCEDURE_ ident formal_parameters
		{printf("_PROCEDURE_ ident formal_parameters\n");}
	;

function_interface:
		_FUNCTION_ ident
	| 	_FUNCTION_ ident formal_parameters 
		{printf("_FUNCTION ident formal_parameters\n");}
	;

type_declaration:
		_TYPE_ ident ':' type _SEMICOLON_
		{printf("_TYPE_ ident : type ;\n");}
	;

ident_semicolon:
		ident	
	|	ident_semicolon _SEMICOLON_ ident
		{printf("ident_semicolon\n");}
	;	

formal_parameters:
		'(' ident_semicolon ')'
		{printf("formal_parameters\n");}
	;

constant_loop:
		ident '=' number
		{printf("ident = number\n");}
	| 	constant_loop ',' ident '=' number
		{printf("constant_loop\n");}
	;

constant_declaration:
		constant_loop _SEMICOLON_
		{printf("constant_declaration\n");}
	;

variable_loop:
		ident ':' ident
	| 	variable_loop ',' ident ':' ident
		{printf("varible_loop\n");}
	;


variable_declaration:
		variable_loop _SEMICOLON_
		{printf("variable_declaration\n");}
	;

type:
		basic_type
	|
		array_type
		{printf("type: basic_type or array_type\n");}
	;

basic_type:
		ident
	|
		enumerated_type
	|
		range_type
		{printf("basic_type: ident or enumerated type\n");}
	;

ident_list:
		ident	
	|	ident_list ',' ident
		{printf("ident_list\n");}
	;

enumerated_type:
		'{' ident_list '}'
		{printf("enumerated_type\n");}
	;

range_type:
		'[' range ']'
		{printf("[ range ]\n")}
	;

array_type:
		_ARRAY_ ident '[' range ']' _OF_ type
		{printf("ARRAY ident [ range ] of type\n")}
	;

range:
		number _DOTDOT_ number
		{printf("number DOTDOT number\n")}
	;

implementation_unit: 
		_IMPLEMENTATION_ _OF_ ident block '.'
		{printf("IMPLEMENTATION OF ident block .\n")}
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
	{printf("i dunno what to wriote here\n")}
	;

procedure_declaration:
		_PROCEDURE_ ident _SEMICOLON_ block _SEMICOLON_
		{printf("PROCEDURE ident ; block ; \n")}
	;

function_declaration:
		_FUNCTION_ ident _SEMICOLON_ block _SEMICOLON_
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
		statement_loop _SEMICOLON_ statement
		{printf("STATEMENT ; STATEMENT\n")}
	;

expression:
		term
		{printf("TERM\n")} 
	|
		expression '+' term
		{printf("TERM + TERM\n")}

	| 
		expression '-' term		
		{printf("TERM - TERM\n")}
	;

term:
		id_num
		{printf("ID_NUM\n")} 
	|
		term '*' id_num
		{printf("ID_NUM * ID_NUM\n")}

	| 
		term '/' id_num		
		{printf("ID_NUM / ID_NUM\n")}
	;

id_num:
		ident
		{ printf("ID_NUM\n") } 
	| 
		number
		{ printf("ID_NUM\n") }
	;

number:
	_NUMBER_
	{
		printf("NUMBER\n");
	}
	;

ident: 
	_IDENT_
	{
		printf("IDENT\n");
	}
	;

%%