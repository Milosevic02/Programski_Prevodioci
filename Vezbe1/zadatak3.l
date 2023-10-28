%{
#include <stdio.h>
%}

%%
[+-]?[0-9]+F {printf("%dC",((atoi(yytext)-32)*5/9));}

%%
int yywrap() {
    return 1;
}

int main() {
    yylex();
    return 0;
}