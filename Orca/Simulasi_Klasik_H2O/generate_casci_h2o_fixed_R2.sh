#!/bin/bash
# generate_casci_h2o_fixed_R2.sh
# CASCI membaca orbital LANGSUNG dari hasil CASSCF Range 2 (H2O_CASSCF.${i}.gbw)
# Seri H2O_CASSCF.001-016 = rigid scan 16 titik, R = 3.00-5.80 Angstrom, CAS(4,4)
# Active space: CAS(4,4) -- konsisten dengan VQE

# 16 titik dari R=3.00 sampai R=5.80 Angstrom
R_VALUES=(3.00 3.1867 3.3733 3.5600 3.7467 3.9333 4.1200 4.3067 4.4933 4.6800 4.8667 5.0533 5.2400 5.4267 5.6133 5.80)

for idx in $(seq 0 15); do
    i=$(printf "%03d" $((idx + 1)))
    R=${R_VALUES[$idx]}
    GBWFILE="H2O_CASSCF.${i}.gbw"

    if [ ! -f "$GBWFILE" ]; then
        echo "File $GBWFILE tidak ditemukan, skip titik $i."
        continue
    fi

    cat > H2O_CASCI_fixed_R2.${i}.inp << EOF
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

    echo "Titik $i (R=${R} A) selesai -> H2O_CASCI_fixed_R2.${i}.inp"
done

echo "Semua 16 input CASCI fixed H2O Range 2 siap!"