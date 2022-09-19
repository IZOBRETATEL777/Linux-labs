#!/bin/bash

if [[ $# -lt 2 ]]
then
	echo "Too few arguments"
	exit
fi

arg=$1
to_find=
file=

if [[ $arg == "--origin" ]]
then
	file=$2
elif [[ $arg == "--title" ]]
then
	to_find=$2
	file=$3
else
	echo "Unknown argument $arg"
	exit
fi

if [[ ! -f $file ]]
then
	echo "Impossible to locate file"
	exit
fi

if [[ $arg == "--origin" ]]
then
	awk -F';' '{ 
	if(NR > 2)
		print $9
	}' $file |tr -d $'\r'| sort | uniq -c | sort -k1 -nr | awk '{printf("%s: %s\n",$2,$1)}'
elif [[ $arg  == "--title" ]]
then
	awk -F';' -v car="$to_find" '{
	if (NR > 2 && $1 == car)
		print $1
	}' $file | sort | uniq -c | awk '{print $1}'
fi


