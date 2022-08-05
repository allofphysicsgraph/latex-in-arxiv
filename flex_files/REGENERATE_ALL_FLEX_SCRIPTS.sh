if [[ -d flex_scripts_backup ]];
	then 
		mkdir flex_scripts_backup 
fi
find . -maxdepth 1 -name "*.l" -exec rsync -axr  "{}" flex_scripts_backup/ \; 

arr=(address affiliation author bibitem bibliography cite date footnote keywords label pacs ref section setcounter sqrt thanks title usepackage)
# pop ARRAY -- pop the last item on ARRAY and output it

pop() {
  local var=${1:?'Missing array name'}
  local x ;   eval "x=\${#$var[*]}"
  if [[ $x > 0 ]]; then
    local val ; eval "val=\"\${$var[$((--x))]}\""
    unset $var[$x]
  else
    echo 1>&2 "No items in $var" ; exit 1
  fi
  echo "$val"
}


for ((i=0;i<${#arr[*]};i++))
do 
	/bin/bash generate_flex_script.sh ${arr[$i]}
done
