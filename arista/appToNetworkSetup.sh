#!/bin/bash

# br-08..b6 is 10.28.0.1
# add a route to the POD from 10.28.0.1 interface
route add -net 10.233.90.53 netmask 255.255.255.255 dev br-08945aaa4eb6
# any 10.233.x.x coming out of app pod should be masqeraded on 10.28.0.1 bridge
iptables -t nat -A POSTROUTING -o br-08945aaa4eb6 -s 10.233.0.0/16 -j MASQUERADE
# generally masq all traffic on node1 eth0
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

# in Arista
en
config
host auto-tix-arista
int eth1
no shut
ip noswitchport
ip address 172.28.0.10/16
ip routing
ip proxy-arp
exit
int eth2
no shut
ip noswitchport
ip address 172.29.0.10/16
ip routing
ip proxy-arp

ip route 0.0.0.0/0 172.29.0.1
