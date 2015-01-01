%{
#include <iostream>
#include <string>
using namespace std;

#define YY_DECL extern "C" int yylex()
#include "parser.tab.h"

%}

digits  [0-9]+
integer {digits}
float	({digits}.{digits})
s	[ \t\n\r]+
jc	(JOINT{s}COORDINATES{s})
mi	(MEMBER{s}INCIDENCES{s})
semicolon	[;]
finish 		(FINISH)
%%

{integer}        {yylval.f = atof(yytext);return DIGIT;}
{float}		{yylval.f = atof(yytext);return DIGIT;}
{s}		
{jc}		{return JC; }
{mi}		{return MI; }
{semicolon}	{return SEMICOLON;}
{finish}	{return FINISH;}
.		;
