#!/bin/bash
# Script for mining 
# version 0.1 
# Author: orvn
# License GPL


# determine a single url
read -p 'Enter a URL to mine: ' uri
echo

echo "Destination URI $uri accepted!"
echo

status=$(curl -I $uri | awk 'NR==1{print $2}')

# follow redirects to source
function redirective {
	if [ -z "$1" ]; then
		uri=$uri
	else
		uri=$1
	fi

	reuri=$(curl -I $uri| grep [lL]ocation | awk '{print $2}')
	status=$(curl -I $reuri | awk 'NR==1{print $2}')

	if [ $status != 200 ]; then
		redirective $reuri
	fi
}

# http status handling
if [ $status != 200 ]; then
	echo "issue, status = $status"
	echo "finding alternate..."
	echo
	case $status in
		30[1-8]) echo "redirect"; echo; redirective $uri;;
		10[0-2]|20[1-8]|226) echo "ignoring issue";;
		4[0-9][0-9]) echo "400 series error, unable to continue, aborting.";;
		5[019][0-9]) echo "500 series server error, unable to continue, aborting.";;
		*) echo "unknown status";;
	esac

else
	echo "proceding with correct URI ($status)"
	echo
	# currently extraction works with tags only, not attributes or content
	read -p 'Extract tag: ' extractor
	echo "$uri is the url"
	echo
	# extraction=$(curl $uri | grep -o $extractor)
	echo $extractor
	extraction=$(curl $uri | grep -o "<$extractor>.*</$extractor>")
	echo $extraction
fi


