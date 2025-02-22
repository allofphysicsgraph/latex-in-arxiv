#ls|grep PROCESSING|xargs -i rm -rf "{}"
#find . -type d -mindepth 2 -maxdepth 2 -name "*_arxiv" -exec rsync -axr "{}" /mnt/x/FILE_TYPES_ARXIV/ --progress \;
#rsync -axr ARXIV_LOGS* /mnt/x/ARXIV_LOGS --progress --remove-source-files
#find . -maxdepth 1 -empty  -exec rm -rf "{}"  \;
