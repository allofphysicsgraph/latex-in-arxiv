echo ok to run 4
find . -type f -exec sha256sum "{}" >> CS_FILES_"$(date +%s)" \;
find . -type f -exec file "{}" >> FILES_"$(date +%s)" \; 
