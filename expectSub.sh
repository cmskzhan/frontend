#!/usr/bin/expect -f
# Set variables
set hostname [lindex $argv 0]
set serverTrimmed [string trim $hostname]
spawn ssh -o StrictHostKeyChecking=no kzh\@$serverTrimmed
expect "assword"
send "Maya4pro++\r"
send "sudo su sroot\r"
expect "assword"
send "Maya4pro++\r"
send_tty "\r"
send_tty "export h=history \r"
interact