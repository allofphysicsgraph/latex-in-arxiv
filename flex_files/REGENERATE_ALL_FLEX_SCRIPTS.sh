if [[ -d flex_scripts_backup ]];
	then 
		mkdir flex_scripts_backup 
fi
find . -maxdepth 1 -name "*.l" -exec rsync -axr  "{}" flex_scripts_backup/ \; 

arr=(address affiliation author cite date footnote keywords label pacs ref section setcounter sqrt thanks title usepackage)


for ((i=0;i<${#arr[*]};i++))
do 
	/bin/bash generate_flex_script.sh ${arr[$i]}
done
