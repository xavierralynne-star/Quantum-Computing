#!/bin/bash
# generate_casci_ch4_fixed.sh
# CASCI membaca orbital LANGSUNG dari hasil CASSCF_1 (CH4_CASSCF_1.${i}.gbw)
# Seri CASSCF_1 = rigid scan 16 titik, R = 0.50-3.00 Angstrom
# Active space: CAS(4,4) -- konsisten dengan VQE

# 16 titik dari R=0.50 sampai R=3.00 Angstrom
R_VALUES=(0.50 0.6667 0.8333 1.00 1.1667 1.3333 1.50 1.6667 1.8333 2.00 2.1667 2.3333 2.50 2.6667 2.8333 3.00)

for idx in $(seq 0 15); do
    i=$(printf "%03d" $((idx + 1)))
    R=${R_VALUES[$idx]}
    GBWFILE="CH4_CASSCF_1.${i}.gbw"

    if [ ! -f "$GBWFILE" ]; then
        echo "File $GBWFILE tidak ditemukan, skip titik $i."
        continue
    fi

    cat > CH4_CASCI_fixed.${i}.inp << EOF
! CASSCF STO-3G MOREAD NoIter
%moinp "${GBWFILE}"

%pal
  nprocs 4
end

%casscf
  nel     4
  norb    4
  maxiter 1
end

* xyz 0 1
C   0.000000   0.000000   0.000000
H   0.000000   0.000000   ${R}
H  -0.907297  -0.496407  -0.351129
H   0.673211   0.167304  -0.843621
H  -0.261596   0.958896   0.452753
*
EOF

    echo "Titik $i (R=${R} A) selesai -> CH4_CASCI_fixed.${i}.inp"
done

echo "Semua 16 input CASCI fixed CH4 siap!"