#!/bin/bash

/usr/bin/echo -e "[+] Scanning for TCP ports\n\n\n"

/usr/bin/nmap -p - -T4 -A $1 -oN "TCPports.txt"

/usr/bin/echo -e "[+] Scanning for UDP ports\n\n\n"

/usr/bin/nmap -sU -p -sV $1 -oN "UDPports.txt"
