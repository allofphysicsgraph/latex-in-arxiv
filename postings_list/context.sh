#!/usr/bin/env bash

set -eux pipefail

filepath="$1"
context=250
while read f;
do 
  offset=$(echo $f|cut -d ',' -f2)
  ./a.out "$filepath" "$offset" $context |grep -C 5 --color "$2" 
    sleep 3 
  echo $offset
done < <(./strings.out "$filepath"|grep "$2")
