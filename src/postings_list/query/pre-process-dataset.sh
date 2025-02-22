#!/bin/bash

	
while read f ;
	do 
	original=$(sha256sum "$f"|cut -d ' ' -f1);
	cleaned=$(sha256sum "$f"_cleaned|cut -d ' ' -f1);
	if [[ $original == $cleaned ]] ; 
		then 
			rm "$f"_cleaned ;
	else 
            mv "$f"	./2003_errors/
    fi ;
done < <(find . -type f|grep -E './[a-f0-9]+.tex'|grep -v clean)

