#pragma once


#include "stack.shard.l"
#include "parser_functions.shard.l"


#define CREATE_CHECKPOINT(current_stack_top) \
	current_stack_top = data_stack.peek();
	
	
#define RESTORE_CHECKPOINT(checkpointed_stack_top) \
	praser_rewind(data_stack.peek() - checkpointed_stack_top)
