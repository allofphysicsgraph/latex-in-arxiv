SHELL=/bin/bash
line_start="$(grep -n 'return conn, cursor$' ragel_simple.py|cut -d ':' -f1)"
sed -in  "$(($line_start+1))","$(wc -l ragel_simple.py|cut -d ' ' -f1)"d ragel_simple.py
cat simple_fields|xargs -i sed "s/cite/{}/g" simple_template >> ragel_simple.py
