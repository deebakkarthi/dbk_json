%{
#include <stdio.h>
%}
%token TOK_LEFT_SQUARE_BRACKET
%token TOK_LEFT_CURLY_BRACKET
%token TOK_RIGHT_SQUARE_BRACKET
%token TOK_RIGHT_CURLY_BRACKET
%token TOK_COLON
%token TOK_COMMA
%token TOK_TRUE
%token TOK_FALSE
%token TOK_NULL
%token TOK_NUMBER
%token TOK_STRING
%%
 /*
 * Note on how to interpret the rule names
 * =======================================
 * _rep is the + regex operator
 * _opt_rep is the * regex operator
 * Due to the ancientness of yacc I have to resort to using these
 * instead of combining regex and CFG. It makes sense why they decided
 * to restrict it. BNF technically doesn't have these operators and these
 * should only be used in lexing. But coming from ANTLR, where these are
 * present, this seems tedious.
 */

 /*
 * Section 5. JSON Value
 * =====================
 */
value: object
     | array      { printf("array\n"); }
     | TOK_NUMBER { printf("number\n"); }
     | TOK_STRING { printf("string\n"); }
     | TOK_TRUE   { printf("true\n"); }
     | TOK_FALSE  { printf("false\n"); }
     | TOK_NULL   { printf("null\n"); }
     ;

 /*
 * Section 6. JSON Objects
 * =======================
 * object ::= "{" <string> ":" <value> [("," <string> ":" <value>)+] "}"
 */

object: TOK_LEFT_CURLY_BRACKET name_value_pairs_opt TOK_RIGHT_CURLY_BRACKET
      ;

name_value_pair: TOK_STRING TOK_COLON value
	         ;

name_value_pairs: name_value_pair name_value_pair_opt_rep
                ;

name_value_pairs_opt: /*Empty*/
		       | name_value_pairs
		       ;

name_value_pair_opt_rep: /*EMPTY*/
		           | TOK_COMMA name_value_pair name_value_pair_opt_rep
		           ;
 /*
 * Section 7. Arrays
 * =================
 * array ::= "["  <value> [("," <value>)+]  "]"
 */

array: TOK_LEFT_SQUARE_BRACKET value_opt TOK_RIGHT_SQUARE_BRACKET
     ;

value_opt: /*EMPTY*/
	   | value value_opt_rep
	   ;

	/* (, value)* */
value_opt_rep: /*EMPTY*/
	       | TOK_COMMA value value_opt_rep
	       ;
%%

extern FILE *yyin;

void yyerror(char *s)
{
      fprintf(stderr, "%s\n", s);
}

int main()
{
      do{
            if(yyparse()){
                  return 1;
            }
      }while(!feof(yyin));
      return 0;
}

