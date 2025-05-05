flex compiler/flexdata/parser.l

g++ -g \
	-Iconsole \
	-Icompiler/include \
	-Icompiler/include/general \
	-Icompiler/flexdata/shards \
	-Icompiler/source \
	-Icompiler/source/CFG/CFG_math_expressions/include \
lex.yy.c \
compiler/source/SQL_select_CFG.c \
compiler/source/checkpoint.c \
compiler/source/CFG/CFG_math_expressions/source/math_expressions_grammar.c \
compiler/source/CFG/CFG_math_expressions/source/math_inequality_expressions_grammar.c \
compiler/flexdata/shards/data.shard.c \
compiler/flexdata/shards/stack.shard.c \
compiler/flexdata/shards/parser_functions.shard.c \
	-o a.out

read -p "press key to continue"

rm -f lex.yy.c 