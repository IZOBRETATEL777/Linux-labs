#!/bin/bash

if [[ $# -lt 3 ]]
then
	echo "Too few arguments!"
	exit
fi

arg=$1
if [[ $arg != "--title" ]]
then
	echo "Unknown argument $arg"
	exit
fi

to_find=$2

file=$3

if [[ ! -f $file ]]
then
	echo "Cannont open file $file"
	exit
fi

while IFS=';' read Car MPG Cylinders Displacement Horsepower Weight Acceleration Model Origin
do
	if [[ `echo $Car | grep -Fxi "$to_find"` ]]
	then
		printf "=========== %s report ===========\n" "$Car"
		printf "MPG: %s, Cylinders: %s\n" $MPG $Cylinders
		printf "Displacement: %s, Horsepower %s\n" $Displacement $Horsepower
		printf "Weight: %s, Acceleration:%s\n" $Weight $Acceleration
		printf "Model: %s, Origin: %s\n" $Model $Origin
		printf "=================================================\n"

		exp=`LC_NUMERIC=C printf "%f*%f-%f/10" "$Horsepower" "$Cylinders" "$Weight"`
		rate=`echo $exp | bc -l`
		LC_NUMERIC=C printf "Rating: %.0f\n" $rate

		status=
		if [[ `echo "100>$rate" | bc -l` -eq 1 ]]
		then
			status="Bad"
		elif [[ `echo "100<=$rate && $rate<150" | bc -l` -eq 1 ]]
		then
			status="Good"
		elif [[ `echo "$rate>=150" | bc -l` -eq 1 ]]
		then
			status="Very Good"
		fi

		printf "Status: %s\n" "$status"
		printf "=================================================\n"

		break
	fi
done < $file

