#pragma once


#define ALLOWED_EXPRESSION_SIZE 2048U


struct parsed_data
{
	int parsed_text_code;
	unsigned int parsed_text_length;
	char* parsed_text;
};


extern char  user_instruction_input_buffer[ALLOWED_EXPRESSION_SIZE];
extern char* user_instruction_input_cursor;