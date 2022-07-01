#!/bin/bash

while read -r f;
	do
		./newcommand <"$f">"$f"_newcmd.tex;
	done <<<"$(find 2003 -type f |grep -v tex$)"
