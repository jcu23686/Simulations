#!/bin/bash

if [ $# -ne 0 ]
then
        echo
        echo "USAGE: [0]"
        echo
        exit 0
fi

i=1

echo "open 1m7i_full_aligned.pdb" > pose_rmsd.com
echo "open docking_output.pdb" >> pose_rmsd.com

while [ $i -lt 21 ]; do


	echo "rmsd #0:212,213,214,215,216@C1,C2,C3,C4,C5,O5 #1.$i:6,5,4,3,2@C1,C2,C3,C4,C5,O5" >> pose_rmsd.com
	i=$(( $i + 1 ))
done

/Applications/Chimera.app/Contents/MacOS/chimera --nogui pose_rmsd.com > pose_rmsd_chimera 

grep RMSD pose_rmsd_chimera | cut -d" " -f7 > pose_rmsd.txt && rm pose_rmsd_chimera
