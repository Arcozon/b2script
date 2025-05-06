#!/bin/bash

Archi=$(uname -a)
pCPU=$(lscpu -p | grep -v "#" | wc -l)
vCPU=$(echo "$pCPU * $(lscpu | grep 'Thread' | awk '{print $4}') * $(lscpu | grep 'Core(s)' | awk '{print $4}')" | bc)
Mem=$(free -m | grep Mem | awk '{print $3"/"$2}')
TotalMeme=$(free -tm | grep Total | awk '{print $3"/"$2}')
txt_DiskUsage=$(df -h / | grep -v Filesystem | awk '{sub(/G$/, "", $3); print $3"/"$2"  ("$5")"}')
txt_CPUUsage=$(top -b -n 1 | grep Cpu | awk -F',' '{ print $4}' | awk -F" " '{print $1}' | awk '{printf("%.1f%%\n", 100-$1)}')
uptime=$(uptime -s | awk -F':' '{print $1":"$2}')
