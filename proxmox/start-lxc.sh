#!/bin/bash

LXC_IDS=$(pct list | awk '{if (NR>1 && $2=="stopped") print $1}')

for ct in $LXC_IDS;
do 
	pct start $ct; 
done

