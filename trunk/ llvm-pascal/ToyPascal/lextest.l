%{
#include <stdio.h>
%}

%%
"Integer"               printf("T_INTEGER ");
"Var"                   printf("T_VAR ");
"Begin"                 printf("T_BEGIN ");
"End"                   printf("T_END ");
"Procedure"             printf("T_PROCEDURE ");
"Function"              printf("T_FUNCTION ");

"*"                     printf("T_MULT ");
"/"                     printf("T_DIV ");
"+"                     printf("T_ADD ");
"-"                     printf("T_SUB ");
":="                    printf("T_ATTRIBUTION ");
";"                     printf("T_SEMICOLON ");
":"                     printf("T_COLON ");
"."                     printf("T_DOT ");

[0-9]+                  printf("NUMBER ");
[A-Za-z][A-Za-z0-9]*    printf("IDENTIFIER ");

[ \t]+                  /* ignora whitespace */;
\n                      printf("\n");
%%

