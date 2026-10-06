%{
#include "y.tab.h"
void yyerror(char*);
%}
 /*Force yytext to be `char *`*/
%pointer
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
-?(0|[1-9][0-9]*)(\.[0-9]+)?([eE][+-]?[0-9]+)? { return TOK_NUMBER; }
 /*
 * Section 9. Strings
 * ==================
 * string ::= "\"" [ (<code_point> | <escape_sequence>)* ] "\""
 */
\"([^\x00-\x1F\x22\x5C]|(\\([\"\\\/bfnrt]|u([0-9a-fA-F]{4}))))*\" { return TOK_STRING; }

 /*TODO(dbk): 
 What do you return from lex to yacc when there is an error?
 Depending on how forgiving you want the parser to be this could be different.
 Right now I'm returning the first character of failing text stream. Since
 char is <= 127 and yacc usually defines tokens > 258, these will prompt
 yacc to issue an error.
 One corner case is when the failing character is a NULL byte which would
 be returned as 0. 0 has a special meaning in yacc as being the token that
 indicates end of input.
 Normally this wouldn't be a problem but you can have NULL inbetween strings
 which should be flagged as an error. We know that a JSON text cannot have
 NULLs inbetween them. But due to the ergonomics of C, if the characters before
 the NULL form a valid JSON text, we would accept the whole string.
 Eg: "{}\0{}" is not a valid JSON text. It is pretty easy to know when this
 happens as yyin is a FILE and not a string (or atleast I think that's how
 it works).
 */
.	{ yyerror("invalid character"); return *yytext; }
%%
