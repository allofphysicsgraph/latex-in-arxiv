SERVER_IP=''
find ARXIV_PROCESSING* -type d -maxdepth 1|cut -d '/' -f1|sort|uniq|xargs -i -P10 rsync -e 'ssh -p 1022' -axr "{}" root@$SERVER_IP:/mnt/FILE_STORAGE/ARXIV_PROCESSING/ --progress  --remove-source-files
find ARXIV_LOGS* -type d -maxdepth 1|cut -d '/' -f1|sort|uniq|xargs -i -P10  rsync -e 'ssh -p 1022' -axr "{}" root@$SERVER_IP:/mnt/FILE_STORAGE/ARXIV_LOGS/ --progress  --remove-source-files
find ARXIV_FILE_TYPES* -type d -maxdepth 1|cut -d '/' -f1|sort|uniq|xargs -i -P10  rsync -e 'ssh -p 1022' -axr "{}" root@$SERVER_IP:/mnt/FILE_STORAGE/FILE_TYPES_ARXIV/  --progress --remove-source-files 
