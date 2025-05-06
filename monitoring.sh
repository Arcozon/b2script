#!/bin/bash

Archi=$(uname -a)
pCPU=$(lscpu -p | grep -v "#" | wc -l)
vCPU=$(echo "$pCPU * $(lscpu | grep 'Thread' | awk '{print $4}') * $(lscpu | grep 'Core(s)' | awk '{print $4}')" | bc)
Mem=$(free -m | grep Mem | awk '{print $3"/"$2}')
Total=$(free -tm | grep Total | awk '{print $3"/"$2}')


