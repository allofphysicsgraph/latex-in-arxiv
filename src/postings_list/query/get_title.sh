grep "$1" title_offsets |awk '{print $2}'|xargs -i grep "{}" title_tf_idf |grep -oE 'tok:.*'|cut -d ':' -f2-
