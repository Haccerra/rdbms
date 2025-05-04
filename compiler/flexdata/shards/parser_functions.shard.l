#pragma once


#include <string.h>


/*************************************/
/** Removes yylex undefined error. ***/
/*************************************/
extern "C" int yylex();


/*************************************/
/* Global variables of FLEX library. */
/*************************************/
extern int yyleng;
extern char* yytext;


/*************************************/
/******** Exported functions *********/
/*************************************/
typedef struct yy_buffer_state* YY_BUFFER_STATE;
yy_buffer_state* yy_scan_string(const char*);


void parser_whitespace_processing(int number_of_whitespaces);
int  parser_forward(void);
int* parser_fastforward(unsigned int* number_of_codes);
void praser_rewind(int rew_by);
void parser_scanner(char* input);
