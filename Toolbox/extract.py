#!/bin/python3

import sys
import re

file = open(sys.argv[1], "r")

if file.mode== 'r':
    contents =file.read()

ips = re.findall("(?:[0-9]{1,3}\.){3}[0-9]{1,3}", str(contents))

print("\033[0;32;40m \nlisting IP addresses\n")

print(ips)

url1 = re.findall("(https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]+\.[^\s]{2,}|www\.[a-zA-Z0-9]+\.[^\s]{2,})", str(contents))

print("\033[0;36;40m \nlisting URLs\n")

print(url1)

url2 = re.findall("(ftp|http|https|):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?", str(contents))

print(url2)

url3 = re.findall("(?:[a-z0-9](?:[a-z0-9-]{0,61}[a-z0-9])?\.)+[a-z0-9][a-z0-9-]{0,61}[a-z0-9]", str(contents))

print(url3)

dir1 = re.findall("(.*/)", str(contents))

print("\033[0;35;40m \nlisting directories\n")

print(dir1)

dir2 = re.findall("(.*/).", str(contents))

print(dir2)


par1 = re.findall("\?.*\=.", str(contents))

print("\033[0;34;40m \nlisting parameters\n")

print(par1)


print("\033[0;31;40m \nlisting ports\n")

ports1 = re.findall(':[0-9]{0,6}', str(contents))

print(ports1)
