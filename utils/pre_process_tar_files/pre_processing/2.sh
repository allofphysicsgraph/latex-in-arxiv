#!/bin/bash
 while read f; 
 do dir_name=$(echo $f|sed 's/.gz//g');
	 mkdir $dir_name; 
	 mv $f $dir_name/ ;
 	cd $dir_name;
	gunzip *.gz;
	sync;
	file *|grep POSIX|cut -d ':' -f1|xargs -i tar -xf "{}"
	cd .. 
 done < <(ls|grep gz$)
