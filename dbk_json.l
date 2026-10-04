%{
#include "y.tab.h"
%}

%%
 /*Structural Tokens*/
\[			{ return TOK_LEFT_SQUARE_BRACKET; }
\{			{ return TOK_LEFT_CURLY_BRACKET; }
\]			{ return TOK_RIGHT_SQUARE_BRACKET; }
\}			{ return TOK_RIGHT_CURLY_BRACKET; }
:			{ return TOK_COLON; }
,			{ return TOK_COMMA; }
 /*Name literals*/
true			{ return TOK_TRUE; }
false 			{ return TOK_FALSE; }
null			{ return TOK_NULL; }
	/*Whitespace*/
[\t|\r|\n| ]+ 		{ /*NOP*/; }
 /*
 * Section 8. Numbers
 * ==================
 * number ::= ["-"]
 *            ( "0" | <digit 1-9> <digit>+ )
 *            [ "." <digit>+ ]
 *            [ ("e"|"E") ["+"|"-"] <digit>+ ] 
 */
-?(0|[1-9][0-9]*)(\.[0-9]+)?([eE][+-]?[0-9]*)? { return TOK_NUMBER; }
 /*
 * Section 9. Strings
 * ==================
 * string ::= "\"" [ (<code_point> | <escape_sequence>)* ] "\""
 */
\"(([^\x00-\x1F\x22\x5C]|\\([\"\\\/bfnrt]|u[0-9a-fA-F]{4}))*)?\" { return TOK_STRING; }

 /*TODO: Error out other characters*/
.			{ /*EMPTY*/; }
%%
