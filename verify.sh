#!/usr/bin/env bash
# Bash script to compare saved checksums with current checksums
i=1
while read line; do
	IFS=' ' 
	read sSum f <<< "$line"
	read nSum nf <<< "$(md5sum $f)"
	if [ "$sSum" != "$nSum" ]; then
		echo $f Has Been Tampered With!
	fi
	i=$((i+1))

done < sums.txt
