#!/bin/bash

if [[ $# -ne 4 ]]
then
	echo "Too few arguments"
	exit
fi

src=$3

if [[ ! -f $src ]]
then
	echo "Impossible to open source file!"
	exit
fi

dest=$4

touch $dest

if [[ ! -f $src ]]
then
	echo "Impossible to open source file!"
	exit
fi


st_pos=$1

if [[ $st_pos == "start" ]]
then
	st_pos=1
elif [[ ! `echo $st_pos | grep -E '^[0-9]+$'` ]]
then
	echo "Wrong start parameter"
	exit
fi


en_pos=$2


if [[ $en_pos == "end" ]]
then
	en_pos=`wc $src -l | cut -d' ' -f1`
elif [[ ! `echo $st_pos | grep -E '^[0-9]+$'` ]]
then
	echo "Wrong end parameter"
	exit
fi


sed -n "$st_pos, $en_pos p" $src > $dest


