flex compiler/flexdata/parser.l

g++ -g \
	-Iconsole \
	-Icompiler/include \
	-Icompiler/include/general \
	-Icompiler/flexdata/shards \
	-Icompiler/source \
lex.yy.c \
compiler/source/SQL_select_CFG.c \
compiler/flexdata/shards/data.shard.c \
compiler/flexdata/shards/stack.shard.c \
compiler/flexdata/shards/parser_functions.shard.c \
	-o a.out

read -p "press key to continue"

rm -f lex.yy.c 