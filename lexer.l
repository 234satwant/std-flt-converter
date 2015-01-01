%{
#include <iostream>
#include <string>
using namespace std;

#define YY_DECL extern "C" int yylex()
#include "parser.tab.h"

%}

digits  [0-9]+
integer {digits}
s	[ \t\n\r]+
jc	(JOINT{s}COORDINATES{s})
mi	(MEMBER{s}INCIDENCES{s})
semicolon	[;]
finish 		(FINISH)
month		[A-Za-z]+
date		({digits}-{month}-{digits})
width		(WIDTH{s}{digits})
%%

{integer}        {yylval.f = atof(yytext);return DIGIT;}
{s}		
{jc}		{return JC; }
{mi}		{return MI; }
{semicolon}	{return SEMICOLON;}
{finish}	{return FINISH;}
{width}		
{date}
.		;
