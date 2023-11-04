%{
  #include <stdio.h>
  int yylex(void);
  int yyparse(void);
  int yyerror(char *);
  extern int yylineno;
    int upitnih = 0;
  int uzvicnih = 0;
  int izjavnih = 0;
%}

%token  _DOT
%token  _CAPITAL_WORD
%token  _WORD
%token _ZAREZ
%token _UPITNIK
%token _UZVICNIK

%%


text
  :sentence
  |text  sentence
  ;     
 
  
sentence 
  : words end 
  ;

end
  :_DOT {izjavnih++;}
  |_UPITNIK{upitnih++;}
  |_UZVICNIK{uzvicnih++;};
  
words 
  : _CAPITAL_WORD
  |words comma _WORD
  | words  comma _CAPITAL_WORD
  ;

comma
  : /*empty*/
  |_ZAREZ

%%

int main() {
  yyparse();
    printf("Izjavnih recencia : %d\nUpitnih recenica : %d\nUzvicnih recenica : %d\n",izjavnih,upitnih,uzvicnih);
}

int yyerror(char *s) {
  fprintf(stderr, "line %d: SYNTAX ERROR %s\n", yylineno, s);
} 

