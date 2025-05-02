%{
#define INPUT_BUFFER_SIZE 2048U


#include "cfg_enums.h"
#include "console_formater.h"


extern char input_buffer[INPUT_BUFFER_SIZE];
char input_buffer[INPUT_BUFFER_SIZE];
%}


%%
\n {
	return CFG_MAX;
}


[ ] {}


0|-?[1-9][0-9]* {
	return CFG_DECIMAL;
}


-?[0-9]*\.[0-9]+ {
	return CFG_FLOATING_POINT;
}


[a-zA-Z0-9_]+ {
    return CFG_NAME;
}


(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])\.(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])\.(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])\.(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9]) {
    return CFG_IPv4;
}

. {
	printf(
	          BOLD_TEXT BLINKING_TEXT TEXT_COLOUR_YELLOW "WARNING:" RESET_ALL_ATTRIBUTES
	          " %s is not parsable.\n\n", yytext
		  );
}
%%


int main(int argc, char** argv)
{
	while (true)
	{
		fgets(input_buffer, sizeof input_buffer, stdin);
		
		if ('\n' == input_buffer[0])
		{
			input_buffer[0] = '\0';
			continue;
		}
		yy_scan_string(input_buffer);
		
		
		enum parsable_types parsable_code;
		while (parsable_code = (parsable_types)yylex(), CFG_MAX != parsable_code)
		{
			static const char code2text[][30] =
			{
				"CFG_DECIMAL",
				"CFG_FLOATING_POINT",
				"CFG_NAME",
				"CFG_IPv4",
				"CFG_MAX"
			};
			
			printf (
					   BOLD_TEXT TEXT_COLOUR_PURPLE 
					       "*********************************************************************\n"
					   RESET_ALL_ATTRIBUTES
					   
					   BOLD_TEXT TEXT_COLOUR_PURPLE "\tparsable code" RESET_ALL_ATTRIBUTES " %s\n"
					   BOLD_TEXT TEXT_COLOUR_PURPLE "\tparsed text  " RESET_ALL_ATTRIBUTES " %s\n"
					   BOLD_TEXT TEXT_COLOUR_PURPLE "\tparsed length" RESET_ALL_ATTRIBUTES " %d\n"
					   
					   BOLD_TEXT TEXT_COLOUR_PURPLE 
					       "*********************************************************************\n"
					   RESET_ALL_ATTRIBUTES
					   "\n"
					   , code2text[parsable_code]
					   , yytext
					   , yyleng
				   );
		}
	}




	
	return EXIT_SUCCESS;
}


/* used to skip the dynamical linking step in the compilation process */
int yywrap(void) { return 1; }