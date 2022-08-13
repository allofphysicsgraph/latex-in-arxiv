#!/bin/bash
if [ ! -d 2003 ];
then
	make sampledata;
fi
	ls 

while read -r f;
	do
		./newcommand <"$f">"$f".tex;
	done <<<"$(find 2003 -type f |grep -v tex$)"

