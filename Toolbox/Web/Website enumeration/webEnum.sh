#!/bin/bash

usage=: '

	Usage web.sh <http://target> <port> <bust level>
	
-----------------------------------------------------------

 Flags:
	Directory bust level:   
				-1: light
				-2: heavy
				-3: really heavy
				
-----------------------------------------------------------

 Tips:
  Routing through Burp:
     Proxy -> Options -> Proxy Listeners -> Add
        Binding: port: 8081  Loopback only
        Request handling: Redirect to host: <target IP> <target port>
        
----------------------------------------------------------- '
        

if [ "$#" -ne 3 ]; then
        echo $usage
        exit 2
fi


if [[ $1 =~ ^http ]]; then
    echo ""
else
    echo $usage
    exit 2
fi

# Checking if cutycapt is installed
if [[ -x "$(command -v cutycapt)" ]]; then
	echo "cutycapt installed"	
else
	echo "Installing phantomjs"
	sudo apt-get install cutycapt
	echo "Done"
fi


/usr/bin/echo "what is the project name?"
read project

echo -e "\n\n[+] preparing project directories and files\n\n"
/usr/bin/mkdir $project
/usr/bin/mkdir $project/directories
/usr/bin/mkdir $project/vulnScan
/usr/bin/mkdir -p $project/directories/screenshots/100
/usr/bin/mkdir -p $project/directories/screenshots/200
/usr/bin/mkdir -p $project/directories/screenshots/300
/usr/bin/mkdir -p $project/directories/screenshots/400
/usr/bin/mkdir -p $project/directories/screenshots/500
/usr/bin/touch $project/overview.html
git -C $project/directories/ clone https://github.com/Tuhinshubhra/CMSeeK
pip3 install -r $project/directories/CMSeeK/requirements.txt

## Add CMS detection

echo "<h1>CMS details</h1>" >> $project/overview.html
echo "" | python3 $project/directories/CMSeeK/cmseek.py -u $1 | grep -oE "(Detected CMS.*)" >> $project/overview.html
echo "" | python3 $project/directories/CMSeeK/cmseek.py -u $1 | grep -oE "(........Version.*)" >> $project/overview.html
echo "" | python3 $project/directories/CMSeeK/cmseek.py -u $1 | grep -oE "(^.*vulnerabilities.*)" >> $project/overview.html

## Add specific scanners for discovered CMS

## Add results of those scanners to direcotry list / certain output to the file

## Scrape robots.txt for directories 


echo -e "\n\n[+] gobusting directories\n\n"

#obtain file extension list and parse it for gobuster
wget https://raw.githubusercontent.com/Kahvi-0/Tools-and-Concepts/master/Toolbox/Web/wordlists/common_extensions.txt
extensions=$(sed -z 's/\n/,/g' common_extensions.txt)

#light busting
if [ $3 == -1 ]; then
echo -e "\n\n[+] common.txt\n\n"
/usr/bin/gobuster -q dir -u $1:$2 -w /usr/share/wordlists/dirb/common.txt -er -x extensions -t 500 > $project/directories/dirs.txt 
fi

#heavy busting
if [ $3 == -2 ]; then
echo -e "\n\n[+] common.txt\n\n"
/usr/bin/gobuster -q dir -u $1:$2 -w /usr/share/wordlists/dirb/common.txt -er -x extensions -t 500 > $project/directories/dirs.txt
echo -e "\n\n[+] directory-list-2.3-medium.txt\n\n"
/usr/bin/gobuster -q dir -u $1:$2 -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -er -x extensions -t 500 >> $project/directories/dirs.txt 
fi

#really heavy busting
if [ $3 == -3 ]; then
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
echo "<h1>100 Status</h1>" >> $project/overview.html
for i in $(cat $project/directories/100status.txt); do
    FILE=$((1 + FILE))
    echo "<br>" >> $project/overview.html
    echo $i >> $project/overview.html    
    echo "<br>" >> $project/overview.html
    cutycapt --url="$i" --out="$project/directories/screenshots/100/$FILE.png"
    echo "<img src="./directories/screenshots/100/$FILE.png">" >> $project/overview.html
    echo "<br>" >> $project/overview.html
done

echo -e "\n\n[+] 2xx status\n"
echo "<h1>200 Status</h1>" >> $project/overview.html
for i in $(cat $project/directories/200status.txt); do
    FILE=$((1 + FILE))
    echo "<br>" >> $project/overview.html
    echo $i >> $project/overview.html    
    echo "<br>" >> $project/overview.html
    cutycapt --url="$i" --out="$project/directories/screenshots/200/$FILE.png"
    echo "<img src="directories/screenshots/200/$FILE.png">" >> $project/overview.html
    echo "<br>" >> $project/overview.html
done


echo -e "\n\n[+] 3xx status\n"
echo "<h1>300 Status</h1>" >> $project/overview.html
for i in $(cat $project/directories/300status.txt); do
    FILE=$((1 + FILE))
    echo "<br>" >> $project/overview.html
    echo $i >> $project/overview.html    
    echo "<br>" >> $project/overview.html
    cutycapt --url="$i" --out="$project/directories/screenshots/300/$FILE.png"
    echo "<img src="./directories/screenshots/300/$FILE.png">" >> $project/overview.html
    echo "<br>" >> $project/overview.html
done


echo -e "\n\n[+] 4xx status\n" 
echo "<h1>400 Status</h1>" >> $project/overview.html
for i in $(cat $project/directories/400status.txt); do
    FILE=$((1 + FILE))
    echo "<br>" >> $project/overview.html
    echo $i >> $project/overview.html    
    echo "<br>" >> $project/overview.html
    cutycapt --url="$i" --out="$project/directories/screenshots/400/$FILE.png"
    echo "<img src="./directories/screenshots/400/$FILE.png">" >> $project/overview.html
    echo "<br>" >> $project/overview.html
done


echo -e "\n\n[+] 5xx status\n"
echo "<h1>500 Status</h1>" >> $project/overview.html
for i in $(cat $project/directories/500status.txt); do
    FILE=$((1 + FILE))
    echo "<br>" >> $project/overview.html
    echo $i >> $project/overview.html    
    echo "<br>" >> $project/overview.html
    cutycapt --url="$i" --out="$project/directories/screenshots/500/$FILE.png"
    echo "<img src="./directories/screenshots/500/$FILE.png">" >> $project/overview.html
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
