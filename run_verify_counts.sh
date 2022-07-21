control_sequence="\\abstract"
grep "$control_sequence" -irl 2003|xargs -i bash verify_counts.sh "$control_sequence" "{}" |grep -v ok

#example output on mismatch for \\cite
#0,1,2003/0301062.tex
#94,99,2003/0301080.tex
#9,60,2003/0302147.tex
#23,25,2003/0303116.tex
#0,1,2003/0304269.tex


