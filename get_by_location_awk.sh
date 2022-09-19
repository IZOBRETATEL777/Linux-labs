#!/bin/bash

file=$1
to_find=$2

awk -F';' -v loc=$to_find '{
if ($8 == loc)
	print $5,$6,$7
}' $file

