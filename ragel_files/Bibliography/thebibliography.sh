grep "begin{thebibliography}|end{thebibliography}" -P "$1" -n|cut -d ':' -f1|tr '\n' ','|sed -r 's/,$//g'|xargs -i echo sed -n "{}"p "$1"

