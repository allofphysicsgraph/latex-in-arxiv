#!/bin/bash

while read -r f;
	do
		./newcommand <"$f">"$f".tex;
	done <<<"$(find 2003 -type f |grep -v tex$)"

