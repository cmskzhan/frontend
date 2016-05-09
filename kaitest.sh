#!/usr/bin/expect -f
# Set variables
set hostname [lindex $argv 0]
set serverTrimmed [string trim $hostname]
spawn ssh -o StrictHostKeyChecking=no kzh\@$serverTrimmed
expect "assword"
send "Maya4pro++\r"
send "sudo su - sroot\r"
expect "assword"
send "Maya4pro++\r"
expect "]"
send -- "alias h=history; export today=`date +'%Y%m%d'` \r"
interact