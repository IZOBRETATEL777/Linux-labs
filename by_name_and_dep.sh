#!/bin/bash

file=$1
name_to_find=$2
dep_to_find=$3

awk -F';' -v name=$name_to_find -v dep=$dep_to_find '{
if ($4 == name && $6 == dep)
	print $0
}' $file

