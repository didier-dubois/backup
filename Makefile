#
# Install Application
#

DEST=/usr/local/bin
files=all-users-backup.sh user-backup.sh backup-excludes

install:
	cp $(files) $(DEST)
