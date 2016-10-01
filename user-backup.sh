#!/bin/bash
#
# Modified by Didier Dubois
#
# See https://rsync.samba.org/examples.html
#
# This script does personal backups to a rsync backup server. You will end up
# with a 7 day rotating incremental backup. The incrementals will go
# into subdirectories named after the day of the week, and the current
# full backup goes into a directory called "current"
# tridge@linuxcare.com

SECONDS=0

user=`whoami`
[ $# -eq 1 ] && user=$1
#echo "User Set to $user"

# directory to backup
BDIR=/home/$user
BACK_DST=/home/backups/$user

mkdir -p $BACK_DST

# excludes file - this contains a wildcard pattern per line of files to exclude
exclude=`dirname $0`
exclude=`readlink -f $exclude`
EXCLUDES=$exclude/backup-excludes
BACKUPDIR=`date +%A`

# Options
#
# --force                 force deletion of dirs even if not empty
# --ignore-errors         delete even if there are I/O errors 
# --delete-excluded       also delete excluded files from dest dirs
#

OPTS=" --force --ignore-errors --delete-excluded --exclude-from=$EXCLUDES 
      --delete --backup --backup-dir=$BACK_DST/$BACKUPDIR -a "


export PATH=$PATH:/bin:/usr/bin:/usr/local/bin

# the following line clears the last weeks incremental directory
[ -d $BDIR/.emptydir ] || mkdir $BDIR/.emptydir
rsync --delete -a $BDIR/.emptydir/ $BACK_DST/$BACKUPDIR/
rmdir $BDIR/.emptydir

# now the actual transfer
rsync $OPTS $BDIR $BACK_DST/current 
err=$?

#--- Show execution time - I'm using it to build a report
duration=$SECONDS
date=`date`
echo "Done user backup '$user' | $date |  ${duration}s | ERR: $err" 


