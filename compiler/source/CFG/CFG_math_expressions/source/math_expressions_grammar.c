#include "parser_functions.shard.l"
#include "math_expressions_grammar.h"
#include "checkpoint.h"
#include "types.h"
#include "operators.h"
#include <stdio.h>


static parsing_status CFG_math_expression__E_second__(void);
static parsing_status CFG_math_expression__S_first__(void);
static parsing_status CFG_math_expression__S_second__(void);
static parsing_status CFG_math_expression__W_first__(void);


/***********************/
/* a + b + c + ... + ? */
/* a - b - c - ... - ? */
/* a * b * c * ... * ? */
/* a / b / c / ... / ? */
/********* () **********/
/* and all combination */
/***********************/


/**************************************************/
/******************* CFG RULES ********************/
/*
 * E -> E + S | E - S | S
 * S -> S * W | S / W | W
 * W -> (E) | <integer> | <double> | <variable>
 */
/**************************************************/
/* implementation-wise, problem is left-recursion */
/**************************************************/


/**************************************************/
/******************* CFG RULES ********************/
/*
 * E' -> S'E"
 * E" -> +S'E" | -S'E" | $
 * S' -> W'S"
 * S" -> *W'S" | /W'S" | $
 * W' -> (E') | <integer> | <double> | <variable>
 */
/**************************************************/


parsing_status CFG_math_expression__E_first__(void)
{
	int checkpoint;
	create_checkpoint(&checkpoint);
	
	/* E' -> S'E" */
	if (PARSING_FAILED == CFG_math_expression__S_first__())
	{
		restore_checkpoint(checkpoint);
		return PARSING_FAILED;
	}

	if (PARSING_FAILED == CFG_math_expression__E_second__())
	{
		restore_checkpoint(checkpoint);
		return PARSING_FAILED;
	}
	
	return PARSING_SUCCESSFUL;
}


static parsing_status CFG_math_expression__E_second__(void)
{
	int checkpoint;
	create_checkpoint(&checkpoint);
	
	/* E" -> +S'E" */
	do
	{
		int code = parser_forward();
		if (OPERATOR_PLUS != code) break;
		
		if (PARSING_FAILED == CFG_math_expression__S_first__()) break;
		if (PARSING_FAILED == CFG_math_expression__E_second__()) break;
		
		return PARSING_SUCCESSFUL;
	} while (0);
	restore_checkpoint(checkpoint);
	
	/* E" -> -S'E" */
	do
	{
		int code = parser_forward();
		if (OPERATOR_MINUS != code) break;
		
		if (PARSING_FAILED == CFG_math_expression__S_first__()) break;
		if (PARSING_FAILED == CFG_math_expression__E_second__()) break;
		
		return PARSING_SUCCESSFUL;
	} while (0);
	restore_checkpoint(checkpoint);
	
	/* $ */
	return PARSING_SUCCESSFUL;
}


static parsing_status CFG_math_expression__S_first__(void)
{
	int checkpoint;
	create_checkpoint(&checkpoint);
	
	/* S' -> W'S" */
	if (PARSING_FAILED == CFG_math_expression__W_first__())
	{
		restore_checkpoint(checkpoint);
		return PARSING_FAILED;
	}
	
	if (PARSING_FAILED == CFG_math_expression__S_second__())
	{
		restore_checkpoint(checkpoint);
		return PARSING_FAILED;
	}
	
	return PARSING_SUCCESSFUL;
}


static parsing_status CFG_math_expression__S_second__(void)
{
	int checkpoint;
	create_checkpoint(&checkpoint);
	
	/* S" -> *W'S" */
	do
	{
		int code = parser_forward();
		if (OPERATOR_TIMES != code) break;
		
		if (PARSING_FAILED == CFG_math_expression__W_first__()) break;
		if (PARSING_FAILED == CFG_math_expression__S_second__()) break;
		
		return PARSING_SUCCESSFUL;
	} while (0);
	restore_checkpoint(checkpoint);
	
	/* S" -> /W'S" */
	do
	{
		int code = parser_forward();
		if (OPERATOR_OBELUS != code) break;
		
		if (PARSING_FAILED == CFG_math_expression__W_first__()) break;
		if (PARSING_FAILED == CFG_math_expression__S_second__()) break;
		
		return PARSING_SUCCESSFUL;
	} while (0);
	restore_checkpoint(checkpoint);


	/* $ */
	return PARSING_SUCCESSFUL;
}


static parsing_status CFG_math_expression__W_first__(void)
{
	int checkpoint;
	create_checkpoint(&checkpoint);
	
	/* W' -> (E') */
	do
	{
		int code = parser_forward();
		if (OPERATOR_OPEN_PARENTHESES != code) break;
		if (PARSING_FAILED == CFG_math_expression__E_first__()) break;
		
		code = parser_forward();
		if (OPERATOR_CLOSED_PARENTHESES != code) break;
		
		return PARSING_SUCCESSFUL;
	} while (0);
	restore_checkpoint(checkpoint);
	
	/* W' -> <integer> | <double> | <variable> */
	int code = parser_forward();
	if (
	       (TYPE_INTEGERS_COLLECTION != code) && 
		   (TYPE_REAL_NUMBERS_COLLECTION != code) && 
		   (TYPE_VARIABLE != code)
	   )
    {
	   restore_checkpoint(checkpoint);
	   return PARSING_FAILED;
    }
   
    return PARSING_SUCCESSFUL;
}
