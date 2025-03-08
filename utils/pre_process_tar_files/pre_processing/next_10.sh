src_dir=/mnt/y/ARXIV/ 
ls $src_dir |grep tar$|head -n 20|xargs -i rsync -axr $src_dir/"{}"  . --progress --remove-source-files


