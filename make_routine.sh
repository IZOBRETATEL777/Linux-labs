#!/bin/bash

cronpath="/etc/crontab"

if [[ $# -eq 0 ]]
then
	echo "Too few arguments"
	exit
fi

if [[ $1 == "on" ]]
then
	log=$2
	if [[ ! $log ]]
	then
		echo "Too few arguments!"
		exit
	fi
	>$log
	if [[ ! -f $log ]]
	then
		echo "Impossible to create log file!"
		exit
	fi
	cmd1='0 3 * * 6 root sudo apt update && sudo apt upgrade -y'
	cmd2='30 1 * * 0 root dmesg>'$log
	echo "$cmd1" >> $cronpath
	echo "$cmd2" >> $cronpath
elif [[ $1 == "off" ]]
then
	sed '/^0 3 \* \* 6 root sudo apt update && sudo apt upgrade \-y$/d' $cronpath -i
	sed '/^30 1 \* \* 0 root dmesg>.*/d' $cronpath -i
else 
	echo "Unknown parameter!"
fi

