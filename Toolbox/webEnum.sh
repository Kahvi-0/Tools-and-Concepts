#!/bin/bash

if [[ $# != 2 ]]; then
	echo "Usage web.sh <http://target> <port>"
	exit 2
fi


/usr/bin/echo "what is the project name?"

read project

echo -e "\n\n[+] preparing project directories and files\n\n"

/usr/bin/mkdir $project
/usr/bin/mkdir $project/directories
/usr/bin/mkdir $project/vulnScan
git -C $project/directories/ clone  https://github.com/maaaaz/webscreenshot.git

echo -e "\n\n[+] gobusting directories\n\n"


/usr/bin/gobuster -q dir -u $1:$2 -w /usr/share/wordlists/dirb/common.txt > $project/directories/dirs.txt

/usr/bin/gobuster -q dir -u $1:$2 -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt >> $project/directories/dirs.txt

#/usr/bin/gobuster -q dir -u $1:$2 -w /usr/share/wordlists/dirb/common.txt > $project/directories/dirs.txt || echo -e "\nError with gobuster\n" && exit 2

#/usr/bin/gobuster -q dir -u $1:$2 -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt >> $project/directories/dirs.txt || echo "\nError with gobuster\n" && exit 2


echo -e "\n\n[+] sorting results\n\n"


sort -u $project/directories/dirs.txt > $project/directories/dir2.txt 

cat $project/directories/dir2.txt | grep -v ^"\[" | grep -v ^\= | grep -v ^"by" | grep -v ^"20" > $project/directories/FinalList.txt
cat $project/directories/FinalList.txt | grep "Status: 1" | rev | cut -c14-  | rev > $project/directories/100status.txt
cat $project/directories/FinalList.txt | grep "Status: 2" | rev | cut -c14-  | rev > $project/directories/200status.txt
cat $project/directories/FinalList.txt | grep "Status: 3" | rev | cut -c14-  | rev > $project/directories/300status.txt
cat $project/directories/FinalList.txt | grep "Status: 4" | rev | cut -c14-  | rev > $project/directories/400status.txt
cat $project/directories/FinalList.txt | grep "Status: 5" | rev | cut -c14-  | rev > $project/directories/500status.txt

sed -i -e 's|^|'$1'|' *status.txt



echo -e "\n\n[+] grabbing all the screenshots\n\n"


python3 $project/directories/webscreenshot/webscreenshot.py -i $project/directories/100status.txt -o $project/directories/screenshots/100
python3 $project/directories/webscreenshot/webscreenshot.py -i $project/directories/200status.txt -o $project/directories/screenshots/200
python3 $project/directories/webscreenshot/webscreenshot.py -i $project/directories/300status.txt -o $project/directories/screenshots/300
python3 $project/directories/webscreenshot/webscreenshot.py -i $project/directories/400status.txt -o $project/directories/screenshots/400
python3 $project/directories/webscreenshot/webscreenshot.py -i $project/directories/500status.txt -o $project/directories/screenshots/500




echo -e "\n\n[+] Running some vulnerability scanners\n\n"

nikto -h $1 > $project/vulnScan/nikto.txt || echo "\nError with nikto\n" && exit 2


echo -e "\n\n[+] Cleaning up\n\n"


rm $project/directories/dirs.txt
rm $project/directories/dir2.txt
