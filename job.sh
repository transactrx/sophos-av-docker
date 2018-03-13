#!/bin/bash
set -e

cd /opt/sophos-av/bin/

while :
do
	./savupdate -v5
	savscan -all --stay-on-machine -s --no-follow-symlinks --skip-special --no-reset-atime /scan -exclude /scan/cgroup /scan/sys /scan/var/run/docker /scan/home/sftproot /scan/var/lib/docker /scan/proc
	sleep $INTERVAL
done
