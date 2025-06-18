#!/bin/bash

VM_IDS=$(qm list | awk '{if (NR>1 && $3=="running") print $1}')

for vmid in $VM_IDS; 
do
	 qm suspend $vmid; 
done

