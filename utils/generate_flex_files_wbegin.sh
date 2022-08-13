while read f;
	do 
		echo cp center.l "$f".l; 
		upper=$(echo $f|tr  'a-z' 'A-Z');
		echo sed -i \'s/CENTER/$upper/g\' "$f".l;
		echo sed -i \'s/center/$f/g\' "$f".l ;
	done < <(cat BEGINS.sh)

