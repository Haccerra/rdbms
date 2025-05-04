%{
#include "types.h"
#include "operators.h"
#include "functions.h"
#include "special_values.h"
#include "console_formater.h"
#include "checkpoint.h"
#include "math_equation_checker.h"


#include "data.shard.l"
#include "stack.shard.l"
#include "parser_functions.shard.l"


extern char  user_instruction_input_buffer[ALLOWED_EXPRESSION_SIZE];
extern char* user_instruction_input_cursor;
extern struct parsed_data_stack data_stack;
%}


%%
\n { 
	return NOT_IN_A_DICTIONARY; 
}


[ ] { 
	parser_whitespace_processing(1); 
}


\t { 
	parser_whitespace_processing(4); 
}


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
		printf(BLINKING_TEXT TEXT_COLOUR_MAGENTA "Input >> " RESET_ALL_ATTRIBUTES);
		fgets(user_instruction_input_buffer, sizeof user_instruction_input_buffer, stdin);
		
		if ('\n' == user_instruction_input_buffer[0])
		{
			user_instruction_input_buffer[0] = '\0';
			continue;
		}
		parser_scanner(user_instruction_input_buffer);

		
		unsigned int number_of_codes = 0;
		int* codes = parser_fastforward(&number_of_codes);
		math_equation_checker(codes, number_of_codes);
		data_stack.clear();
	}

	return EXIT_SUCCESS;
}


/**************************************************************************/
/*** used to skip the dynamical linking step in the compilation process ***/
/********************* (-lfl not recognised by mingw) *********************/
/**************************************************************************/
int yywrap(void) { return 1; }