#pragma once


#include "stack.shard.l"
#include "parser_functions.shard.l"


enum parsing_status
{
	PARSING_SUCCESSFUL,
	PARSING_FAILED
};


#define CREATE_CHECKPOINT(current_stack_top) \
	current_stack_top = data_stack.peek();
	
	
#define RESTORE_CHECKPOINT(checkpointed_stack_top) \
	praser_rewind(data_stack.peek() - checkpointed_stack_top)


#define INITIALISE_PARSER(void)                     \
	{                                               \
		int code = 0;                               \
		int checkpoint;                             \
		                                            \
		CREATE_CHECKPOINT(checkpoint);              \
		                                            \
		parsing_status status = PARSING_SUCCESSFUL; \
	}


#define SUCCESSFULLY_PARSED \
	return PARSING_SUCCESSFUL
	

#define UNSUCCESSFULLY_PARSED  \
	{                          \
		RESTORE_CHECKPOINT();  \
		return PARSING_FAILED; \
	}
