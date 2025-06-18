#!/bin/bash

VM_IDS=$(qm list | awk '{if (NR>1 && $3=="suspended") print $1}')

for vmid in $VM_IDS; 
do
	 qm resume $vmid; 
done

