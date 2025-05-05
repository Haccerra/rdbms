#include "basic_operations.h"
#include "types.h"
#include "operators.h"
#include "functions.h"


int get_operator_precedence(int code)
{
	int opcode = -1;
	switch (code)
	{
		case (int)OPERATOR_OPEN_PARENTHESES:
		case (int)OPERATOR_CLOSED_PARENTHESES:
		{
			opcode = 0;
		} break;
		
		case (int)OPERATOR_LOGICAL_OR:
		{
			opcode = 1;
		} break;
		
		case (int)OPERATOR_LOGICAL_AND:
		{
			opcode = 2;
		} break;
		
		case (int)OPERATOR_EQUAL_TO:
		case (int)OPERATOR_NOT_EQUAL_TO:
		case (int)OPERATOR_LESS_THAN:
		case (int)OPERATOR_GREATER_THAN:
		case (int)OPERATOR_LESS_THAN_OR_EQUAL_TO:
		case (int)OPERATOR_GREATER_THAN_OR_EQUAL_TO:
		{
			opcode = 3;
		} break;
		
		case (int)FUNCTION_SIN:
		case (int)FUNCTION_COS:
		case (int)FUNCTION_TAN:
		case (int)FUNCTION_MIN:
		case (int)FUNCTION_MAX:
		case (int)FUNCTION_POW:
		case (int)FUNCTION_ROOT:
		{
			opcode = 4;
		} break;
		
		case (int)OPERATOR_PLUS:
		case (int)OPERATOR_MINUS:
		{
			opcode = 5;
		} break;
		
		case (int)OPERATOR_TIMES:
		case (int)OPERATOR_OBELUS:
		case (int)OPERATOR_MODULO:
		{
			opcode = 6;
		} break;
	}
	
	return opcode;
}


bool is_operator(int code)
{
	return (code > (int)OPERATORS_ENUM_BEGIN_SECTION) && (code < (int)OPERATORS_ENUM_END_SECTION);
}


bool is_type(int code)
{
	return (code > (int)TYPES_ENUM_BEGIN_SECTION) && (code < (int)TYPES_ENUM_END_SECTION);
}

