#!/bin/bash

hostname=$(hostname)
echo "Welcome to $hostname!"
echo "------------------------------------------------------------"

echo -e "\e[1;36mSystem information:\e[0m"
neofetch
echo "------------------------------------------------------------"

#echo -e "\e[1;36mSystem load and uptime:\e[0m"
#uptime
#echo "------------------------------------------------------------"

#echo -e "\e[1;36mDisk space usage:\e[0m"
#df -h
#echo "------------------------------------------------------------"

#echo -e "\e[1;36mMemory usage:\e[0m"
#free -h
#echo "------------------------------------------------------------"

#echo -e "\e[1;36mNetwork interfaces and IP addresses:\e[0m"
#ip -4 addr show | awk '/inet/ {print $NF, $2}'
#echo "------------------------------------------------------------"

#echo -e "\e[1;36mRunning Docker containers:\e[0m"
#docker ps
#echo "------------------------------------------------------------"

echo -e "\e[1;36mRunning processes:\e[0m"
ps aux --sort=-%cpu | head -n 6
echo "------------------------------------------------------------"

#echo -e "\e[1;36mLast login:\e[0m"
#last -1
#echo "------------------------------------------------------------"
