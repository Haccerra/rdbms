#pragma once


#include <assert.h>
#include "data.shard.l"


static void stack_init(void);
static void stack_push(struct parsed_data* data);
static void stack_pop(void);
static struct parsed_data* stack_peek(void);
static void stack_clear(void);


struct parsed_data_stack
{
	int top_pointer;
	struct parsed_data data[ALLOWED_EXPRESSION_SIZE];
	
	void (*push)(struct parsed_data* data);
	void (*pop)(void);
	struct parsed_data* (*peek)(void);
	void (*clear)(void);
};


struct parsed_data_stack data_stack =
{
	.top_pointer = -1,
	.data =
	{
		(int)NOT_IN_A_DICTIONARY,
		0u,
		NULL
	},
	
	.push  = stack_push,
	.pop   = stack_pop,
	.peek  = stack_peek,
	.clear = stack_clear,
};


static void stack_push(struct parsed_data* data)
{
	//printf("%d < %d\n", data_stack.top_pointer, ALLOWED_EXPRESSION_SIZE-1);
	//assert(data_stack.top_pointer < (ALLOWED_EXPRESSION_SIZE-1));
	data_stack.data[++data_stack.top_pointer] = *data;
}


static void stack_pop(void)
{
	assert(data_stack.top_pointer >= 0);
	data_stack.top_pointer--;
}


static struct parsed_data* stack_peek(void)
{
	assert(data_stack.top_pointer >= 0);
	struct parsed_data* data = &data_stack.data[data_stack.top_pointer];
	return data;
}


static void stack_init(void)
{
	data_stack.top_pointer = -1;
	data_stack.push  = stack_push;
	data_stack.pop   = stack_pop;
	data_stack.peek  = stack_peek;
	data_stack.clear = stack_clear;
	
	for (int i = 0; i < ALLOWED_EXPRESSION_SIZE; i++)
	{
		data_stack.data[i].parsed_text_code = NOT_IN_A_DICTIONARY;
		data_stack.data[i].parsed_text_length = 0u;
		data_stack.data[i].parsed_text = NULL;
	}
}


static void stack_clear(void)
{
	data_stack.top_pointer = -1;
	for (int i = 0; i < ALLOWED_EXPRESSION_SIZE; i++)
	{
		data_stack.data[i].parsed_text_code = NOT_IN_A_DICTIONARY;
		data_stack.data[i].parsed_text_length = 0u;
		
		free(data_stack.data[i].parsed_text);
		data_stack.data[i].parsed_text = NULL;
	}
}