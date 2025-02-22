file_types_dir="$(echo $((pwd|rev | cut -d '/' -f2-|rev)|sed 's/PROCESSING/FILE_TYPES/g'))"
echo $file_types_dir
mkdir $file_types_dir/"$1"_"arxiv"
find ../ -type f -name "*.$1" -exec bash a.sh "{}" "$1"_"arxiv" \; 
