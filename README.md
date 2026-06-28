# wg-multilan

An idea to attach multiple external LANs into your main one!


## Architecture

[TODO:Diagram]

## What is needed

### Server
- Any Linux-based machine
- **Public IP**: The above machine must be exposed to Internet
- **UDP Port**: 51820 is the default port for the Wireguard protocol

### ClientA and ClientB
- Again, any Linux-based machine
- **Internet access**: that's obvious, though you don't have to expose anything to Internet, even static IP is not mandatory here

## Setup

_All IPs and keys in this guide are just example values!_

### Main server

- Public IP: `30.35.40.45`
- Exposed ports: `51820/udp`
- Interface: `eth0` (Wired)
- LAN1 IP: `192.168.1.100` [Static]
- Wireguard IP: `10.0.0.1` [Static]

_Server hosting a Wireguard VPN exposed to the Internet, aka master_

### ClientA

- Public IP: _unknown_
- Exposed ports: _none_
- Interface: `wlan0` (Wireless)
- LAN2 IP: `192.168.2.219` [DHCP]
- Wireguard IP: `10.0.0.2` [Static]

_First client connected to Wireguard VPN main server above, aka slave_

### ClientB

- Public IP: _unknown_
- Exposed ports: _none_
- Interface: `eno1` (Wired)
- LAN3 IP: `192.168.3.71` [DHCP]
- Wireguard IP: `10.0.0.3` [Static]

_Second client connected to Wireguard VPN main server above, aka slave_

### Router config

- Exposed ports: target `51820` to `192.168.1.100:51820` (or use DMZ)
- LAN1 IP: `192.168.1.1` [Static]
- Wireguard IP: _does not participate_

#### Routing table

| Name | Target         | Gateway       |
|------|----------------|---------------|
| wg   | 10.0.0.0/24    | 192.168.1.100 |
| LAN2 | 192.168.2.0/24 | 192.168.1.100 |
| LAN3 | 192.168.3.0/24 | 192.168.1.100 |

And, all devices from LAN1 have access to Wireguard, LAN2 and LAN3! Awesome!

_Reminder: Router is in the same network as Main server, and our main LAN1 network_
