#!/bin/bash


if [[ $# -lt 1 ]]; then
	echo "Usage recond.sh <target> <option>"
	echo "options:"
	echo "vuln       Run vulnerability scan using the NSE vuln script"
	echo "udp        Run a UDP port scan"
	echo ""
	exit 2
fi

if [[ $1 != ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
	echo "First argument must be an IP address"
	exit 2
fi


if [[ $@ == vuln ]]; then

	/usr/bin/echo -e "[+] Running vulnscan, vulners, and vuln NSE scripts for $1 \n\n\n"
	/usr/bin/nmap -Pn --script nmap-vulners,vulnscan -sV $1
	/usr/bin/nmap -Pn --script vuln -sV $1
fi

if [[ $@ == udp ]]; then

	/usr/bin/echo -e "[+] Scanning for top 1000 UDP ports for $1 \n\n\n"
	/usr/bin/nmap -Pn -sU  -sV $1 -oN "UDPports.txt"

fi


/usr/bin/echo -e "[+] All scan for all TCP ports for $1 \n\n\n"
/usr/bin/nmap -Pn -p - -T4 -A $1 -oN "TCPports.txt"
