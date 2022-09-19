#!/bin/bash


output="emails_and_ip_addresses"
> $output
for file in `ls -a $PWD`
do
	if [[ -f $file ]]
	then
		for email in `grep -E '^[a-zA-Z0-9_\.\-]+@[a-zA-Z0-9_\.\-]+\.[a-zA-Z]+$' $file`
		do
			if [[ $email ]]
			then
				echo $email >> $output
			fi
		done

		for addr in `grep -E '^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$' $file`
		do
			if [[ $addr ]]
			then
				echo $addr >> $output
			fi
		done
	fi
done
