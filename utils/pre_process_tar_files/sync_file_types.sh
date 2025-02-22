 find . -type d -mindepth 2 -maxdepth 2 -name "*_arxiv" -exec rsync -axr "{}" /mnt/x/FILE_TYPES_ARXIV/ --progress \;
