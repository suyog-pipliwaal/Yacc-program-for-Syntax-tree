# Problem statment
Write a YACC program to generate syntax tree for any string accepted by following grammer:-

	S->id=E
	
	E->E+T|E-T|E*T|T
	
	T->(E)|id
Display your syntax tree by printing in-order and post-order traversal.

![Output ](/image1.png?raw=true)

# Run using following command:-
1. yacc -d sol.y

2. lex sol.l

3. cc lex.yy.c y.tab.c

4 ./a.out
