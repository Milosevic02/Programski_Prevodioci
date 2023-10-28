%{
#include <stdio.h>
%}

%%
[+-]?[1-9][0-9]* { printf("broj: %s\n", yytext); }

0(x|X)[0-9a-fA-F]{1,4}  {printf("heksa: %s\n", yytext); }

[+-]?[0-9]+\.[0-9]* {printf("Realan: %s\n", yytext); }

(?i:break) {printf("kljucna rec: %s\n", yytext); }
%%

int yywrap() {
    return 1;
}

int main() {
    yylex();
    return 0;
}

