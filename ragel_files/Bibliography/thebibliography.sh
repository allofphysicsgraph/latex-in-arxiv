#for i in `seq 1 10 10000`;do sed -n $i','$(($i+10))p names|tr '\n' '|' ;echo "=> \{ printf\("token: %s\n", std::string\(ts, te\).c_str\(\)\); \};;";echo ;echo ;done
grep "begin{thebibliography}|end{thebibliography}" -P "$1" -n|cut -d ':' -f1|tr '\n' ','|sed -r 's/,$//g'|xargs -i echo sed -n "{}"p "$1"

