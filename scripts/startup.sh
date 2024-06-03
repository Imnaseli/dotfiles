#!/bin/bash

hostname=$(hostname)
echo "Welcome to $hostname!"
echo "------------------------------------------------------------"

echo -e "\e[1;36mSystem information:\e[0m"
neofetch
echo "------------------------------------------------------------"

echo -e "\e[1;36mSystem load and uptime:\e[0m"
uptime
echo "------------------------------------------------------------"

echo -e "\e[1;36mDisk space usage:\e[0m"
df -h
echo "------------------------------------------------------------"

echo -e "\e[1;36mMemory usage:\e[0m"
free -h
echo "------------------------------------------------------------"

echo -e "\e[1;36mNetwork interfaces and IP addresses:\e[0m"
ip -4 addr show | awk '/inet/ {print $NF, $2}'
echo "------------------------------------------------------------"

echo -e "\e[1;36mPorts in use:\e[0m"
echo -e "\e[1;33mProto  Local Address  Foreign Address  State\e[0m"
echo -e "\e[1;33m-----  -------------  ---------------  -----\e[0m"
netstat -tuln | awk '/LISTEN/ {print $1, $4, $5, $6}' | while read proto local foreign state; do
  printf "%-5s  %-13s  %-15s  %-s\n" "$proto" "$local" "$foreign" "$state"
done
echo "------------------------------------------------------------"

echo -e "\e[1;36mRunning Docker containers:\e[0m"
docker ps
echo "------------------------------------------------------------"

echo -e "\e[1;36mRunning processes:\e[0m"
ps aux --sort=-%cpu | head -n 6
echo "------------------------------------------------------------"

echo -e "\e[1;36mLast login:\e[0m"
last -1
echo "------------------------------------------------------------"
