#pragma once


#include "stack.shard.l"
#include "parser_functions.shard.l"
#include "parsing_status.h"

	
void create_checkpoint(int* current_stack_top_pointer);
void restore_checkpoint(int checkpointed_top_pointer);
