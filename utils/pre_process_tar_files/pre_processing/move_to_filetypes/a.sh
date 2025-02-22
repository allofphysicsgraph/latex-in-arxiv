file_extention="$(echo $2|cut -d '_' -f1)"
echo $file_extention
file_types_dir="$(echo $((pwd|rev | cut -d '/' -f2-|rev)|sed 's/PROCESSING/FILE_TYPES/g'))"
rsync -axr --progress  "$1" "$file_types_dir"/"$2"/$(sha256sum "$1" |cut -d ' ' -f1)."$file_extention"
