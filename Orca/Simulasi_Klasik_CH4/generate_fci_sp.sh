#!/bin/bash

for i in $(seq -w 1 21); do
    xyzfile="CH4_CASSCF_88.0${i}.xyz"
    inpfile="CH4_FCI_88_SP_${i}.inp"
    
    coords=$(tail -n +3 "$xyzfile")
    
    cat > "$inpfile" << EOF
! CASSCF STO-3G SP
%pal
  nprocs 4
end

%casscf
  nel  10
  norb  9
end

* xyz 0 1
$coords
*
EOF
done

echo "Selesai membuat 21 file input FCI SP untuk CH4!"