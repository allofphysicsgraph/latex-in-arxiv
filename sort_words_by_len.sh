cat "$1"|sort|uniq |awk '{print length($0),$1}'|sort -nr|cut -d ' ' -f2 > /tmp/"$1";
cat /tmp/"$1" > "$1";
