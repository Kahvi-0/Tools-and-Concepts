#!/bin/bash

# $1 is the first argument

url=$1

if [ ! -d "$url"]; then
	mkdir $url
fi


if [ ! -d "$url/recon"]; then
	mkdir $url/recon
fi

echo "Nomnomnomming subdomains with assetfinder...."

assetfinder $url >> $url/recon/assets.txt

cat $url/recon/assets.txt | grep $1 >> $url/recon/final.txt

rm $url/recon/assets.txt


echo "Buzzing subdomains with Amass...."

amass enum -d $url >> $url/recon/f.txt

sort -u $url/recon/f.txt >> $url/recon/final.txt

rm $url/recon/f.txt

echo "Probing for alice domains with httprobe...."

cat $url/recon/final.txt | sort -u | httprobe -s -p https:443 |  sed 's/https\?:\/\///' | tr -d ':443' | tee -a $url/recon/a.txt

sort -u $url/recon/a.txt > $url/recon/alive.txt

rm $url/recon/a.txt


echo "Looking for sites we can subjack...."

if [ ! -d "$url/recon/potential_takeover"]; then
	mkdir $url/recon/potential_takeover
	touch $url/recon/potential_takeover/PT.txt
fi

subjack -w $url/recon/final.txt -t 100 -timeout 30 -ssl -c ~/go/src/github.com/haccer/subjack/fingerprints.json -v 3 -o $url/recon/potential_takeover/PT.txt


echo "Scanning for open ports...."

nmap -iL $url/recon/alive.txt -T4 -oA $url/recon/scan.txt

echo "Looking waaaaaaaaayback...."

cat $url/recon/final.txt | waybackurls >> $url/recon/waybackoutput.txt
sort -u $url/recon/waybackoutput.txt > $url/recon/waybacksorted.txt
rm $url/recon/waybackoutput.txt


echo "Pulling params...."

cat $url/recon/waybacksorted.txt | grep '?*=' | cut -d '=' -f 1 | sort -u >> $url/recon/waybackparams.txt

for line in $(cat $url/recon/waybackparams.txt);do echo $line'=';done

echo "Pulling js/php/aspx/jsp/json files from wayback output..."
for line in $(cat $url/recon/waybacksorted.txt);do
	ext="${line##*.}"
	if [[ "$ext" == "js" ]]; then
		echo $line >> $url/recon/waybackJS1.txt
		sort -u $url/recon/waybackJS1.txt >> $url/recon/waybackJS.txt
	fi
	if [[ "$ext" == "html" ]]; then
		echo $line >> $url/recon/waybackJSP1.txt
		sort -u $url/recon/waybackJSP1.txt >> $url/recon/waybackJSP.txt
	fi
	if [[ "$ext" == "json" ]]; then
		echo $line >> $url/recon/waybackJSON1.txt
		sort -u $url/recon/waybackJSON1.txt >> $url/recon/waybackJSON.txt
	fi
	if [[ "$ext" == "php" ]]; then
		echo $line >> $url/recon/waybackPHP1.txt
		sort -u $url/recon/waybackPHP1.txt >> $url/recon/waybackPHP.txt
	fi
	if [[ "$ext" == "aspx" ]]; then
		echo $line >> $url/recon/waybackASPX1.txt
		sort -u $url/recon/waybackASPX1.txt >> $url/recon/waybackASPX.txt
	fi

done

rm $url/recon/waybackJS1.txt
$url/recon/waybackJSP1.txt
rm $url/recon/waybackJSON1.txt
$url/recon/waybackPHP1.txt
$url/recon/waybackASPX1.txt


echo "Witnessing alive pages...."

gowitness file -s $url/recon/alive.txt -d $url/recon/gowitness
