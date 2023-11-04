%{
  #include <stdio.h>
  int yylex(void);
  int yyparse(void);
  int yyerror(char *);
  extern int yylineno;
%}

%token  _DOT
%token  _CAPITAL_WORD
%token  _WORD
%token  _LPAREN
%token  _RPAREN

%%

text 
  : sentence
  | text sentence
  ;
          
sentence 
  : words _DOT
  ;
 
left_postfix
  : _LPAREN
  |
  ;
  
right_postfix
  : _RPAREN
  |
  ;

words 
  : left_postfix _CAPITAL_WORD right_postfix
  | words left_postfix _WORD right_postfix
  | words left_postfix _CAPITAL_WORD right_postfix
  | words left_postfix right_postfix
  ;

%%

int main() {
  yyparse();
}

int yyerror(char *s) {
  fprintf(stderr, "line %d: SYNTAX ERROR %s\n", yylineno, s);
} 

