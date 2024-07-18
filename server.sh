#!/bin/bash

dt=`date "+%Y-%m-%d %H:%M"`

#Removing older files.

rm /home/pagebrake/Documents/monitoring/Data/sample.csv
rm /home/pagebrake/Documents/monitoring/node1/*

###SCP all the files from another ubuntu macine called node. 

scp -r node1@192.168.1.19:/home/node1/Documents/monitoring/Data/* /home/pagebrake/Documents/monitoring/node1/

#This is to convert txt into csv file.

echo "IP","SERVERNAME","CPUs","CPU SPEED","UPTIME","LOAD AVERAGE","TOTAL MEMORY","USED MEMORY","FREE MEMORY" > /home/pagebrake/Documents/monitoring/Data/sample.csv

echo "`cat /home/pagebrake/Documents/monitoring/Data/aip.txt`","`cat /home/pagebrake/Documents/monitoring/Data/hostname.txt`","`cat /home/pagebrake/Documents/monitoring/Data/acpu.txt`","`cat /home/pagebrake/Documents/monitoring/Data/ascpu.txt`","`cat /home/pagebrake/Documents/monitoring/Data/runtime.txt`","`cat /home/pagebrake/Documents/monitoring/Data/loadavg.txt`","`cat /home/pagebrake/Documents/monitoring/Data/totalmem.txt`","`cat /home/pagebrake/Documents/monitoring/Data/usedmem.txt`","`cat /home/pagebrake/Documents/monitoring/Data/freemem.txt`" >> /home/pagebrake/Documents/monitoring/Data/sample.csv

echo "`cat /home/pagebrake/Documents/monitoring/node1/aip.txt`","`cat /home/pagebrake/Documents/monitoring/node1/hostname.txt`","`cat /home/pagebrake/Documents/monitoring/node1/acpu.txt`","`cat /home/pagebrake/Documents/monitoring/node1/ascpu.txt`","`cat /home/pagebrake/Documents/monitoring/node1/runtime.txt`","`cat /home/pagebrake/Documents/monitoring/node1/loadavg.txt`","`cat /home/pagebrake/Documents/monitoring/node1/totalmem.txt`","`cat /home/pagebrake/Documents/monitoring/node1/usedmem.txt`","`cat /home/pagebrake/Documents/monitoring/node1/freemem.txt`" >> /home/pagebrake/Documents/monitoring/Data/sample.csv

#Converting the csv to html
cat "/home/pagebrake/Documents/monitoring/Data/sample.csv" | /home/pagebrake/Documents/monitoring/tablute1.sh -d "," -t "Vicky's Ubuntu1 Linux Monitoring Data" -h "Vicky's Ubuntu1 Linux Monitoring Data" > /home/pagebrake/Documents/monitoring/Output/ServerMonitor.html

## Sending email ###
{
  cat <<EOF
From: pop.tricky@gmail.com
To: pop.tricky@gmail.com
Subject: my linux Servers State : `date "+%Y-%m-%d %H:%M"`
Content-Type: text/html

Hello,
Please find the below status of server at `date "+%Y-%m-%d %H:%M"`.

EOF

  cat /home/pagebrake/Documents/monitoring/Output/ServerMonitor.html
} | /usr/sbin/sendmail -t