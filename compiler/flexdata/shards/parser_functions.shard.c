#include "parser_functions.shard.l"
#include "data.shard.l"
#include "stack.shard.l"
#include "special_values.h"
#include <stdlib.h>


void parser_whitespace_processing(int number_of_whitespaces)
{
	user_instruction_input_cursor += number_of_whitespaces;
	
	struct parsed_data data;
	data.parsed_text_code = WHITESPACE;
	data.parsed_text_length = number_of_whitespaces;
	data.parsed_text = NULL;
	
	data_stack.push(&data);
}


int parser_forward(void)
{
	struct parsed_data data;
	data.parsed_text_code = yylex();
	data.parsed_text_length = yyleng;
	data.parsed_text = (char*) malloc( (yyleng+1)*sizeof(char) ),
		strncpy(data.parsed_text, yytext, yyleng+1);

	user_instruction_input_cursor += yyleng;
	data_stack.push(&data);
	
	return data.parsed_text_code;
}


int* parser_fastforward(unsigned int* number_of_codes)
{
	unsigned int ff_counter = 0u;
	unsigned int codes_size = 1u;
	int* codes = (int*) malloc( sizeof(int) );
	
	int parsed_text_code;
	while (parsed_text_code = yylex(), (NOT_IN_A_DICTIONARY != parsed_text_code))
	{
		struct parsed_data data;
		
		data.parsed_text_code = parsed_text_code;
		data.parsed_text_length = yyleng;
		data.parsed_text = (char*) malloc( (yyleng+1)*sizeof(char) ), 
			strncpy(data.parsed_text, yytext, yyleng+1);
		
		user_instruction_input_cursor += yyleng;
		
		data_stack.push(&data);
		
		int* new_codes = NULL;
		if (ff_counter >= codes_size)
		{
			codes_size <<= 1u;
			new_codes = (int*) realloc( codes, codes_size*sizeof(int) );
			
			assert (NULL != new_codes);
			codes = new_codes;
		}
		codes[ff_counter++] = parsed_text_code;
	}
	
	*number_of_codes = ff_counter;
	return codes;
}


void praser_rewind(int rew_by)
{
	if ((rew_by <= 0) || (user_instruction_input_cursor == user_instruction_input_buffer))
	{
		return;
	}
	
	int rewind_length = 0;
	int rewind_counter = rew_by;
	while (rewind_counter > 0)
	{
		struct parsed_data* data = data_stack.peek();
		data_stack.pop();
		rewind_length -= data->parsed_text_length;
		rewind_counter--;
	}
	
	user_instruction_input_cursor += rewind_length;
	yy_scan_string(user_instruction_input_cursor);
}


void parser_scanner(char* input)
{
	yy_scan_string(input);
	user_instruction_input_cursor = input;
}
