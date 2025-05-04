#include <stdio.h>
#include <stdbool.h>
#include "types.h"
#include "functions.h"
#include "operators.h"


/*****************************************/
/**************** formula ****************/
/******** pow(x,2)+pow(y,2)=CONST ********/
/*****************************************/
static bool is_circle_equation(int* codes, unsigned int number_of_codes)
{
	static const unsigned int OPCODES = 15U;
	static const int circle_codes[OPCODES] =
	{
		FUNCTION_POW,
		OPERATOR_OPEN_PARENTHESES,
		TYPE_VARIABLE,
		OPERATOR_COMMA,
		TYPE_INTEGERS_COLLECTION,
		OPERATOR_CLOSED_PARENTHESES,
		OPERATOR_PLUS,
		FUNCTION_POW,
		OPERATOR_OPEN_PARENTHESES,
		TYPE_VARIABLE,
		OPERATOR_COMMA,
		TYPE_INTEGERS_COLLECTION,
		OPERATOR_CLOSED_PARENTHESES,
		OPERATOR_ASSIGN,
		TYPE_INTEGERS_COLLECTION
	};
	
	
	if (number_of_codes != OPCODES)
	{
		return false;
	}
	
	
	bool is_circle_formula = true;
	for (int i = 0; i < OPCODES; i++)
	{
		if (codes[i] != circle_codes[i])
		{
			is_circle_formula = false;
			break;
		}
	}	
	return is_circle_formula;
}


/*****************************************/
/**************** formula ****************/
/* pow(x,2)/pow(a,2)+pow(y,2)/pow(b,2)=1 */
/*****************************************/
static bool is_elipse_equation(int* codes, unsigned int number_of_codes)
{
	static const unsigned int OPCODES = 29U;
	static const int circle_codes[OPCODES] =
	{
		FUNCTION_POW,
		OPERATOR_OPEN_PARENTHESES,
		TYPE_VARIABLE,
		OPERATOR_COMMA,
		TYPE_INTEGERS_COLLECTION,
		OPERATOR_CLOSED_PARENTHESES,
		OPERATOR_OBELUS,
		FUNCTION_POW,
		OPERATOR_OPEN_PARENTHESES,
		TYPE_VARIABLE,
		OPERATOR_COMMA,
		TYPE_INTEGERS_COLLECTION,
		OPERATOR_CLOSED_PARENTHESES,
		OPERATOR_PLUS,
		FUNCTION_POW,
		OPERATOR_OPEN_PARENTHESES,
		TYPE_VARIABLE,
		OPERATOR_COMMA,
		TYPE_INTEGERS_COLLECTION,
		OPERATOR_CLOSED_PARENTHESES,
		OPERATOR_OBELUS,
		FUNCTION_POW,
		OPERATOR_OPEN_PARENTHESES,
		TYPE_VARIABLE,
		OPERATOR_COMMA,
		TYPE_INTEGERS_COLLECTION,
		OPERATOR_CLOSED_PARENTHESES,
		OPERATOR_ASSIGN,
		TYPE_INTEGERS_COLLECTION
	};
	
	
	if (number_of_codes != OPCODES)
	{
		return false;
	}
	
	
	bool is_elipse_formula = true;
	for (int i = 0; i < OPCODES; i++)
	{
		if (codes[i] != circle_codes[i])
		{
			is_elipse_formula = false;
			break;
		}
	}	
	return is_elipse_formula;
}


void math_equation_checker(int* codes, unsigned int number_of_codes)
{
	if (false != is_circle_equation(codes, number_of_codes))
	{
		printf("The given math equation represents circular shape.\n");
	}
	
	
	
	if (false != is_elipse_equation(codes, number_of_codes))
	{
		printf("The given math equation represents elliptic shape.\n");
	}
}