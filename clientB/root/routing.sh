#!/bin/sh
iptables -A FORWARD -i wg0 -o wlan0 -j ACCEPT
iptables -A FORWARD -i wlan0 -o wg0 -j ACCEPT
iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE
iptables -t nat -A POSTROUTING -o wg0 -j MASQUERADE
return 0
