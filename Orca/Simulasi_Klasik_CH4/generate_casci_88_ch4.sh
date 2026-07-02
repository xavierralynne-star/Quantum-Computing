#!/bin/bash
# generate_casci_ch4.sh
# Membuat 21 input "CASCI" (2-step: HF -> CASSCF dengan MOREAD NoIter) untuk CH4
# dari geometri hasil relaxed scan CASSCF CAS(8,8)
#
# CATATAN: Pendekatan MOREAD NoIter ini SECARA EFEKTIF = CASSCF
# (orbital HF tetap dioptimasi ulang oleh CASSCF, NoIter tidak membekukan orbital).
# Untuk CH4 dengan CAS(8,8) = full valence, CASCI vs CASSCF diperkirakan TRIVIAL
# (hampir identik), sama seperti temuan pada H2O CAS(8,6).

for i in $(seq -f "%03g" 1 21); do

    XYZFILE="CH4_CASSCF_88.${i}.xyz"

    if [ ! -f "$XYZFILE" ]; then
        echo "File $XYZFILE tidak ditemukan, skip."
        continue
    fi

    # Ambil 5 baris koordinat saja (skip 2 baris header: jumlah atom & komentar)
    GEOM=$(tail -n +3 "$XYZFILE")

    # Tulis input 2-step: HF lalu CASSCF (MOREAD NoIter), CAS(8,8)
    cat > CH4_CASCI_SP.${i}.inp << EOF
! HF STO-3G
* xyz 0 1
${GEOM}
*

\$new_job
! CASSCF STO-3G MOREAD NoIter
%moinp "CH4_CASCI_SP.${i}.gbw"
%casscf
  nel  8
  norb 8
end
* xyz 0 1
${GEOM}
*
EOF

    echo "Titik $i selesai -> CH4_CASCI_SP.${i}.inp"
done

echo "Semua 21 input siap dibuat!"