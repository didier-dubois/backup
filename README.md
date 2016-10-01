# backup
Trivial backup script

# Motivation
I wanted to backup all my 'user' home dir with the following considerations:
* I do not need to compress (enough of disk space today)
* But I do not want to backup some files every days (Pictures, Trash, ...)
* I want to be able to access the snapshot without external software
* I have many system users to backup

The rolling history will be located onto `/home/backup/<user>`. 

# Installation

`make install`

Will copy the scripts in `/usr/local/bin`

# Configuration
Have a look and modify the `backup-excludes` file. 

# Usage
2 options for you: global backup  or user backup

### Global backup
Add the following entry in your root crontab:

```@daily /usr/local/bin/all-users-backup.sh user1 user2 user3 ...```

Of course you need to replace the user list

### Single user backup
Make sure the 'user' have proper access rights.
Add the follwing on your crontab:

```@daily /usr/local/bin/user-backup.sh```

# Additionaly
You need to sync your backup directory `/home/backup` on a NAS or even better external hard drive in a safe :)




