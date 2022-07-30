function compare_counts { 
flex_file_name=$(echo "$1".out)
python_count="$(./verify_counts.py "$1" "$2")"
flex_count="$(./$flex_file_name $2|wc -l)"
control_sequence="$(echo $2|tr -d '\\')"
if [[ $python_count != $flex_count ]];
then 
   echo $python_count,$flex_count,$2,$control_sequence
else
	echo count matches
fi
 }

compare_counts $1 $2
#grep -oP '\\[a-z]+{' sound1.tex |sort|uniq -c |sort -n |awk '{print $2}'|tr -d '{\\'|grep -vPx 'end|omicron|caption|includegraphics|scalebox|mathbf'

