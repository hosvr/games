#!/bin/sh

#backup
stamp=$(date "+%F_%H%M")
backup="backup_${stamp}"

tar -czf "/home/ubuntu/backups/${backup}.tar.gz" /home/ubuntu/Saved/*

# kill remaining processes
pkill PalServer
