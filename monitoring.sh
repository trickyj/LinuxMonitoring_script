#!/bin/bash 

# Define the directory
cd /home/pagebrake/Documents/monitoring/Data

# Remove old data files (uncomment if necessary)
rm /home/pagebrake/Documents/monitoring/Data/* 

# Collect system data
date --date="0 day ago" "+%m-%d-%Y %H:%M" > SYSDATE.txt 

#host and IP
hostname > hostname.txt 
hostname -I > aip.txt 

# Number of CPU
ncpu=$(lscpu | head -5 | tail -1)
echo $ncpu | awk -F":" '{print $2}' > acpu.txt 

#CPU speed. (Max CPU and Min CPU) to convert Mhz to Ghz formula is - divide the frequency value by 1000

scpu=$(lscpu | head -16 | tail -1)
echo $scpu | awk -F":" '{print $2/1000}' > ascpu.txt 

#CPU up time
dayup=$(uptime | awk -F"," '{print $1}')
echo $dayup | awk -F" " '{print $2,$4}' > runtime.txt 

#CPU usage average. 
uptime | awk -F"load average:" '{print $2}' | awk -F"," '{print $1}' > loadavg.txt 

# it displays the 3rd line on top command. Which is of CPU utilization.
top | head -3 | tail -1 > ucpu.txt 

#free - Display amount of free and used memory in the system
# -h human radable format.
# -t, --total Display a line showing the column totals.
# $2 - used, $3 - free, $4 - shared memory.
# we do grep on total (it showed 3 rows(mem, swap & total) we are select the last row which is total)

free -h -t | grep Total | awk '{print $2}' > totalmem.txt 
free -h -t | grep Total | awk '{print $3}' > usedmem.txt 
free -h -t | grep Total | awk '{print $4}' > freemem.txt 

#df - report file system space usage.
#-kh - Block size in human readble format.
# it shows 6 columns we are using awk to choose the columns we want.

df -kh | awk '{print $6, $2, $3, $5}' > mount.csv 