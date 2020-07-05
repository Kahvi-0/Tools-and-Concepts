#!/bin/bash


if [[ $# -lt 1 ]]; then
	echo "Usage recond.sh <target> <option>"
	echo ""
	echo "Target can be IP or subent"
	echo "Example: 10.10.10.0/24"
	echo -e "\n"
	echo "Flags:"
	echo "vuln       Run vulnerability scan using the NSE vuln script"
	echo "udp        Run a UDP port scan"
	echo ""
	exit 2
fi

if [[ $1 =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]|\/[0-9]{1,2}+$ ]]; then
	echo "Starting"
else
	echo "First argument must be an IP address"
	exit 2

fi


if [[ $2 == vuln ]]; then

	/usr/bin/echo -e "[+] Running vulscan, vulners, and vuln NSE scripts for $1 \n\n\n"
	/usr/bin/nmap -Pn --script nmap-vulners,vulscan/vulscan.nse -sV $1 -oN "vuln1.txt"
	/usr/bin/nmap -Pn --script vuln -sV $1 -oN "vuln2.txt"
fi

if [[ $2 == udp ]]; then

	/usr/bin/echo -e "[+] Scanning for top 1000 UDP ports for $1 \n\n\n"
	/usr/bin/nmap -Pn -sU  -sV $1 -oN "UDPports.txt"

fi


/usr/bin/echo -e "[+] All scan for all TCP ports for $1 \n\n\n"
/usr/bin/nmap -Pn -p - -T4 -A $1 -oN "TCPports.txt"
