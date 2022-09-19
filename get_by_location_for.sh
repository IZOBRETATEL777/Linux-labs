#!/bin/bash

file=$1
to_find=$2

for line in `cat $file`
do
	loc=`echo $line | cut -d';' -f8`
	lname=`echo $line | cut -d';' -f6`
	fname=`echo $line | cut -d';' -f5`
	dep=`echo $line | cut -d';' -f7`

	if [[ $to_find == $loc ]]
	then
		printf "%s %s %s\n" $fname $lname $dep
	fi
done

