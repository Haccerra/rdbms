#pragma once


#include "stack.shard.l"
#include "parser_functions.shard.l"
#include "parsing_status.h"


#define CREATE_CHECKPOINT(current_stack_top) \
	current_stack_top = data_stack.top_pointer;
	
	
#define RESTORE_CHECKPOINT(checkpointed_stack_top) \
	praser_rewind(data_stack.top_pointer - checkpointed_stack_top)
