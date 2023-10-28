%{
  #include <stdio.h>
  int yylex(void);
  int yyparse(void);
  int yyerror(char *);
  extern int yylineno;
  int upitnih = 0;
  int uzvicnih = 0;
  int izjavnih = 0;
  int pasus = 0;
%}

%token  _DOT
%token  _CAPITAL_WORD
%token  _WORD
%token _UPITNIK
%token _UZVICNIK
%token _ZAREZ
%token _PASUS

%%


text
  :paragraph _PASUS {pasus++;}
  |text paragraph _PASUS {pasus++;}
  ;     
 
paragraph
  :sentence
  |paragraph sentence;
      
sentence 
  : words end 
  ;
  
end
  :_DOT {izjavnih++;}
  |_UPITNIK{upitnih++;}
  |_UZVICNIK{uzvicnih++;};
  
words 
  : _CAPITAL_WORD
  |words _ZAREZ
  | words _WORD
  | words _CAPITAL_WORD    
  ;

%%

int main() {
  yyparse();
  printf("Izjavnih recencia : %d\nUpitnih recenica : %d\nUzvicnih recenica : %d\n",izjavnih,upitnih,uzvicnih);
  printf("Pasusa:%d\n",pasus);
}

int yyerror(char *s) {
  fprintf(stderr, "line %d: SYNTAX ERROR %s\n", yylineno, s);
} 

