#include "parser_functions.shard.l"
#include "math_inequality_expressions_grammar.h"
#include "math_expressions_grammar.h"
#include "checkpoint.h"
#include "types.h"
#include "operators.h"


static parsing_status CFG_math_logical_expression__L__(void);


/**************************************************/
/******************* CFG RULES ********************/
/*
 * P -> E' L E'
 * L -> <and> | <or> | <not>
 */
/**************************************************/


parsing_status CFG_math_logical_expression__P__(void)
{
	int checkpoint;
	create_checkpoint(&checkpoint);
	
	/* P -> E' L E' */
	if (PARSING_FAILED == CFG_math_expression__E_first__())
	{
		restore_checkpoint(checkpoint);
		return PARSING_FAILED;
	}
	
	if (PARSING_FAILED == CFG_math_logical_expression__L__())
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


static parsing_status CFG_math_logical_expression__L__(void)
{
	int checkpoint;
	create_checkpoint(&checkpoint);

	int code = parser_forward();
	/* 	L -> <and> | <or> | <not> */
	if (
	       (OPERATOR_LOGICAL_AND != code) &&
		   (OPERATOR_LOGICAL_OR  != code) &&
		   (OPERATOR_LOGICAL_NOT != code)
	   )
    {
		restore_checkpoint(checkpoint);
	    return PARSING_FAILED;
    }
	
	return PARSING_SUCCESSFUL;
}

