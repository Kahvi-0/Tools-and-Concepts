#!/bin/bash

nmap -sn $1 -o out.txt

nmap -p- -T4 -A -iL out.txt -o finalmap.txt
