yacc -y -d $1.y
lex $1.l
gcc y.tab.c lex.yy.c

