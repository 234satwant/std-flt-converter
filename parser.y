%{
#include <iostream>
#include <fstream>
#include <string>
using namespace std;

extern "C" int yylex();
extern "C" int yyparse (void);
extern "C" FILE *yyin;

void yyerror(const char *s1);
#define YYDEBUG 1
%}

/**
 %union is used to declare the types for various tokens used. 
 It is particularly used when we need to used more than one type
 */
%union{
	float  f;
}

/**
 Token declaration with appropriate type
 */
%token <f> DIGIT
%token FINISH SC JC MI SEMICOLON

%%

/**
 Grammar rules
 */

converter:
        jc converter  {cout<<" jcconv\n ";}
        | mi converter {cout<<" mifinish\n ";}
        |jc FINISH      {cout<<" jcfinish \n";}
        | mi FINISH     {cout<<" mifinish \n";}
        ;
jc:
        JC coord {cout<<" JCcoord\n";}
        ;
mi:
        MI coord {cout<<" MIcoord\n";}
        ;
coord:
	digit SEMICOLON	{cout<<"DigitSC\n";}
	|digit SEMICOLON coord	{cout<<"DigitSCcoord\n";}
	;
digit:
        DIGIT digit {cout<<" digit "<<$1<<"\n";}
        | {cout<<" empty ";}
        ;


%%

int main(int argc, char **argv)	// Definition of main function
{
	/*int c;
	string arg, out_file;
	if(argc > 1)
	{
		if(!(yyin = fopen(argv[2], "r")))	// open the first argument file and put it in yyin FILE variable 
		{
			perror(argv[1]);
			return (1);
		}

		arg = argv [1];
		if( arg.compare("flt") == 0 )
		c = 1;
			else if( arg.compare("std") == 0 )
		c = 2;

		out_file = argv[3];
	}*/

        // open a file handle to a particular file:
        FILE *myfile = fopen("beam.std", "r");
        // make sure it's valid:
        if (!myfile) {
                cout << "I can't open a.snazzle.file!" << endl;
                return -1;
        }
        // set flex to read from it instead of defaulting to STDIN:
        yyin = myfile;

        // parse through the input until there is no more:
        do {
                yyparse();
        } while (!feof(yyin));

}
void yyerror(const char *s1)	// Definition of function handling error
{
	cout << "Parser error! Message: " << s1 << endl;
	exit(-1);
}
