python_count="$(./verify_counts.py "$1" "$2")"
flex_count="$(./a.out $2)"
control_sequence="$(echo $1|tr -d '\\')"
if [[ $python_count != $flex_count ]];
then 
   echo $python_count,$flex_count,$2,$control_sequence
else
	echo ok
fi

