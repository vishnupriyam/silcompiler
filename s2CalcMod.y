%{ 

	#include <stdio.h> 
	#include <stdlib.h>
	#include "exprtree.h"
	int yylex(void);
	extern FILE *yyin;

struct Node * root;

%} 

%union{
	int ival;
	char op;
	struct Node * nptr;
};

%token NUM PLUS MINUS MUL DIV
%type <char> PLUS MINUS MUL DIV
%type <nptr> NUM;
%type <nptr> expr;
%left PLUS MINUS
%left MUL DIV

%% 
start : expr '\n'		{root=$1;printf("\nComplete , ans is %d\n",evaluate($1));exit(1);} 
	; 

expr:  expr PLUS expr		{$$ = mkOperatorNode('+',$1,$3);/*printf("+ ");*/} 
	| expr MUL expr		{$$ = mkOperatorNode('*',$1,$3);/*printf("* ");*/} 
	| expr MINUS expr	{$$ = mkOperatorNode('-',$1,$3);/*printf("- ");*/}
	| expr DIV expr		{$$ = mkOperatorNode('/',$1,$3);/*printf("/ ");*/}
	| '(' expr ')'	 	{$$ = $2; }
	| NUM		 	{$$ = $1;/*printf("%d  ",yylval.ival);*/}
	; 

%% 

yyerror() 
{ 
	printf("Error"); 
} 

int main(int argc,char* argv[]) 
{ 
	if(argc>1)
	{
		FILE *fp = fopen(argv[1],"r");
		if(fp)
			yyin = fp;
	}	
	yyparse(); 
	return 1; 
} 

