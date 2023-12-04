#!/bin/bash

filename=$(echo /tmp/testing_"$(date +%s)".xml)
latexml -xml "$1" > $filename
grep -oP '<Math mode="inline" tex=".*?"' "$filename"|sed 's/<Math mode="inline" tex="//g'|sed -r 's/"\s*//g'
