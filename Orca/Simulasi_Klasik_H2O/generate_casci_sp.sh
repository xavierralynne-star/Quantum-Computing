#!/bin/bash
# generate_casci_sp.sh
# Membuat 16 input CASCI SP (2-step: HF -> CASCI dengan MOREAD NoIter)
# dari geometri hasil relaxed scan CASSCF

for i in $(seq -f "%03g" 1 22); do

    XYZFILE="H2O_CASSCF.${i}.xyz"

    if [ ! -f "$XYZFILE" ]; then
        echo "File $XYZFILE tidak ditemukan, skip."
        continue
    fi

    # Ambil 3 baris koordinat saja (skip 2 baris header: jumlah atom & komentar)
    GEOM=$(tail -n +3 "$XYZFILE")

    # Tulis input 2-step: HF lalu CASCI (MOREAD NoIter)
    cat > H2O_CASCI_SP.${i}.inp << EOF
! HF STO-3G
* xyz 0 1
${GEOM}
*

\$new_job
! CASSCF STO-3G MOREAD NoIter
%moinp "H2O_CASCI_SP.${i}.gbw"
%casscf
  nel  8
  norb 6
end
* xyz 0 1
${GEOM}
*
EOF

    echo "Titik $i selesai -> H2O_CASCI_SP.${i}.inp"
done

echo "Semua input CASCI SP (2-step) siap dibuat!"