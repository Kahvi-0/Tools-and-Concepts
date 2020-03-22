#!/bin/bash

fping -a -g 192.168.1.0/24 2> /dev/null > ping.txt

nmap -p- -T4 -A -vvv -iL ping.txt -o final.txt
