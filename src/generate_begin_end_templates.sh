SHELL=/bin/bash
line_start="$(grep -n 'return conn, cursor$' ragel_begin_end.py|cut -d ':' -f1)" && sed -in  "$(($line_start+1))","$(wc -l ragel_begin_end.py|cut -d ' ' -f1)"d ragel_begin_end.py
cat fields|xargs -i sed "s/subequations/{}/g" begin_end_template >> ragel_begin_end.py
