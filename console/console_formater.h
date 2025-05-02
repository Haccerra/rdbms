#pragma once


/* https://misc.flogisoft.com/bash/tip_colors_and_formatting */


#define PLAIN_TEXT                 "\e[0m"
#define BOLD_TEXT                  "\e[1m"
#define DIM_TEXT                   "\e[2m"
#define ITALIC_TEXT                "\e[3m"
#define UNDERLINED_TEXT            "\e[4m"
#define BLINKING_TEXT              "\e[5m"
#define INVERTED_COLOUR_TEXT       "\e[7m"
#define STRIKETHROUGHED_TEXT       "\e[9m"


#define RESET_ALL_ATTRIBUTES       "\e[0m"
#define RESET_BOLD_TEXT            "\e[21m"
#define RESET_DIM_TEXT             "\e[22m"
#define RESET_ITALIC_TEXT          "\e[23m"
#define RESET_UNDERLINED_TEXT      "\e[24m"
#define RESET_BLINKING_TEXT        "\e[25m"
#define RESET_INVERTED_COLOUR_TEXT "\e[27m"
#define RESET_STRIKETHROUGHED_TEXT "\e[29m"


#define TEXT_COLOUR_BLACK          "\e[30m"
#define TEXT_COLOUR_RED            "\e[91m"
#define TEXT_COLOUR_GREEN          "\e[92m"
#define TEXT_COLOUR_YELLOW         "\e[93m"
#define TEXT_COLOUR_BLUE           "\e[34m"
#define TEXT_COLOUR_MAGENTA        "\e[35m"
#define TEXT_COLOUR_CYAN           "\e[36m"
#define TEXT_COLOUR_WHITE          "\e[97m"


#define BACKGROUND_COLOUR_BLACK    "\e[40m"
#define BACKGROUND_COLOUR_RED      "\e[41m"
#define BACKGROUND_COLOUR_GREEN    "\e[42m"
#define BACKGROUND_COLOUR_YELLOW   "\e[43m"
#define BACKGROUND_COLOUR_BLUE     "\e[44m"
#define BACKGROUND_COLOUR_MAGENTA  "\e[45m"
#define BACKGROUND_COLOUR_CYAN     "\e[46m"
#define BACKGROUND_COLOUR_WHITE    "\e[107m"