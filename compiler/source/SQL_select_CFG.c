#include "parser_functions.shard.l"
#include "SQL_select_CFG.h"
#include "types.h"
#include "special_values.h"
#include "operators.h"
#include "checkpoint.h"
#include <string.h>
#include <stdio.h>


extern "C" int yylex();


/**************************************************/
/* SELECT <col1>, <col2>, ... <col?> FROM <table> */
/**************************************************/


/**************************************************/
/******************* CFG RULES ********************/
/*
 * select_query -> select columns from table
 * columns -> column | column, columns
 * column  -> <column_name as variable type>
 * table   -> <table_name as variable type>
 */
/**************************************************/
parsing_status SQL_CFG_select_query(void)
{
	int checkpoint;
	create_checkpoint(&checkpoint);
	
	int code = parser_forward();
	if (
	       ((int)TYPE_VARIABLE != code) ||
		   (0 != strcasecmp("SELECT", data_stack.peek()->parsed_text))
	   )
	{
		restore_checkpoint(checkpoint);
		return PARSING_FAILED;
	}
	
	/* code = parser_forward(); */
	/* must not be forwarded as it impacts the complex columns rule definition. */
	printf("%s\n", data_stack.peek()->parsed_text);
	if (PARSING_FAILED == SQL_CFG_columns())
	{
		restore_checkpoint(checkpoint);
		return PARSING_FAILED;
	}
	
	code = parser_forward();
	printf("%s\n", data_stack.peek()->parsed_text);
	if (
	       ((int)TYPE_VARIABLE != code) ||
		   (0 != strcasecmp("FROM", data_stack.peek()->parsed_text))
	   )
	{
		restore_checkpoint(checkpoint);
		return PARSING_FAILED;
	}
	
	code = parser_forward();
	if (PARSING_FAILED == SQL_CFG_table())
	{
		restore_checkpoint(checkpoint);
		return PARSING_FAILED;
	}
	
	code = parser_forward();
	if (END_OF_LINE != code)
	{
		restore_checkpoint(checkpoint);
		return PARSING_FAILED;
	}
	
	praser_rewind(1);	/** << removing '\n' from the stack. */
	return PARSING_SUCCESSFUL;
}


parsing_status SQL_CFG_columns(void)
{
	int checkpoint;
	create_checkpoint(&checkpoint);
	
	/* rule {column, columns} */
	printf("Before checkpoint %s\n", data_stack.peek()->parsed_text);
	do
	{
		if (PARSING_FAILED == SQL_CFG_column()) break;
		
		int code = parser_forward();
		if (OPERATOR_COMMA != code) break;
		
		if (PARSING_FAILED == SQL_CFG_columns()) break;
		
		return PARSING_SUCCESSFUL;
	} while (0);
	restore_checkpoint(checkpoint);
	printf("After checkpoint %s\n", data_stack.peek()->parsed_text);
	
	/* rule {column} */
	do
	{
		if (PARSING_FAILED == SQL_CFG_column()) break;
		return PARSING_SUCCESSFUL;
	} while(0);
	
	return PARSING_FAILED;
}


parsing_status SQL_CFG_column(void)
{
	int checkpoint;
	create_checkpoint(&checkpoint);
	
	int code = parser_forward();
	printf("clmn %s\n", data_stack.peek()->parsed_text);
	if ((int)TYPE_VARIABLE != code)
	{
		restore_checkpoint(checkpoint);
		return PARSING_FAILED;
	}
	printf("clmn %s\n", data_stack.peek()->parsed_text);

	return PARSING_SUCCESSFUL;
}


parsing_status SQL_CFG_table(void)
{
	int checkpoint;
	create_checkpoint(&checkpoint);
	
	
	return PARSING_SUCCESSFUL;
}
