#!/bin/bash

# Daftar nilai R sesuai urutan scan CASSCF
R_VALUES=(0.20 0.40 0.60 0.70 0.80 0.85 0.90 0.94 0.96 0.98 1.00 1.05 1.10 1.20 1.40 1.50 1.70 1.80 1.90 2.00 2.20 2.50)

for i in $(seq -w 1 22); do
    xyzfile="H2O_CASSCF.0${i}.xyz"
    inpfile="H2O_FCI_SP_${i}.inp"
    
    # Ambil 3 baris koordinat atom (skip 2 baris header)
    coords=$(tail -n +3 "$xyzfile")
    
    cat > "$inpfile" << EOF
! CASSCF STO-3G SP
%pal
  nprocs 4
end

%casscf
  nel  10
  norb  7
end

* xyz 0 1
$coords
*
EOF
done

echo "Selesai membuat 22 file input FCI SP!"