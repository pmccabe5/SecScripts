#!/usr/bin/env bash
files="/etc/passwd /etc/shadow /etc/sudoers"
user=$(whoami)
dst="/root/backups"
day=$(date +%Y-%m-%d)
host=$(hostname -s)
archive="$host-$day.tar.gz"
echo "Backup has begun"
tar czf $dst/$archive $files
echo "Backup completed"
ls -alth $dst