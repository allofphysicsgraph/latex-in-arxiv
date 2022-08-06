/bin/bash build_flex_files.sh
#fractions should be ran on it's own
#a few errors to resolve with fractions, but works pretty well

ls|grep out$|grep -v fraction| xargs -i /bin/bash run_flex_script.sh "{}"
find . -type f -name "*.csv" -empty -exec rm -rf "{}" \; 
