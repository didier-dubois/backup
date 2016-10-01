#!/bin/bash
#
# Didier Dubois
#
# Usage: all-users-backup.sh usewr1 user2 user3
# 

SECONDS=0
user=`whoami`
[ $# -eq 0 ] && echo "Error - parameter needed" && exit 1 


BCK_ROOT=`dirname $0`
BCK_ROOT=`readlink -f $BCK_ROOT`
script=$BCK_ROOT/user-backup.sh
LOG=/home/backups/logs

for user in $*; do
    if [ -d /home/$user ]; then 
	echo "Backuping $user ${SECONDS}s"
	$script $user > $LOG/$user.last # Used for report building
    else
        echo "Error - user $user not found"
    fi
done


duration=$SECONDS
date=`date`
echo "Done all user backup | $date |  $duration s | ERR: $err" 

        
