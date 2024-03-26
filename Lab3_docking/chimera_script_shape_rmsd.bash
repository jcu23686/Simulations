#!/bin/bash
#!/bin/bash

if [ $# -ne 0 ]
then
        echo
        echo "USAGE: [0]"
        echo
        exit 0
fi

i=1

echo "open 1m7i_full_aligned.pdb" > shape_rmsd.com
echo "open docking_output.pdb" >> shape_rmsd.com

while [ $i -lt 21 ]; do
	echo "match #0:212,213,214,215,216@C1,C2,C3,C4,C5,O5 #1.$i:6,5,4,3,2@C1,C2,C3,C4,C5,O5" >> shape_rmsd.com
	i=$(( $i + 1 ))
done

/Applications/Chimera.app/Contents/MacOS/chimera --nogui shape_rmsd.com > shape_rmsd_chimera 

grep RMSD shape_rmsd_chimera | cut -d" " -f7 > shape_rmsd.txt  && rm shape_rmsd_chimera
