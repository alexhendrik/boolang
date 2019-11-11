%{
  #include <iostream>
  #include <stbool.h>
  #include <map>
  static std::map<char, bool> variables;
  using namespace std;
  extern "C" int yyparse();
%}

%union{
  char chr;
  bool boolean;
}

%start program

%token <chr> CHAR
%token SEMI
%type <boolean> expression
%type <boolean> line
%left EQUALS NOTEQUALS
%left LT LTE
%left GT GTE
%left AND NAND
%left OR XOR NOR

%%

program: 
	/* lambda OR */	| program line	{ cout << "Evaluation: " << $2 << endl; }
;

line: expression END | declaration END;

declaration: 
	TRUE ASSIGN CHAR { $$ = variables[$3] = true; }
	| FALSE ASSIGN CHAR { $$ = variables[$3] = false; }
; 

value: 
	TRUE 	{ $$ = true; } 
	| FALSE { $$ = false; } 
	| CHAR 	{ $$ = variables[$1]; }
;

expression:
	value
	| '(' expression ')' { $$ = $2; }
	| NOT expression { $$ = !$2; }
	| expression EQUALS expression { $$ = $1 == $3; }
	| expression NOTEQUALS expression { $$ = $1 != $3; }
	| expression AND expression { $$ = $1 && $3; }
	| expression NAND expression { $$ = !($1 && $3); }
	| expression OR expression { $$ = $1 || $3; }
	| expression XOR expression { $$ = $1 != $3; }
	| expression NOR expression { $$ = $1 == $3 == false; }
	;

%%

int main(int argv, char **argc) {

  if (argv != 1) {
    cout << "Please pass a file name as an argument";
    exit(1);
  }

  FILE *sourceFile = fopen(argc[1], "r");

  yyin = sourceFile;
  yyparse();
}

