sha256sum *.tar  > arXiv_tar_files_"$(date +%s)".sha256
backup_dir=/home/user/ARXIV_BACKUP
mkdir $backup_dir
rsync -axr *.tar $backup_dir --progress
echo ok to run 1.sh while compressing backup
cd $backup_dir
ls|grep tar$|xargs -i -P20 xz -e "{}" 
