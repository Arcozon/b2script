#!/bin/bash

Archi=$(uname -a)
pCPU=$(lscpu -p | grep -vc "#"l)
vCPU=$(echo "$pCPU * $(lscpu | grep 'Thread' | awk '{print $4}') * $(lscpu | grep 'Core(s)' | awk '{print $4}')" | bc)

Mem=$(free -m | grep Mem | awk '{printf "%s/%s  (%.1f%%)", $3, $2, $3/$2*100}')
TotalMeme=$(free -tm | grep Total | awk '{printf "%s/%s  (%.1f%%)", $3, $2, $3/$2*100}')

txt_DiskUsage=$(df -h / | grep -v Filesystem | awk '{sub(/G$/, "", $3); print $3"/"$2"  ("$5")"}')
txt_CPUUsage=$(top -b -n 1 | grep Cpu | awk -F',' '{ print $4}' | awk -F" " '{print $1}' | awk '{printf("%.1f%%\n", 100-$1)}')

LastBoot=$(uptime -s | awk -F':' '{print $1":"$2}')

if [ $(lsblk | grep -c lvm) -gt 0 ]
then
	ActiveLVM=""
else
	ActiveLVM=" not"
fi

TCP_Connections=$(cat /proc/net/tcp | grep -vc sl)
Nb_Users=$(who | wc -l)
IP="IP "$(hostname -I | awk '{printf $1}')"  ("$(ip link | grep link/ether | awk 'NR==1{print $2}')")"
NbSudo=$(cat /var/log/sudo/sudo.log | grep -c COMMAND)

wall -n "  Architecture: $Archi
  Physical CPU: $pCPU
  Virtual CPU: $vCPU
  Memory usage: $Mem
  Disk usage: $txt_DiskUsage
  CPU usafe: $txt_CPUUsage
  Last boot: $LastBoot
  LVM are$ActiveLVM used
  TCP connections: $TCP_Connections
  User connected: $Nb_Users
  Sudo commands: $NbSudo" 
