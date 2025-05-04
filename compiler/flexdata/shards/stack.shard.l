#pragma once


#include "data.shard.l"


struct parsed_data_stack
{
	int top_pointer;
	struct parsed_data data[ALLOWED_EXPRESSION_SIZE];
	
	void (*push)(struct parsed_data* data);
	void (*pop)(void);
	struct parsed_data* (*peek)(void);
	void (*clear)(void);
};


extern struct parsed_data_stack data_stack;


void stack_init(void);
void stack_push(struct parsed_data* data);
void stack_pop(void);
struct parsed_data* stack_peek(void);
void stack_clear(void);
