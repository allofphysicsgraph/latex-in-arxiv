src_dir=/home/user/ARXIV_FILES
ls $src_dir |grep tar$|head -n 50|xargs -i rsync -axr $src_dir/"{}"  . --progress --remove-source-files
