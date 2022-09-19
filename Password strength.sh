#!/bin/bash

pass=$1

req=0

if [[ ${#pass} -ge 8 ]]
then
((req++))
fi

if [[ $pass =~ [a-zA-Z]+ && $pass =~ [0-9]+ ]]
then
((req++))
fi

if [[ $pass =~ [a-z]+ && $pass =~ [A-Z]+ ]]
then
((req++))
fi

msg=""

if [[ $req -eq 3 ]]; then msg=“strong”
elif [[ $req -eq 2 ]]; then msg=“ok”
elif [[ $req -eq 1 ]]; then msg=“weak”
elif [[ $req -eq 0 ]]; then msg=“bad”
fi

echo $msg






