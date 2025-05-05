%{
#include "types.h"
#include "operators.h"
#include "functions.h"
#include "special_values.h"
#include "console_formater.h"
#include "checkpoint.h"
#include "SQL_select_CFG.h"
#include "math_expressions_grammar.h"
#include "math_inequality_expressions_grammar.h"
#include "math_logical_expressions_grammar.h"


#include "data.shard.l"
#include "stack.shard.l"
#include "parser_functions.shard.l"
%}


%%
\n { 
	return END_OF_LINE; 
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
	return NOT_IN_A_DICTIONARY;
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


		enum parsing_status status = CFG_math_inequality_expression__U__();
		if (PARSING_FAILED != status)
		{
			printf (
					   "Input %s is a valid mathematical "
					   TEXT_COLOUR_GREEN BOLD_TEXT UNDERLINED_TEXT BLINKING_TEXT 
					   " INEQUALITY " 
					   RESET_ALL_ATTRIBUTES
					   "expression.\n\n"
					   , user_instruction_input_buffer
				   );
				   
			printf ("*****************************************************\n");
			while (data_stack.top_pointer >= 0)
			{
				printf( 
						  BOLD_TEXT
						  "[%d], [%s]\n"
						  RESET_ALL_ATTRIBUTES,
						  data_stack.top_pointer, 
						  data_stack.peek()->parsed_text
				      );
				data_stack.pop();
			}
			printf ("*****************************************************\n\n");
	    }
		else
		{
			status = CFG_math_logical_expression__P__();
			if (PARSING_FAILED != status)
			{
				printf (
						   "Input %s is a valid mathematical "
						   TEXT_COLOUR_GREEN BOLD_TEXT UNDERLINED_TEXT BLINKING_TEXT 
						   " LOGICAL " 
						   RESET_ALL_ATTRIBUTES
						   "expression.\n\n"
						   , user_instruction_input_buffer
					   );
					   
				printf ("*****************************************************\n");
				while (data_stack.top_pointer >= 0)
				{
					printf( 
							  BOLD_TEXT
							  "[%d], [%s]\n"
							  RESET_ALL_ATTRIBUTES,
							  data_stack.top_pointer, 
							  data_stack.peek()->parsed_text
						  );
					data_stack.pop();
				}
				printf ("*****************************************************\n\n");
			}
			
			
			status = CFG_math_expression__E_first__();
			int code = parser_forward();
			if (END_OF_LINE != code)
			{
				printf(
						  BOLD_TEXT UNDERLINED_TEXT TEXT_COLOUR_RED BLINKING_TEXT
						  "Error! "
						  RESET_ALL_ATTRIBUTES
						  TEXT_COLOUR_RED
						  "Input is not a valid mathematical expression.\n\n",
						  RESET_ALL_ATTRIBUTES
					  );
			}
			else if (PARSING_FAILED != status)
			{
				printf (
						   TEXT_COLOUR_GREEN
						   "Input %s is a valid mathematical expression.\n\n"
						   RESET_ALL_ATTRIBUTES
						   , user_instruction_input_buffer
					   );
					   
				printf ("*****************************************************\n");
				while (data_stack.top_pointer >= 0)
				{
					printf( 
							  BOLD_TEXT
							  "[%d], [%s]\n"
							  RESET_ALL_ATTRIBUTES,
							  data_stack.top_pointer, 
							  data_stack.peek()->parsed_text
						  );
					data_stack.pop();
				}
				printf ("*****************************************************\n\n");
			}
			else
			{
				/* next scenario to be tested */
			}
		}

		data_stack.clear();
	}

	return EXIT_SUCCESS;
}


/**************************************************************************/
/*** used to skip the dynamical linking step in the compilation process ***/
/********************* (-lfl not recognised by mingw) *********************/
/**************************************************************************/
int yywrap(void) { return 1; }