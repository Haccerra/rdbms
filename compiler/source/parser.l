%{
#include "types.h"
#include "operators.h"
#include "functions.h"
#include "special_values.h"
#include "console_formater.h"


#include "data.shard.l"
#include "stack.shard.l"


extern char  user_instruction_input_buffer[ALLOWED_EXPRESSION_SIZE];
extern char* user_instruction_input_cursor;
extern struct parsed_data_stack data_stack;
%}


%%
\n { return NOT_IN_A_DICTIONARY; }


[ ] {}


\t {}


"+"  { return OPERATOR_PLUS; }
"-"  { return OPERATOR_MINUS; }
"*"  { return OPERATOR_TIMES; }
"/"  { return OPERATOR_OBELUS; }
"++" { return OPERATOR_INCREMENT; }
"--" { return OPERATOR_DECREMENT; }


"%"|"mod"|"Mod"|"MOD" {
	return OPERATOR_MODULO;
}


"=="|"eq"|"Eq"|"EQ"|"-eq"|"-Eq"|"-EQ" {
	return OPERATOR_EQUAL_TO;
}


"!="|"ne"|"Ne"|"NE"|"-ne"|"-Ne"|"-NE" {
	return OPERATOR_NOT_EQUAL_TO;
}


"<"|"lt"|"Lt"|"LT"|"-lt"|"-Lt"|"-LT" {
	return OPERATOR_LESS_THAN;
}


">"|"gt"|"Gt"|"GT"|"-gt"|"-Gt"|"-GT" {
	return OPERATOR_GREATER_THAN;
}


"<="|"le"|"Le"|"LE"|"-le"|"-Le"|"-LE" {
	return OPERATOR_LESS_THAN_OR_EQUAL_TO;
}


">="|"ge"|"Ge"|"GE"|"-ge"|"-Ge"|"-GE" {
	return OPERATOR_GREATER_THAN_OR_EQUAL_TO;
}


"&"|"and"|"And"|"AND" { return OPERATOR_LOGICAL_AND; }
"|"|"or"|"Or"|"OR"    { return OPERATOR_LOGICAL_OR;  }
"!"|"not"|"Not"|"NOT" { return OPERATOR_LOGICAL_NOT;  }


"&&" { return OPERATOR_AND; }
"||" { return OPERATOR_OR; }
"^"  { return OPERATOR_XOR; }
"~"  { return OPERATOR_BIT_INVERSE; }
"<<" { return OPERATOR_LEFTSHIFT; }
">>" { return OPERATOR_RIGHTSHIFT; }


"="   { return OPERATOR_ASSIGN; }
"+="  { return OPERATOR_ADD_AND_ASSIGN; }
"-="  { return OPERATOR_SUBSTRACT_AND_ASSIGN; }
"*="  { return OPERATOR_MULTIPLY_AND_ASSIGN; }
"/="  { return OPERATOR_DIVIDE_AND_ASSIGN; }
"%="  { return OPERATOR_MODULO_AND_ASSIGN; }
"&="  { return OPERATOR_BITWISE_AND_AND_ASSIGN; }
"|="  { return OPERATOR_BITWISE_OR_AND_ASSIGN; }
"^="  { return OPERATOR_BITWISE_XOR_AND_ASSIGN; }
"<<=" { return OPERATOR_BITWISE_LEFTSHIFT_AND_ASSIGN; }
">>=" { return OPERATOR_BITWISE_RIGHTSHIFT_AND_ASSIGN; }


"(" { return OPERATOR_OPEN_PARENTHESES; }
")" { return OPERATOR_CLOSED_PARENTHESES; }
"[" { return OPERATOR_OPEN_BRACKET; }
"]" { return OPERATOR_CLOSED_BRACKET; }
"," { return OPERATOR_COMMA; }


"min"|"Min"|"MIN"    { return FUNCTION_MIN;  } 
"max"|"Max"|"MAX"    { return FUNCTION_MAX;  }
"root"|"Root"|"ROOT" { return FUNCTION_ROOT; }
"pow"|"Pow"|"POW"    { return FUNCTION_POW;  }
"sin"|"Sin"|"SIN"    { return FUNCTION_SIN;  }
"cos"|"Cos"|"COS"    { return FUNCTION_COS;  }
"tan"|"Tan"|"TAN"    { return FUNCTION_TAN;  }


"true"|"false" {
	return TYPE_BOOLEAN;
}


0|-?[1-9][0-9]* {
	return TYPE_INTEGERS_COLLECTION;
}


-?[0-9]*\.[0-9]+ {
	return TYPE_REAL_NUMBERS_COLLECTION;
}


[a-zA-Z0-9_]+ {
    return TYPE_VARIABLE;
}


'[^']*'|\"[^"]*\" {
	return TYPE_STRING;
}


(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])\.(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])\.(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])\.(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9]) {
    return TYPE_IPv4;
}


. {
	printf(
	          BOLD_TEXT BLINKING_TEXT TEXT_COLOUR_YELLOW "WARNING:" RESET_ALL_ATTRIBUTES
	          " %s is not parsable.\n", yytext
		  );
}
%%


int main(int argc, char** argv)
{
	while (true)
	{
		fgets(user_instruction_input_buffer, sizeof user_instruction_input_buffer, stdin);
		
		if ('\n' == user_instruction_input_buffer[0])
		{
			user_instruction_input_buffer[0] = '\0';
			continue;
		}
		yy_scan_string(user_instruction_input_buffer);
		
		
		int parsed_text_code;
		while (parsed_text_code = yylex(), NOT_IN_A_DICTIONARY != parsed_text_code)
		{
			static const char code2text[][40] =
			{
				"TYPE_BOOLEAN",
				"TYPE_INTEGERS_COLLECTION",
				"TYPE_REAL_NUMBERS_COLLECTION",
				"TYPE_STRING",
				"TYPE_VARIABLE",
				"TYPE_IPv4",
				"TYPES_ENUM_END_SECTION",
				"OPERATORS_ENUM_BEGIN_SECTION",
				"OPERATOR_PLUS",
				"OPERATOR_MINUS",
				"OPERATOR_TIMES",
				"OPERATOR_OBELUS",
				"OPERATOR_MODULO",
				"OPERATOR_INCREMENT",
				"OPERATOR_DECREMENT",
				"OPERATOR_EQUAL_TO",
				"OPERATOR_NOT_EQUAL_TO",
				"OPERATOR_LESS_THAN",
				"OPERATOR_GREATER_THAN",
				"OPERATOR_LESS_THAN_OR_EQUAL_TO",
				"OPERATOR_GREATER_THAN_OR_EQUAL_TO",
				"OPERATOR_LOGICAL_AND",
				"OPERATOR_LOGICAL_OR",
				"OPERATOR_LOGICAL_NOT",
				"OPERATOR_AND",
				"OPERATOR_OR",
				"OPERATOR_XOR",
				"OPERATOR_BIT_INVERSE",
				"OPERATOR_LEFTSHIFT",
				"OPERATOR_RIGHTSHIFT",
				"OPERATOR_ASSIGN",
				"OPERATOR_ADD_AND_ASSIGN",
				"OPERATOR_SUBSTRACT_AND_ASSIGN",
				"OPERATOR_MULTIPLY_AND_ASSIGN",
				"OPERATOR_DIVIDE_AND_ASSIGN",
				"OPERATOR_MODULO_AND_ASSIGN",
				"OPERATOR_BITWISE_AND_AND_ASSIGN",
				"OPERATOR_BITWISE_OR_AND_ASSIGN",
				"OPERATOR_BITWISE_XOR_AND_ASSIGN",
				"OPERATOR_BITWISE_LEFTSHIFT_AND_ASSIGN",
				"OPERATOR_BITWISE_RIGHTSHIFT_AND_ASSIGN",
				"OPERATOR_OPEN_PARENTHESES",
				"OPERATOR_CLOSED_PARENTHESES",
				"OPERATOR_OPEN_BRACKET",
				"OPERATOR_CLOSED_BRACKET",
				"OPERATOR_COMMA",
				"OPERATORS_ENUM_END_SECTION",
				"FUNCTIONS_ENUM_BEGIN_SECTION",
				"FUNCTION_MIN",
				"FUNCTION_MAX",
				"FUNCTION_ROOT",
				"FUNCTION_POW",
				"FUNCTION_SIN",
				"FUNCTION_COS",
				"FUNCTION_TAN",
				"FUNCTIONS_ENUM_END_SECTION",
			};
			
			printf (
					   BOLD_TEXT TEXT_COLOUR_MAGENTA 
					       "*********************************************************************\n"
					   RESET_ALL_ATTRIBUTES
					   
					   BOLD_TEXT TEXT_COLOUR_MAGENTA "\tparsable code" RESET_ALL_ATTRIBUTES " %s\n"
					   BOLD_TEXT TEXT_COLOUR_MAGENTA "\tparsed text  " RESET_ALL_ATTRIBUTES " %s\n"
					   BOLD_TEXT TEXT_COLOUR_MAGENTA "\tparsed length" RESET_ALL_ATTRIBUTES " %d\n"
					   
					   BOLD_TEXT TEXT_COLOUR_MAGENTA
					       "*********************************************************************\n"
					   RESET_ALL_ATTRIBUTES
					   , code2text[parsed_text_code]
					   , yytext
					   , yyleng
				   );
		}
	}




	
	return EXIT_SUCCESS;
}


/* used to skip the dynamical linking step in the compilation process */
int yywrap(void) { return 1; }