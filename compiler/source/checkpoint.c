#include "checkpoint.h"
#include <stdlib.h>


void create_checkpoint(int* current_stack_top_pointer)
{
	*current_stack_top_pointer = data_stack.top_pointer;
}


void restore_checkpoint(int checkpointed_top_pointer)
{
	int data_length = 0;
	while (data_stack.top_pointer > checkpointed_top_pointer)
	{
		struct parsed_data* data;
		data = data_stack.peek(), data_stack.pop();
	
		data_length -= data->parsed_text_length;
		
		if (NULL != data->parsed_text)
		{
			free (data->parsed_text);
			data->parsed_text = NULL;
		}
	}
	
	user_instruction_input_cursor += data_length;
	yy_scan_string(user_instruction_input_cursor);
}
