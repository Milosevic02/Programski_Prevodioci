%{
  #include <stdio.h>
  int yylex(void);
  int yyparse(void);
  int yyerror(char *);
  extern int yylineno;
  int pasus = 0;
%}

%token  _DOT
%token  _CAPITAL_WORD
%token  _WORD
%token _NL

%%

text 
  : paragraph _NL{pasus++;}
  | text paragraph _NL{pasus++;}
  ;
  
paragraph
  :sentence
  |paragraph sentence
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
  printf("Pasusa:%d",pasus);
}

int yyerror(char *s) {
  fprintf(stderr, "line %d: SYNTAX ERROR %s\n", yylineno, s);
} 

