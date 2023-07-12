#!/bin/bash

# Colors

green="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
red="\e[0;31m\033[1m"
blue="\e[0;34m\033[1m"
yellow="\e[0;33m\033[1m"
purpler="\e[0;35m\033[1m"
turquoise="\e[0;36m\033[1m"
gray="\e[0;37m\033[1m"

# Funcions

function ctrl_c(){
    echo -e "\n${red}[+]${endColour} Sortint ..."
    exit 1
}

#Ctrl C
trap ctrl_c INT

declare -a host=($(seq 1 255))
ipA="$(echo $1 | cut -d '.' -f1)."
ipB="$(echo $1 | cut -d '.' -f1,2)."
ipC="$(echo $1 | cut -d '.' -f1,2,3)."
cidr="$(echo $1 | cut -d '.' -f4 | cut -d '/' -f2)"

if [ $cidr -gt 0 ] && [ $cidr -lt 9 ];then
    for x in ${host[@]};do
        for a in ${host[@]};do
            for b in ${host[@]};do
                for c in ${host[@]};do
                    timeout 1 bash -c "ping -c1 $x.$a.$b.$c" &>/dev/null && echo -e "$x.$a.$b.$c -${green} ACTIU${endColour}" &
                done
            done
        done
    done
elif [ $cidr -gt 8 ] && [ $cidr -lt 17 ];then
    for a in ${host[@]};do
        for b in ${host[@]};do
            for c in ${host[@]};do
                timeout 1 bash -c "ping -c1 $ipA$a.$b.$c" &>/dev/null && echo -e "$ipA$a.$b.$c -${green} ACTIU${endColour}" &
            done
        done
    done
elif [ $cidr -gt 16 ] && [ $cidr -lt 25 ];then
    for b in ${host[@]};do
        for c in ${host[@]};do
            timeout 1 bash -c "ping -c1 $ipB$b.$c" &>/dev/null && echo -e "$ipB$b.$c -${green} ACTIU${endColour}" &
        done
    done
elif [ $cidr -gt 24 ] && [ $cidr -lt 33 ];then
    for c in ${host[@]};do
        timeout 1 bash -c "ping -c1 $ipC$c" &>/dev/null && echo -e "$ipC$c -${green} ACTIU${endColour}" &
    done
fi

