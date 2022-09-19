#!/bin/bash

cmd=$1
args=( "$@" )

if [[ $# -ge 2 ]] && [[ ( $cmd = "start" || $cmd = "stop" ) ]]; then
    for ((i=1; i<$#; i++))
        do
        srv=${args[i]}
        if [[ -z `systemctl show $srv --property=ActiveEnterTimestamp | cut -d'=' -f2` ]];  then
            echo "No service with name $srv"
        else
            echo "systemctl $cmd $srv"
            systemctl $cmd $srv
        fi
        done
else
    echo "usage: service_group.sh command (start/stop) service_name1, service_name2,..."
fi

