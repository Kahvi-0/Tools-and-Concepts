#!/bin/python3

import sys
import re

file = open(sys.argv[1], "r")

if file.mode== 'r':
    contents =file.readlines()

#template
#for i in contents:
#    reg = re.compile("(.*?)\?")
#    resource = reg.search(i)
#    if resource:
#       print((resource.group(1)))
 
# Grabbing IP addresses

print("\033[0;32;40m \nlisting IP addresses\n")
for i in contents: 
    ips = re.compile("((?:[0-9]{1,3}\.){3}[0-9]{1,3}(\/[0-9]{0,2}){0,2})")
    resource = ips.search(i)
    if resource:
       print((resource.group()))




print("\033[0;36;40m \nlisting URLs\n")


for i in contents: 
    url1 = re.compile("(https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]+\.[^\s]{2,}|www\.[a-zA-Z0-9]+\.[^\s]{2,})")
    resource = url1.search(i)
    if resource:
       print((resource.group()))



for i in contents: 
    url2 = re.compile("(ftp|http|https|):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?")
    resource = url2.search(i)
    if resource:
       print((resource.group()))
    
for i in contents: 
    url3 = re.compile("(?:[a-z0-9](?:[a-z0-9-]{0,61}[a-z0-9])?\.)+[a-z0-9][a-z0-9-]{0,61}[a-z0-9]")
    resource = url3.search(i)
    if resource:
       print((resource.group()))



print("\033[0;35;40m \nlisting directories\n")
for i in contents: 
    dir1 = re.compile("(.*/)")
    resource = dir1.search(i)
    if resource:
       print((resource.group()))

for i in contents: 
    dir2 = re.compile("(.*/).")
    resource = dir2.search(i)
    if resource:
       print((resource.group()))

print("\033[0;34;40m \nlisting parameters\n")
for i in contents: 
    par1 = re.compile("\?.*\=.")
    resource = par1.search(i)
    if resource:
       print((resource.group()))


print("\033[0;31;40m \nlisting ports\n")

for i in contents: 
    ports1 = re.compile(':[0-9]{1,5}')
    resource = ports1.search(i)
    if resource:
       print((resource.group()))
       
print("\033[0;31;40m \nlisting email addresses\n")

for i in contents: 
    email = re.compile('.{0,8}\@.+\.(.{1,5})')
    resource = email.search(i)
    if resource:
       print((resource.group()))
