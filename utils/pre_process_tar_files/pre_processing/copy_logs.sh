log_dir=$(pwd|sed 's/PROCESSING/LOGS/g')
echo $log_dir
log_files=$(ls|grep -E "CLOC_|CS_FI|FILES_|tar_files_|_scores_")
rsync -axr  $log_files $log_dir --progress
