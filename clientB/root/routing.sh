#!/bin/sh

# FORWARD Rulez
if ! iptables -C FORWARD -i wg0 -o eno1 -j ACCEPT 2>/dev/null; then
	iptables -A FORWARD -i wg0 -o eno1 -j ACCEPT
fi
if ! iptables -C FORWARD -i eno1 -o wg0 -j ACCEPT 2>/dev/null; then
    iptables -A FORWARD -i eno1 -o wg0 -j ACCEPT
fi

# NAT MASQUERADE Rulez
if ! iptables -t nat -C POSTROUTING -o eno1 -j MASQUERADE 2>/dev/null; then
    iptables -t nat -A POSTROUTING -o eno1 -j MASQUERADE
fi
if ! iptables -t nat -C POSTROUTING -o wg0 -j MASQUERADE 2>/dev/null; then
    iptables -t nat -A POSTROUTING -o wg0 -j MASQUERADE
fi

exit 0
