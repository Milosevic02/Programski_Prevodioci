#include <ctype.h>
#include <stdio.h>
#include <string.h>

int main(void){
    int ch;
    int state = 0;

    char currentWord[15]="";
    int capitalWord = 0;
    int i = -1;

    while(1){
        switch(state){
            case 0:{
                ch = getc(stdin);
                if(ch == '.'){
                    state = 1;
                }else if(ch == ' ' || ch == '\n' || ch == '\t'){
                    if(i > -1){
                        if(capitalWord){
                            capitalWord = 0;
                            state = 2;
                        }
                        else{
                            state = 3;
                        }
                    }
                    else{
                        state = 0;
                    }
                }else if(isupper(ch)){
                    if(i>-1 && !capitalWord){
                        capitalWord = 0;
                    }else{
                        capitalWord = 1;
                    }
                    currentWord[++i] = ch;
                }else if(islower(ch)){
                    currentWord[++i] = ch;
                }
                else if(ch == EOF){
                    return 0;
                }else{
                    state = -1;
                }
                
                
            };break;

            case 1:{
                if(i>-1){
                    if(capitalWord)
                        printf("\nCWORD\t%s\n",currentWord);
                    else
                        printf("\nWORD\t%s\n",currentWord);
                    i = -1;
                    memset(currentWord,'\0',sizeof currentWord);
                }
                printf("\nDOT\t.\n");
                state = 0;
            };break;

            case 2:{
                printf("\nCWORD\t%s\n",currentWord);
                i = -1;
                memset(currentWord,'\0',sizeof currentWord);
                state = 0;
            };break;

            case 3:{
                printf("\nWORD\t%s\n",currentWord);
                i = -1;
                memset(currentWord,'\0',sizeof currentWord);
                state = 0;
            };break;

            case -1:{
                printf("GRESKA: %c",ch);
                return -1;
            };break;
        }
    }
}