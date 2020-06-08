#!/bin/bash

usage='''
Usage web.sh <http://target> <port> <bust level>

 Flags:
     Bust level: -1: light
                 -2: heavy
                 -3: really heavy

Tips:
  Routing through Burp:
     Proxy -> Options -> Proxy Listeners -> Add
        Binding: port: 8081  Loopback only
        Request handling: Redirect to host: <target IP> <target port>
'''


if [[ $# != 3 ]]; then
	echo $usage
	exit 2
fi

if [[ $1 != ^http ]]; then
    echo $usage
    exit 2
fi

# Checking if phantomjs is installed
if [[ -x "$(command -v phantomjs)" ]]; then
	echo "phantomjs installed"	
else
	echo "Installing phantomjs"
	sudo apt-get install phantomjs
	echo "Done"

fi


/usr/bin/echo "what is the project name?"

read project

echo -e "\n\n[+] preparing project directories and files\n\n"
/usr/bin/mkdir $project
/usr/bin/mkdir $project/directories
/usr/bin/mkdir $project/vulnScan
/usr/bin/touch $project/overview.html
git -C $project/directories/ clone  https://github.com/maaaaz/webscreenshot.git
pip3 install -r  $project/directories/webscreenshot/requirements.txt

echo -e "\n\n[+] gobusting directories\n\n"

#obtain file extension list and parse it for gobuster
wget https://raw.githubusercontent.com/Kahvi-0/Tools-and-Concepts/master/Toolbox/Web/wordlists/common_extensions.txt
extensions=$(sed -z 's/\n/,/g' common_extensions.txt)

#light busting
if [ $3 == 1 ]; then
echo -e "\n\n[+] common.txt\n\n"
/usr/bin/gobuster -q dir -u $1:$2 -w /usr/share/wordlists/dirb/common.txt -er -x extensions -t 500 > $project/directories/dirs.txt 
fi

#heavy busting
if [ $3 == 2 ]; then
echo -e "\n\n[+] common.txt\n\n"
/usr/bin/gobuster -q dir -u $1:$2 -w /usr/share/wordlists/dirb/common.txt -er -x extensions -t 500 > $project/directories/dirs.txt
echo -e "\n\n[+] directory-list-2.3-medium.txt\n\n"
/usr/bin/gobuster -q dir -u $1:$2 -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -er -x extensions -t 500 >> $project/directories/dirs.txt 
fi

#really heavy busting
if [ $3 == 3 ]; then
echo -e "\n\n[+] directory-list-2.3-medium.txt\n\n"
/usr/bin/gobuster -q dir -u $1:$2 -w /usr/share/wordlists/dirbuster/directory-list-lowercase-2.3-medium.txt -er -x extensions -t 500 > $project/directories/dirs.txt
echo -e "\n\n[+] common.txt\n\n"
/usr/bin/gobuster -q dir -u $1:$2 -w /usr/share/wordlists/dirb/common.txt -er -x extensions -t 500 >> $project/directories/dirs.txt 
echo -e "\n\n[+] directory-list-lowercase-2.3-medium.txt\n\n"
/usr/bin/gobuster -q dir -u $1:$2 -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -er -x extensions -t 500 >> $project/directories/dirs.txt 
fi


echo -e "\n\n[+] Sorting results\n\n"
#sort results by uniq
sort -u $project/directories/dirs.txt > $project/directories/dir2.txt
#remove fat from results
cat $project/directories/dir2.txt | grep -v ^"\[" | grep -v ^\= | grep -v ^"by" | grep -v ^"20" > $project/directories/FinalList.txt
#sort results into seperate files by status
cat $project/directories/FinalList.txt | grep "Status: 1" | rev | cut -c14-  | rev > $project/directories/100status.txt
cat $project/directories/FinalList.txt | grep "Status: 2" | rev | cut -c14-  | rev > $project/directories/200status.txt
cat $project/directories/FinalList.txt | grep "Status: 3" | rev | cut -c14-  | rev > $project/directories/300status.txt
cat $project/directories/FinalList.txt | grep "Status: 4" | rev | cut -c14-  | rev > $project/directories/400status.txt
cat $project/directories/FinalList.txt | grep "Status: 5" | rev | cut -c14-  | rev > $project/directories/500status.txt

#Remove if urls are appended correctly
#sed -i -e 's|^|'$1'|' $project/directories/*status.txt


echo -e "\n\n[+] Grabbing all the screenshots\n\n"
echo -e "\n\n[+] 1xx status\n"
python3 $project/directories/webscreenshot/webscreenshot.py -i $project/directories/100status.txt -o $project/directories/screenshots/100 -p $2
echo -e "\n\n[+] 2xx status\n"
python3 $project/directories/webscreenshot/webscreenshot.py -i $project/directories/200status.txt -o $project/directories/screenshots/200 -p $2
echo -e "\n\n[+] 3xx status\n"
python3 $project/directories/webscreenshot/webscreenshot.py -i $project/directories/300status.txt -o $project/directories/screenshots/300 -p $2
echo -e "\n\n[+] 4xx status\n" 
python3 $project/directories/webscreenshot/webscreenshot.py -i $project/directories/400status.txt -o $project/directories/screenshots/400 -p $2
echo -e "\n\n[+] 5xx status\n"
python3 $project/directories/webscreenshot/webscreenshot.py -i $project/directories/500status.txt -o $project/directories/screenshots/500 -p $2


echo -e "\n\n[+] Adding results to overview page\n\n"
for i in $project/directories/screenshots/100/*.png; do
	echo "<h1>100 Status</h1>" >> $project/overview.html
	basename  $i | sed 's/\.[^.]*$//' >> $project/overview.html
	echo "<br>" >> $project/overview.html
	echo "<img src="../$i">" >> $project/overview.html
	echo "<br>" >> $project/overview.html
done
for i in $project/directories/screenshots/200/*.png; do
	echo "<h1>200 Status</h1>" >> $project/overview.html
	echo  $i >> $project/overview.html
	echo "<br>" >> $project/overview.html
	echo "<img src="../$i">" >> $project/overview.html
	echo "<br>" >> $project/overview.html
done
for i in $project/directories/screenshots/300/*.png; do
	echo "<h1>300 Status</h1>" >> $project/overview.html
	basename  $i | sed 's/\.[^.]*$//' >> $project/overview.html
	echo "<br>" >> $project/overview.html
	echo "<img src="../$i">" >> $project/overview.html
	echo "<br>" >> $project/overview.html
done
for i in $project/directories/screenshots/400/*.png; do
	echo "<h1>400 Status</h1>" >> $project/overview.html
	basename  $i | sed 's/\.[^.]*$//' >> $project/overview.html
	echo "<br>" >> $project/overview.html
	echo "<img src="../$i">" >> $project/overview.html
	echo "<br>" >> $project/overview.html
done
for i in $project/directories/screenshots/500/*.png; do
	echo "<h1>500 Status</h1>" >> $project/overview.html
	basename  $i | sed 's/\.[^.]*$//' >> $project/overview.html
	echo "<br>" >> $project/overview.html
	echo "<img src="../$i">" >> $project/overview.html
	echo "<br>" >> $project/overview.html
done


# Vulnerability scan section
echo -e "\n\n[+] Running some vulnerability scanners\n\n"
nikto -h $1 > $project/vulnScan/nikto.txt || echo "\nError with nikto\n" 

cat $project/vulnScan/nikto.txt >> $project/overview.html


#clean up section
echo -e "\n\n[+] Cleaning up\n\n"
rm -f $project/directories/dirs.txt
rm -f $project/directories/dir2.txt
rm $project/directories/FinalList.txt
rm -rf $project/directories/webscreenshot
rm ./common_extensions.txt
