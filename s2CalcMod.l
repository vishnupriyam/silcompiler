%{ 
	#include <stdio.h> 
	#include "y.tab.h"
	#include <stdlib.h>
	//#include "exprtree.h"
	struct Node* mkOperatorNode(char c,struct Node *l,struct Node *r);
	struct Node* mkLeafNode(int n);
	int evaluate(struct Node *t);
	struct Node *temp;
	int number;
%} 

%% 

[0-9]+		{number = atoi(yytext);yylval.nptr = mkLeafNode(number);return NUM;}	/*return the number*/
[-+*()\n/]  	{return *yytext;}	/*\n indicates newline , and set of operations , and parenthesis */	
[ \t] 		;	/*ignore whitespaces*/
. 		printf("Unknown character");

%% 

int yywrap()
{
	return 1;
}
      
