%{ 
	#include <stdio.h> 
	#include "y.tab.h"
	extern YYSTYPE yylval;
%} 

%% 

[0-9]+	  { yylval.prefix = (char*)malloc(sizeof(yytext));
	    strcpy(yylval.prefix,yytext);
	    //printf("%s\n",yylval.prefix);	
	    return NUM;
	  }

[+*()\n]  { 
	    strcpy(yylval.prefix,yytext);
            //printf("%s\n",yylval.prefix);
	    return *yytext;
	  }
[ \t] ;
. {printf("Unknown character\n");exit(1);}

%% 

int yywrap()
{
	return 1;
}
      
