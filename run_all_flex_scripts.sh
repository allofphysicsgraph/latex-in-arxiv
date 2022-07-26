/bin/bash build_flex_files.sh
ls|grep out$|xargs -i /bin/bash run_flex_script.sh "{}" 
