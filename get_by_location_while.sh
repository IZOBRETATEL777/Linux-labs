#!/bin/bash

file=$1
to_find=$2

while IFS=';' read login id otp rec_code fname lname dep loc
do
	if [[ $to_find == $loc ]]
	then
		printf "%s %s %s\n" $fname $lname $dep
	fi
done < $file

