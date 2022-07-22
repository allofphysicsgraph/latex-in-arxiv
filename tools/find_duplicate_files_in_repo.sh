find ../ -type f -exec sha256sum "{}" \; > /dev/shm/chksm_files ;
grep -f <( cat /dev/shm/chksm_files| cut -d ' ' -f1 |sort|uniq -c |sort -n|awk '$1 > 1'|awk '{print $2}') <(cat /dev/shm/chksm_files)
