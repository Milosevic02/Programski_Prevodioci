%{
  #include <stdio.h>
  #include <stdlib.h>
  #include "defs.h"
  #include "symtab.h"

  int yyparse(void);
  int yylex(void);
  int yyerror(char *s);
  void warning(char *s);

  extern int yylineno;
  char char_buffer[CHAR_BUFFER_LENGTH];
  int error_count = 0;
  int warning_count = 0;
  int var_num = 0;
  int fun_idx = -1;
  int fcall_idx = -1;
  int ret = 0;
  int pom=0;
  int case_count = 0;
  int case_type = 0;
  int case_array[100];
%}

%union {
  int i;
  char *s;
}

%token <i> _TYPE
%token _IF
%token _ELSE
%token _RETURN
%token <s> _ID
%token <s> _INT_NUMBER
%token <s> _UINT_NUMBER
%token _LPAREN
%token _RPAREN
%token _LBRACKET
%token _RBRACKET
%token _ASSIGN
%token _SEMICOLON
%token _FOR
%token _INC
%token _BRANCH
%token _FIRST
%token _SECOND
%token _THIRD
%token _OTHERWISE
%token _COMMA
%token _SWITCH
%token _CASE
%token _BREAK
%token _DEFAULT
%token _COLON


%token <i> _AROP
%token <i> _RELOP

%type <i> num_exp exp literal function_call argument rel_exp

%nonassoc ONLY_IF
%nonassoc _ELSE

%%

program
  : function_list
      {  
        if(lookup_symbol("main", FUN) == NO_INDEX)
          err("undefined reference to 'main'");
       }
  ;

function_list
  : function
  | function_list function
  ;

function
  : _TYPE _ID
      {
        fun_idx = lookup_symbol($2, FUN);
        if(fun_idx == NO_INDEX)
          fun_idx = insert_symbol($2, FUN, $1, NO_ATR, NO_ATR);
        else 
          err("redefinition of function '%s'", $2);
      }
    _LPAREN parameter _RPAREN body
      {
      	if((ret == 0) && (get_type(fun_idx) != VOID))
      		warn("Function should return a value");
      	ret = 0;
        clear_symbols(fun_idx + 1);
        var_num = 0;
      }
  ;

parameter
  : /* empty */
      { set_atr1(fun_idx, 0); }

  | _TYPE _ID
      {
      	if($1 == VOID){
      		err("Parameter cannot be of VOID type");
      	}
        insert_symbol($2, PAR, $1, 1, NO_ATR);
        set_atr1(fun_idx, 1);
        set_atr2(fun_idx, $1);
      }
  ;

body
  : _LBRACKET variable_list statement_list _RBRACKET
  ;

variable_list
  : /* empty */
  | variable_list variable
  ;

variable
  : _TYPE _ID _SEMICOLON
      {
      	 if($1 == VOID){
      		err("variable cannot be of VOID type");
      	}
        if(lookup_symbol($2, VAR|PAR) == NO_INDEX)
           insert_symbol($2, VAR, $1, ++var_num, NO_ATR);
        else 
           err("redefinition of '%s'", $2);
      }
  ;

statement_list
  : /* empty */
  | statement_list statement
  ;

statement
  : compound_statement
  | assignment_statement
  | if_statement
  | return_statement
  |for_statement
  |branch_statement
  |switch_statement
  ;
  
switch_statement
  : _SWITCH _LPAREN _ID 
  {
  	case_type = lookup_symbol($3, VAR|PAR);
  	if(case_type == NO_INDEX)
		err("undefine var");
  
  }
  _RPAREN _LBRACKET case_statements default_statement _RBRACKET
  { case_count = 0;}
  ;
 
case_statements
  : case_statement
  | case_statements case_statement
  ;
  
case_statement
  : _CASE literal
  {
  	int i = 0;
  	while(i != case_count){
  		if(case_array[i] == $2){
  			err("duplicated constant in case");
  			break;
  		}
  		i++;
  	}
  	if(i == case_count){
  		case_array[i] = $2;
  		case_count++;
  	}
  	if(get_type($2) != get_type(case_type))
  		err("Different type");
  }
  _COLON statement break_statement
  ;
 
break_statement
  : 
  | _BREAK _SEMICOLON
  ;
  
default_statement
  : 
  | _DEFAULT _COLON statement;

  
branch_statement
  : _BRANCH _LPAREN _ID
  	{
  		if(lookup_symbol($3,VAR|PAR) == NO_INDEX)
  			err("Not declared var");
  	}
  	 _SEMICOLON literal
  	 {
  	 	int idx = lookup_symbol($3,VAR|PAR);
  	 	if(get_type(idx) != get_type($6))
  	 		err("Different Type");
  	 	pom = atoi(get_name($6));
  	 
	}
  	  _COMMA literal
  	 {
  	 	if(pom > atoi(get_name($9)))
  	 		err("must be ASC");
  	 	if(get_type($6) != get_type($9))
  	 		err("Different Type");
  	 	 pom = atoi(get_name($9));
  	 	
  	 }
  	 
  	  _COMMA literal 
  	 {
  	 	if(pom > atoi(get_name($12)))
  	 		err("must be ASC");
  	 	if(get_type($9) != get_type($12))
  	 		err("Different Type");
  	 	pom = 0;
  	 } 
  	 _RPAREN _FIRST statement _SECOND statement _THIRD statement _OTHERWISE statement  
  
for_statement
  : _FOR _LPAREN _TYPE _ID
  			{
  				int i = lookup_symbol($4, VAR|PAR);
  			        if( i == NO_INDEX)
				   $<i>$ = insert_symbol($4, VAR, $3, ++var_num, NO_ATR);
				else 
				   err("redefinition of '%s'", $4);
  				
  			}
  			 _ASSIGN literal 
  			 {
  			 	if($3 != get_type($7)){
  			 		err("Different type");
  			 	}
  			 }
  			 _SEMICOLON rel_exp _SEMICOLON _ID 
  			 {
  			 	
  			 	if($<i>5 != lookup_symbol($12,VAR))
  			 		err("Different _IDs");
  			 }
  			 _INC _RPAREN statement
  			 {
  			 	clear_symbols($<i>5);
  			 }
  ;

compound_statement
  : _LBRACKET statement_list _RBRACKET
  ;

assignment_statement
  : _ID _ASSIGN num_exp _SEMICOLON
      {
        int idx = lookup_symbol($1, VAR|PAR);
        if(idx == NO_INDEX)
          err("invalid lvalue '%s' in assignment", $1);
        else
          if(get_type(idx) != get_type($3))
            err("incompatible types in assignment");
      }
  ;

num_exp
  : exp
  | num_exp _AROP exp
      {
        if(get_type($1) != get_type($3))
          err("invalid operands: arithmetic operation");
      }
  ;

exp
  : literal
  | _ID
      {
        $$ = lookup_symbol($1, VAR|PAR);
        if($$ == NO_INDEX)
          err("'%s' undeclared", $1);
      }
  | function_call
  | _LPAREN num_exp _RPAREN
      { $$ = $2; }
  ;

literal
  : _INT_NUMBER
      { $$ = insert_literal($1, INT); }

  | _UINT_NUMBER
      { $$ = insert_literal($1, UINT); }
  ;

function_call
  : _ID 
      {
        fcall_idx = lookup_symbol($1, FUN);
        if(fcall_idx == NO_INDEX)
          err("'%s' is not a function", $1);
      }
    _LPAREN argument _RPAREN
      {
        if(get_atr1(fcall_idx) != $4)
          err("wrong number of args to function '%s'", 
              get_name(fcall_idx));
        set_type(FUN_REG, get_type(fcall_idx));
        $$ = FUN_REG;
      }
  ;

argument
  : /* empty */
    { $$ = 0; }

  | num_exp
    { 
      if(get_atr2(fcall_idx) != get_type($1))
        err("incompatible type for argument in '%s'",
            get_name(fcall_idx));
      $$ = 1;
    }
  ;

if_statement
  : if_part %prec ONLY_IF
  | if_part _ELSE statement
  ;

if_part
  : _IF _LPAREN rel_exp _RPAREN statement
  ;

rel_exp
  : num_exp _RELOP num_exp
      {
        if(get_type($1) != get_type($3))
          err("invalid operands: relational operator");
      }
  ;

return_statement
  : _RETURN num_exp _SEMICOLON
      {
      	ret = 1;
      	if(get_type(fun_idx) == VOID){
      		err("Void function cant have return");
      	}
        if(get_type(fun_idx) != get_type($2))
          err("incompatible types in return");
          
        
      }
  | _RETURN _SEMICOLON
  	{
  		ret = 1;
  		if(get_type(fun_idx) != VOID)
  			warn("Function isnt void and should return something");
  	}
  ;

%%

int yyerror(char *s) {
  fprintf(stderr, "\nline %d: ERROR: %s", yylineno, s);
  error_count++;
  return 0;
}

void warning(char *s) {
  fprintf(stderr, "\nline %d: WARNING: %s", yylineno, s);
  warning_count++;
}

int main() {
  int synerr;
  init_symtab();

  synerr = yyparse();

  clear_symtab();
  
  if(warning_count)
    printf("\n%d warning(s).\n", warning_count);

  if(error_count)
    printf("\n%d error(s).\n", error_count);

  if(synerr)
    return -1; //syntax error
  else
    return error_count; //semantic errors
}

