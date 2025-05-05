#include "parser_functions.shard.l"
#include "math_inequality_expressions_grammar.h"
#include "math_expressions_grammar.h"
#include "checkpoint.h"
#include "types.h"
#include "operators.h"


static parsing_status CFG_math_inequality_expression__I__(void);


/**************************************************/
/******************* CFG RULES ********************/
/*
 * U -> E' I E'
 * I -> == | != | < | > | <= | >=
 */
/**************************************************/


parsing_status CFG_math_inequality_expression__U__(void)
{
	int checkpoint;
	create_checkpoint(&checkpoint);
	
	/* U -> E' I E' */
	if (PARSING_FAILED == CFG_math_expression__E_first__())
	{
		restore_checkpoint(checkpoint);
		return PARSING_FAILED;
	}
	
	if (PARSING_FAILED == CFG_math_inequality_expression__I__())
	{
		restore_checkpoint(checkpoint);
		return PARSING_FAILED;
	}
	
	if (PARSING_FAILED == CFG_math_expression__E_first__())
	{
		restore_checkpoint(checkpoint);
		return PARSING_FAILED;
	}
	
	return PARSING_SUCCESSFUL;
}


static parsing_status CFG_math_inequality_expression__I__(void)
{
	int checkpoint;
	create_checkpoint(&checkpoint);

	int code = parser_forward();
	/* 	I -> == | != | < | > | <= | >= */
	if (
	       (OPERATOR_EQUAL_TO != code) &&
		   (OPERATOR_NOT_EQUAL_TO != code) &&
		   (OPERATOR_LESS_THAN != code) &&
		   (OPERATOR_GREATER_THAN != code) &&
		   (OPERATOR_LESS_THAN_OR_EQUAL_TO != code) &&
		   (OPERATOR_GREATER_THAN_OR_EQUAL_TO != code)
	   )
    {
		restore_checkpoint(checkpoint);
	    return PARSING_FAILED;
    }
	
	return PARSING_SUCCESSFUL;
}
