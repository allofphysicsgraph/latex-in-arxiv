grep_count="$(grep -c $1 $2)"
flex_count="$(./a.out $2)"
if [[ $grep_count != $flex_count ]];
then 
   echo $grep_count,$flex_count,$f
fi
