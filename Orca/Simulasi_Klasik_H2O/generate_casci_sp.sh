#!/bin/bash
# generate_casci_sp_fixed.sh
# Geometri digenerate langsung dari nilai R (tidak butuh file .xyz)
# Orbital dibaca dari H2O_CASSCF_1.${i}.gbw (CASSCF yang sudah konvergen)
# Active space: CAS(4,4) -- konsisten dengan VQE

# 16 titik dari R=0.50 sampai R=3.00 Angstrom
R_VALUES=(0.50 0.6667 0.8333 1.00 1.1667 1.3333 1.50 1.6667 1.8333 2.00 2.1667 2.3333 2.50 2.6667 2.8333 3.00)

for idx in $(seq 0 15); do
    i=$(printf "%03d" $((idx + 1)))
    R=${R_VALUES[$idx]}
    GBWFILE="H2O_CASSCF_1.${i}.gbw"

    if [ ! -f "$GBWFILE" ]; then
        echo "File $GBWFILE tidak ditemukan, skip titik $i."
        continue
    fi

    cat > H2O_CASCI_fixed.${i}.inp << EOF
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
O   0.000000   0.000000   0.000000
H   0.000000   0.000000   ${R}
H  -0.860362   0.209382   0.393570
*
EOF

    echo "Titik $i (R=${R} A) selesai -> H2O_CASCI_fixed.${i}.inp"
done

echo "Semua 16 input CASCI fixed siap!"