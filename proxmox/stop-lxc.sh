#!/bin/bash

LXC_IDS=$(pct list | awk '{if (NR>1 && $2=="running") print $1}')

for ct in $LXC_IDS;
do 
	pct stop $ct; 
done


