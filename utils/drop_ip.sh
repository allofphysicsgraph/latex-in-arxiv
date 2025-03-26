#https://unix.stackexchange.com/questions/158564/how-to-use-defined-function-with-xargs

get_ip_list() {
grep -v search /var/log/nginx/access.log|grep -vP '/ '|cut -d ' ' -f1|sort|uniq -c |sort -n |awk '{print $2}'

}
drop_ip() {
echo sudo iptables -A INPUT -s "$1" -j DROP
echo sudo iptables -A OUTPUT -d "$1" -j DROP
}
#sudo grep -v search /var/log/nginx/access.log
export -f drop_ip
echo 192.168.5.{55..66} |xargs -d' '  -n1  bash -c 'drop_ip "$@"' _ 
