%{
#include"y.tab.h"
%}

%%
[0-9]+			{yylval.a_number = atoi(yytext); return number;}

[a-zA-Z]		{yylval.a_variable = yytext[0];return variable;}

[-+*/( )=]              {return yytext[0];}

[ \t\n]			{;}

.			{printf("unexcepted character");}
%%
