
words = """ALNUM
ALPHA
BLANK
CNTRL
COLON
COMMA
COMMENT
DAY
DIGIT
DOLLAR
DOT
ESCAPESEQUENCE
GRAPH
GT
ID
INTEGER
LBRACE
LBRACK
LOWER
LPAREN
LT
MONTH
NL
OR
POWER
PRINT
PUNCT
RBRACE
RBRACK
RPAREN
SEMICOLON
SPACE
STAR
TIMEZONE
UNDERSCORE
UPPER
WS
XDIGIT"""

words = [x.strip() for x in words.splitlines()]

for WORD in words:
    code = f"""
{{{WORD}}}+	{{
	if(yyleng==1){{
		if(search_print_struct("WORD")){{
			printf("%s",yytext);	
        }} else {{ 
			printf("{{{WORD}}}");
		}}
	}} else {{
		if(search_print_struct("WORD")){{
			printf("%s",yytext);	
		}} else {{	
			printf("{{{WORD}}}{{%d}}",yyleng);
		}}
	}}
}}
    """
    print(code)
