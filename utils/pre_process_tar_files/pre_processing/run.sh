get_20(){
    src_dir=/home/user/ARXIV_FILES
    ls $src_dir |grep tar$|head -n 20|xargs -i rsync -axr $src_dir/"{}"  . --progress --remove-source-files
}


backup_originals(){
    sha256sum *.tar  > arXiv_tar_files_"$(date +%s)".sha256
    backup_dir=/home/user/ARXIV_BACKUP
    mkdir $backup_dir
    rsync -axr *.tar $backup_dir --progress
    echo ok to run 1.sh while compressing backup
    cd $backup_dir
    ls|grep tar$|xargs -i -P20 xz -e "{}" 
}

decompress(){
    current_dir=$(pwd)
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
#get_20
#backup_originals
#decompress
#checksum_files
#bash 4_CLOC.sh
#bash 5_file_similarity.sh
#bash 6.sh
#bash copy_logs.sh
#bash 7.sh
