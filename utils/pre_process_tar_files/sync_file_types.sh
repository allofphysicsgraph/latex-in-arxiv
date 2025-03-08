find ARXIV_FILE_TYPES* -type d -mindepth 1 -maxdepth 1 -name "*_arxiv" -exec rsync -axr "{}" /home/user/FILE_TYPES_ARXIV/ --remove-source-files --progress \;
rm -rf ARXIV_FILE_TYPES*
