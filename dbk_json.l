%{
#include "y.tab.h"
%}

%%
\[	{ return TOK_LEFT_SQUARE_BRACKET; }
\{	{ return TOK_LEFT_CURLY_BRACKET; }
\]	{ return TOK_RIGHT_SQUARE_BRACKET; }
\}	{ return TOK_RIGHT_CURLY_BRACKET; }
:	{ return TOK_COLON; }
,	{ return TOK_COMMA; }
true	{ return TOK_TRUE; }
false 	{ return TOK_FALSE; }
null	{ return TOK_NULL; }
[\t|\r|\n| ]* { return TOK_WHITESPACE; }
.	{ ; }
%%

int main(){
	int tok;
	while ((tok = yylex()) != 0){
		printf("TOK:%d\n", tok);
	}
	return 0;
}
