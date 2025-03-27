processing_dir=$(pwd)
get_20(){
    src_dir=/home/user/ARXIV_FILES
    ls $src_dir |grep tar$|head -n 2|xargs -i rsync -axr $src_dir/"{}"  . --progress --remove-source-files
}


backup_originals(){
    sha256sum *.tar  > arXiv_tar_files_"$(date +%s)".sha256
    backup_dir=/home/user/ARXIV_BACKUP
    mkdir $backup_dir
    rsync -axr *.tar $backup_dir --progress
    echo ok to run 1.sh while compressing backup
    cd $backup_dir
    ls|grep tar$|xargs -i -P20 xz -e "{}" 
    cd $processing_dir
}

decompress(){
    current_dir=$(pwd)
    echo $current_dir
    echo wait until complete 
    ls|grep arX|grep -i tar$|xargs -i tar -xf "{}" 
    while read f;do cd $f;cp  $current_dir/2.sh . ;   bash 2.sh;cd ../;done < <(find . -maxdepth 1 -type d |grep '^\.\/\d{4}' -P)
    rm *.tar
}

checksum_files(){
echo ok to run 4
find . -type f -exec sha256sum "{}" >> CS_FILES_"$(date +%s)" \;
find . -type f -exec file "{}" >> FILES_"$(date +%s)" \;
}

CLOC(){
echo ok to run 5
cloc .  > CLOC_"$(date +%s)"
}

file_similarity(){
echo ok to run 6
ssdeep  -rcd  . -t 20 > file_similarity_scores_"$(date +%s)"
}

common_file_extensions(){
find $(find . -maxdepth 1 -type d |grep '/' |grep -v move|grep -v pre_proce|grep '[0-9]{4}' -E)  -type f |rev |cut -d '.' -f1|rev |sort|uniq -c |sort -n |awk '$1>10{print $2}'|grep -v sh$ > move_to_filetypes/common_file_extensions
}

copy_logs(){
log_dir=$(pwd|sed 's/PROCESSING/LOGS/g')
echo $log_dir
log_files=$(ls|grep -E "CLOC_|CS_FI|FILES_|tar_files_|_scores_")
rsync -axr  $log_files $log_dir --progress
}

group_by_filetype(){
cd move_to_filetypes/
cat ~/common_file_extensions |xargs -i -P10 bash t2.sh "{}" arviv
}
get_20
backup_originals
decompress
checksum_files
CLOC
file_similarity
cp ../common_file_extensions ~/
common_file_extensions
copy_logs
group_by_filetype
