#!/bin/bash
# generate_casci_ch4_fixed_R2.sh
# CASCI membaca orbital LANGSUNG dari hasil CASSCF Range 2 (CH4_CASSCF.${i}.gbw)
# Seri CH4_CASSCF = rigid scan 16 titik, R = 3.00-5.80 Angstrom
# Active space: CAS(4,4) -- konsisten dengan VQE

# 16 titik dari R=3.00 sampai R=5.80 Angstrom
R_VALUES=(3.00 3.1867 3.3733 3.5600 3.7467 3.9333 4.1200 4.3067 4.4933 4.6800 4.8667 5.0533 5.2400 5.4267 5.6133 5.80)

for idx in $(seq 0 15); do
    i=$(printf "%03d" $((idx + 1)))
    R=${R_VALUES[$idx]}
    GBWFILE="CH4_CASSCF.${i}.gbw"

    if [ ! -f "$GBWFILE" ]; then
        echo "File $GBWFILE tidak ditemukan, skip titik $i."
        continue
    fi

    cat > CH4_CASCI_fixed_R2.${i}.inp << EOF
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

    echo "Titik $i (R=${R} A) selesai -> CH4_CASCI_fixed_R2.${i}.inp"
done

echo "Semua 16 input CASCI fixed CH4 Range 2 siap!"