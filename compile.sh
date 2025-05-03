flex compiler/flexdata/parser.l

g++ -g \
	-Iconsole \
	-Icompiler/include \
	-Icompiler/include/general \
	-Icompiler/flexdata \
	-Icompiler/flexdata/shards \
	-Icompiler/source \
lex.yy.c \
compiler/source/math_equation_checker.c \
	-o a.out

read -p "press key to continue"

rm -f lex.yy.c 