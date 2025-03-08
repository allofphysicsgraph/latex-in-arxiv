screen -dmS backup bash sync_backup.sh 
bash sync_file_types.sh
bash sync.sh
ls|grep PROCESSING|xargs -i rm -rf "{}"
#rsync -axr ARXIV_LOGS* /mnt/x/ARXIV_LOGS --progress --remove-source-files
find . -maxdepth 1 -empty  -exec rm -rf "{}"  \;
rm -rf ARXIV_FILE_TYPES_*
#bash mkdirs.sh
