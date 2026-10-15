#!/bin/bash

function ctrl_c(){
    echo -e "\n\n [!] Exitting ... \n"
    exit 1
}

# Ctrl+C
trap ctrl_c INT

while getopts "m:t:h" arg; do
    case $arg in
    m) money=$OPTARG;;
    t) technique=$OPTARG;;
    h) helpPanel;;
    esac
done 

# if else to check which option is active
if [ $money ] && [ $technique ]; then
    echo -e "Playing with $money money and $technique technique"
else
    echo -e "going to the else"
fi 