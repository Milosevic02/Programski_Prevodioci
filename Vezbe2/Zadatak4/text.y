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
%token _COLON
%token _CHARACTER

%%

text 
  : character sentence
  | text character sentence
  ;
    
character
  :_CHARACTER _COLON
  |
  ;
        
sentence 
  : words _DOT
  ;

words 
  : _CAPITAL_WORD
  | words _WORD
  | words _CAPITAL_WORD    
  ;

%%

int main() {
  yyparse();
}

int yyerror(char *s) {
  fprintf(stderr, "line %d: SYNTAX ERROR %s\n", yylineno, s);
} 

