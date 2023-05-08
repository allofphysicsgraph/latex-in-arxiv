#for i in `seq 1 10 10000`;do sed -n $i','$(($i+10))p names|tr '\n' '|' ;echo "=> \{ printf\("token: %s\n", std::string\(ts, te\).c_str\(\)\); \};;";echo ;echo ;done
#cat publisher_patterns |grep -v "'"|xargs -i echo \'"{}"\' \(any-\'\)\'\)\{1,5\}\'\)\' > publisher_patterns_v3
#cat publisher_patterns_v4|sed 's/\\{/\{/g'|sed 's/\\(/\(/g'|sed 's/%sn,/%sn",/g' |sed 's/(token/("token/g'|sed 's/\\)/\)/g'|sed 's/\\}/\}/g' >> bibliography.rl

grep "begin{thebibliography}|end{thebibliography}" -P "$1" -n|cut -d ':' -f1|tr '\n' ','|sed -r 's/,$//g'|xargs -i echo sed -n "{}"p "$1"


