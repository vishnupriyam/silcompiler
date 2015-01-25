%{ 

#include <stdio.h> 
#include <stdlib.h>
#include <string.h>
//#include "lex.yy.c"
int yylex();
extern FILE *yyin;
%} 
%union{
	char* prefix;
};

%token NUM
%type <prefix> NUM;
%type <prefix> expr; 
%left '+'
%left '*'

%% 
start : expr '\n'		{printf("\nComplete , ans is %s\n",$1);free($1);exit(1);}
	; 

expr:  expr '+' expr		{
				 $$ = (char*)malloc(sizeof($1)+ sizeof($3)+1);
				 strcpy($$,"+ ");
				 strcat($$,strcat($1,$3));
				 free($1);free($3);
				} 
	| expr '*' expr		{
				 $$ = (char*)malloc(sizeof($1)+ sizeof($3)+1);
				 strcpy($$,"* ");
				 strcat($$,strcat($1,$3));
			         free($1);free($3);
				} 
	| '(' expr ')'	 	{
				 $$ = (char*)malloc(sizeof($2));
				 strcpy($$,$2);
				 free($2);
				}
	| NUM		 	{ 
				 $$ = (char*)malloc(sizeof($1)+1);
				 strcpy($$,strcat($1," "));
				}
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

