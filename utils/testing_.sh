#doing a test case for tokenizing the math from TeX documents in bulk.
src_path=""
test_path=""
dst_path=""

while read f;
	do rsync -axr $f "$test_path"/ ; cd "$test_path" ; tar -xf $(echo $f|rev|cut -d '/' -f1|rev);ls ; cd ..
	while read g;
	do cs="$(sha256sum  $g)"
	src="$(echo $cs|cut -d ' ' -f2)"; 
	dst=$(echo  $cs|cut -d ' ' -f1);
	#echo $src 
	rsync -axr $src "$dst_path"/"$dst".tex --progress --remove-source-files;
	done < <(find "$test_path"/ -type f -name "*.tex"|grep -v ' '|grep -v '"' |grep -v "'")
	done < <(find "$src_path"/  -type f -exec file "{}" \; |grep tar |cut -d ':' -f1)


