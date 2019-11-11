%{
  extern "C" int yylex();
  #include "parser.tab.c"
%}

%%
[a-z]	 		{ yylval.stringVal = yytext); return CHAR;}
"T"				{ return TRUE; 		}
"F"				{ return FALSE; 	}
"@"				{ return ASSIGN;	}
"~"				{ return NOT; 		}
":=:"			{ return EQUALS; 	}
":/:"			{ return NOTEQUALS; }
"<"				{ return LT; 		}
">"				{ return GT; 		}
"<="			{ return LTE; 		}
">="			{ return GTE; 		}
"&"				{ return AND; 		}
"%"				{ return NAND; 		}
"|"				{ return OR; 		}
"+"				{ return XOR; 		}
"-"				{ return NOR; 		}
";"           	{ return END; 		}
[ \t\r\n\f]   	;

