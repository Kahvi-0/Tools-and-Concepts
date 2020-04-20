#!/bin/bash


/usr/bin/echo -e "[+] All scan for all TCP ports\n\n\n"


/usr/bin/nmap -p - -T4 -A $1 -oN "TCPports.txt"

/usr/bin/echo -e "[+] Scanning for top 1000 UDP ports\n\n\n"

/usr/bin/nmap -sU  -sV $1 -oN "UDPports.txt"