#pragma once


#include "types.h"


enum operators
{
	OPERATORS_ENUM_BEGIN_SECTION = TYPES_ENUM_END_SECTION + 1,


	/**************************************/	
	/******** arithmetic operators ********/
	OPERATOR_PLUS,
	OPERATOR_MINUS,
	OPERATOR_TIMES,
	OPERATOR_OBELUS,
	OPERATOR_MODULO,
	OPERATOR_INCREMENT,
	OPERATOR_DECREMENT,
	/**************************************/


	/**************************************/	
	/******** relational operators ********/
	OPERATOR_EQUAL_TO,
	OPERATOR_NOT_EQUAL_TO,
	OPERATOR_LESS_THAN,
	OPERATOR_GREATER_THAN,
	OPERATOR_LESS_THAN_OR_EQUAL_TO,
	OPERATOR_GREATER_THAN_OR_EQUAL_TO,
	/**************************************/


	/**************************************/
	/********* logical operators **********/
	OPERATOR_LOGICAL_AND,
	OPERATOR_LOGICAL_OR,
	OPERATOR_LOGICAL_NOT,
	/**************************************/
	
	
	/**************************************/
	/********* bitwise operators **********/
	OPERATOR_AND,
	OPERATOR_OR,
	OPERATOR_XOR,
	OPERATOR_BIT_INVERSE,
	OPERATOR_LEFTSHIFT,
	OPERATOR_RIGHTSHIFT,
	/**************************************/
	
	
	/**************************************/
	/******** assignment operators ********/
	OPERATOR_ASSIGN,
	OPERATOR_ADD_AND_ASSIGN,
	OPERATOR_SUBSTRACT_AND_ASSIGN,
	OPERATOR_MULTIPLY_AND_ASSIGN,
	OPERATOR_DIVIDE_AND_ASSIGN,
	OPERATOR_MODULO_AND_ASSIGN,
	OPERATOR_BITWISE_AND_AND_ASSIGN,
	OPERATOR_BITWISE_OR_AND_ASSIGN,
	OPERATOR_BITWISE_XOR_AND_ASSIGN,
	OPERATOR_BITWISE_LEFTSHIFT_AND_ASSIGN,
	OPERATOR_BITWISE_RIGHTSHIFT_AND_ASSIGN,
	/**************************************/


	/**************************************/
	/********** other operators ***********/
	OPERATOR_OPEN_PARENTHESES,
	OPERATOR_CLOSED_PARENTHESES,
	OPERATOR_OPEN_BRACKET,
	OPERATOR_CLOSED_BRACKET,
	OPERATOR_COMMA,
	/**************************************/
	
	
	OPERATORS_ENUM_END_SECTION
};