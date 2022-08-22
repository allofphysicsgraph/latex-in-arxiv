%{
int balanced;
int count;
char filename[256];
char results_filename[256];
int print_count;

%}

%x BIBLIOGRAPHY
%%

"\\bibliography"([ ]{0,4}|\n)"{" {
	yymore();
	balanced--;
	BEGIN(BIBLIOGRAPHY);
}

<BIBLIOGRAPHY>"{" { yymore(); balanced--;}
<BIBLIOGRAPHY>"}" { balanced++; if(balanced==0){
		if(print_count==0){
			fprintf(yyout,"%s<T_SPLIT>%s\n",yytext,filename);
		}
		count++;
		BEGIN(0);
	} else { 
		yymore();
	}
}
<BIBLIOGRAPHY>. { yymore(); }
<BIBLIOGRAPHY>\n { yymore(); }

.	;
\n	;
%%

