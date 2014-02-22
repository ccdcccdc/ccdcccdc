#!/bin/bash

iptables=$(whereis iptables | cut -d' ' -f2)
tcpin=''
tcpout=''
udpin=''
udpout=''
cat << EOF > firewall
 $iptables -P INPUT DROP
 $iptables -P OUTPUT DROP
 $iptables -P FORWARD DROP
 $iptables -N LOGGING
 $iptables -A INPUT -i lo -j ACCEPT
 $iptables -A INPUT -s 127.0.0.0/8 -j LOGGING
 $iptables -A OUTPUT -d 10.0.0.0/8 -m state --state NEW -j LOGGING
EOF


for dir in INPUT OUTPUT; do
  echo "$iptables -A $dir -p icmp -m icmp --icmp-type 0 -j ACCEPT" >> firewall
  echo "$iptables -A $dir -p icmp -m icmp --icmp-type 8 -j ACCEPT" >> firewall
done

for port in $tcpin; do
  echo "$iptables -A INPUT -p tcp --dport $port -m state --state NEW,ESTABLISHED -j ACCEPT
$iptables -A OUTPUT -p tcp --sport $port -m state --state ESTABLISHED -j ACCEPT" >> firewall
done

for port in $tcpout; do
  echo "$iptables -A INPUT -p tcp --dport $port -m state --state ESTABLISHED -j ACCEPT
$iptables -A OUTPUT -p tcp --sport $port -m state --state NEW,ESTABLISHED -j ACCEPT" >> firewall
done

for port in $udpin; do
  echo "$iptables -A INPUT -p tcp --dport $port -m state --state NEW,ESTABLISHED -j ACCEPT
$iptables -A OUTPUT -p tcp --sport $port -m state --state ESTABLISHED -j ACCEPT" >> firewall
done

for port in $udpout; do
  echo "$iptables -A INPUT -p tcp --dport $port -m state --state ESTABLISHED -j ACCEPT
$iptables -A OUTPUT -p tcp --sport $port -m state --state NEW,ESTABLISHED -j ACCEPT" >> firewall
done

echo "$iptables -A LOGGING -j LOG --log-level 5 --log-prefix \"Packet Dropped:\"
$iptables -A LOGGING -j DROP" >> firewall
