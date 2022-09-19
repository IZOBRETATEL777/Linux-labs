#!/bin/bash

if [[ $# -lt 3 ]]
then
	echo "Too few arguments"
	exit
fi

arg=$1
to_find=$2
file=$3

if [[ ! -f $file ]]
then
	echo "Cannot reach the file!"
	exit
fi

field=

case $arg in
	--author)
		if [[ ${#arg} -eq 2 && ! `echo $to_find | grep -E '^.+_.+$'` ]]
		then
			echo "Wrong usage!"
			exit
		fi
		field=2
		to_find=`echo $to_find | sed 's/\(\w\+\)_\(\w\+\)/\2 \1/'`
		echo $to_find
		;;
	--title)
		field=1
		;;
	--genre)
		field=3
		;;
	*)
		echo "Unknow parameter!"
		;;
esac

_IFS=$IFS
IFS='
'

ans=()

for line in `cat $file`
do
	t=`echo $line | cut -d',' -f $field`
	if [[ $t == $to_find ]]
	then
		title=`echo $line | cut -d',' -f1`
		author=`echo $line | cut -d',' -f2`
		if [[ `echo $author | wc -w` -eq 3 ]]
		then
			author=`sed 's/\(\w\+\) \(\w\+\) \(\w\+\)/\2 \3/'`
		fi
		genre=`echo $line | cut -d',' -f3`
		subgenre=`echo $line | cut -d',' -f4`
		ans+=($title)
		ans+=($author)
		ans+=($genre)
		ans+=($subgenre)
	fi
done
IFS=$_IFS

size=${#ans[@]}
cnt=$((size/4))

for((i=0;i<$size;i+=4))
do
	echo "${ans[$i]} ${ans[$((i+1))]} ${ans[$((i+2))]} ${ans[$((i+3))]}"
done


echo "$cnt books in Total"


