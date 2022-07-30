function compare_counts { 
flex_file_name=$(echo "$1".out)
python_count="$(./verify_counts.py "$1" "$2")"
flex_count="$(./$flex_file_name $2|awk 'length($0) > 0 '|grep "$1" | wc -l)"
control_sequence="$(echo $2|tr -d '\\')"
if [[ $python_count != $flex_count ]];
then 
   echo  $python_count,$flex_count,$2,$control_sequence
else
	echo "    count matches"
fi
 }

#compare_counts $1 $2

while read f;
do 
	if [[ -f "$f".out ]];
	then
		echo "$f"
		compare_counts $f $2
	else
		echo "$f:missing"
	fi

done < <( grep -oP '\\[a-z]+{' "$2" |sort|uniq -c |sort -n |awk '{print $2}'|tr -d '{\\'|grep -vPx 'end|omicron|caption|includegraphics|scalebox|mathbf|begin|rho|mu|nu|tilde|beta|alpha|hat|bar')
