#!/bin/bash

filename="$1"
filename_xml=$(echo "$1"|sed 's/.tex/.xml/g')
latexml "$1"  > "$filename_xml"
filename_html=$(echo "$1"|sed 's/.tex/.html/g')
latexmlpost --format=html5 "$filename_xml"  > "$filename_html"
