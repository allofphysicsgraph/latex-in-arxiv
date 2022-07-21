python_count="$(./verify_counts.py "$1" "$2")"
flex_count="$(./a.out $2)"
if [[ $python_count != $flex_count ]];
then 
   echo $python_count,$flex_count,$2
else
	echo ok
fi

