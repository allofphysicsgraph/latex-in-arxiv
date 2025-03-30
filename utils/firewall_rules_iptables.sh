# Modify this file accordingly for your specific requirement.
# http://www.thegeekstuff.com
# 1. Delete all existing rules
iptables -F
sysctl -w net.ipv6.conf.all.disable_ipv6=1
sysctl -w net.ipv6.conf.disable_ipv6=1
sysctl -w net.ipv6.conf.default.disable_ipv6=1
sysctl -w net.ipv6.conf.lo.disable_ipv6=1
sysctl -p
ip6tables -P INPUT DROP
ip6tables -P OUTPUT DROP
ip6tables -P FORWARD DROP

# 2. Set default chain policies
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT DROP

# 3. Block a specific ip-address
#BLOCK_THIS_IP="x.x.x.x"
#iptables -A INPUT -s "$BLOCK_THIS_IP" -j DROP


# 5. Allow incoming SSH only from a specific network
#iptables -A INPUT -i ens1f0 -p tcp -s 192.168.200.0/24 --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
#iptables -A OUTPUT -o ens1f0 -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT


# Allow incoming HTTPS
#iptables -A INPUT -i ens1f0 -p tcp --dport 443 -m state --state NEW,ESTABLISHED -j ACCEPT
#iptables -A OUTPUT -o ens1f0 -p tcp --sport 443 -m state --state ESTABLISHED -j ACCEPT

# 7. MultiPorts (Allow incoming SSH, HTTP)
iptables -A INPUT -i ens1f0 -p tcp -m multiport --dports 1022,80 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -o ens1f0 -p tcp -m multiport --sports 1022,80 -m state --state ESTABLISHED -j ACCEPT

# 8. Allow outgoing SSH 
iptables -A OUTPUT -o ens1f0 -p tcp --dport 1022 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -i ens1f0 -p tcp --sport 1022 -m state --state ESTABLISHED -j ACCEPT

# 9. Allow outgoing SSH only to a specific network
#iptables -A OUTPUT -o ens1f0 -p tcp -d 192.168.101.0/24 --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
#iptables -A INPUT -i ens1f0 -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT

# 10. Allow outgoing HTTPS
iptables -A OUTPUT -o ens1f0 -p tcp --dport 80 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -i ens1f0 -p tcp --sport 80 -m state --state ESTABLISHED -j ACCEPT

iptables -A OUTPUT -o ens1f0 -p tcp --dport 443 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -i ens1f0 -p tcp --sport 443 -m state --state ESTABLISHED -j ACCEPT
# 11. Load balance incoming HTTPS traffic
#iptables -A PREROUTING -i ens1f0 -p tcp --dport 443 -m state --state NEW -m nth --counter 0 --every 3 --packet 0 -j DNAT --to-destination 192.168.1.101:443
#iptables -A PREROUTING -i ens1f0 -p tcp --dport 443 -m state --state NEW -m nth --counter 0 --every 3 --packet 1 -j DNAT --to-destination 192.168.1.102:443
#iptables -A PREROUTING -i ens1f0 -p tcp --dport 443 -m state --state NEW -m nth --counter 0 --every 3 --packet 2 -j DNAT --to-destination 192.168.1.103:443

# 12. Ping from inside to outside
iptables -A OUTPUT -p icmp --icmp-type echo-request -j ACCEPT
iptables -A INPUT -p icmp --icmp-type echo-reply -j ACCEPT

# 13. Ping from outside to inside
#iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT
#iptables -A OUTPUT -p icmp --icmp-type echo-reply -j ACCEPT

# 14. Allow loopback access
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# 15. Allow packets from internal network to reach external network.
# if eth1 is connected to external network (internet)
# if ens1f0 is connected to internal network (192.168.1.x)
#iptables -A FORWARD -i ens1f0 -o eth1 -j ACCEPT

# 16. Allow outbound DNS
iptables -A OUTPUT -p udp -o ens1f0 --dport 53 -j ACCEPT
iptables -A INPUT -p udp -i ens1f0 --sport 53 -j ACCEPT

# 23. Prevent DoS attack
iptables -A INPUT -p tcp --dport 80 -m limit --limit 25/minute --limit-burst 100 -j ACCEPT

# 24. Port forwarding 422 to 22
#iptables -t nat -A PREROUTING -p tcp -d 192.168.102.37 --dport 422 -j DNAT --to 192.168.102.37:22
#iptables -A INPUT -i ens1f0 -p tcp --dport 422 -m state --state NEW,ESTABLISHED -j ACCEPT
#iptables -A OUTPUT -o ens1f0 -p tcp --sport 422 -m state --state ESTABLISHED -j ACCEPT

# 25. Log dropped packets
iptables -N LOGGING
iptables -A INPUT -j LOGGING
iptables -A LOGGING -m limit --limit 2/min -j LOG --log-prefix "IPTables Packet Dropped: " --log-level 7
iptables -A LOGGING -j DROP
