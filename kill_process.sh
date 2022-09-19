#!/bin/bash

proc=`pgrep $1`
method=$2

case $method in
    "1")
    kill -1 $proc
    ;;

    "9")
    kill -9 $proc
    ;;

    "15")
    kill -15 $proc
    ;;

    *)
    echo "no way"
esac

