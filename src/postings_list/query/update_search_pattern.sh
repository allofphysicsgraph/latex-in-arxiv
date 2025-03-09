#!/bin/bash

array1=("cite" "ref" "bibitem" "label")
array2=("equation" "abstract" "thebibliograph")

if [ -z "$1" ]; then
  echo "Error: Please provide an argument."
  exit 1
fi

case "$1" in
  "${array1[0]}"|"${array1[1]}"|"${array1[2]}")
    echo "Argument '$1' found in array1. Running command1..."
    # Replace this with the actual command you want to run
    sed -i -r "s/^latex =.*/latex = '\\\\\\\\$1' braces;/g"  ../../common/latex.rl
    ;;
  "${array2[0]}"|"${array2[1]}"|"${array2[2]}")
    echo "Argument '$1' found in array2. Running command2..."
    # Replace this with the actual command you want to run
    sed -i -r "s/^latex =.*/latex = $1 ;/g"  ../../common/latex.rl
    ;;
  *)
    echo "Argument '$1' not found in either array."
    ;;
esac

exit 0

