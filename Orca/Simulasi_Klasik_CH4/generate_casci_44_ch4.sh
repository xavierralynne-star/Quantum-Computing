#!/bin/bash
# generate_casci_44_ch4.sh
# Membuat 21 input "CASCI" (2-step: HF -> CASSCF dengan MOREAD NoIter) untuk CH4
# dari geometri hasil relaxed scan CASSCF CAS(4,4) (versi AWAL, sebelum diganti ke 8,8)
#
# CATATAN: Sama seperti versi (8,8), pendekatan MOREAD NoIter ini SECARA EFEKTIF
# = CASSCF (orbital HF tetap dioptimasi ulang, NoIter tidak membekukan orbital).
# Tapi karena CAS(4,4) BUKAN full valence (ada 4 orbital valence lain yang inactive),
# CASCI vs CASSCF di sini DIPERKIRAKAN beda lebih nyata dibanding (8,8).

for i in $(seq -f "%03g" 1 21); do

    XYZFILE="CH4_CASSCF.${i}.xyz"

    if [ ! -f "$XYZFILE" ]; then
        echo "File $XYZFILE tidak ditemukan, skip."
        continue
    fi

    # Ambil 5 baris koordinat saja (skip 2 baris header: jumlah atom & komentar)
    GEOM=$(tail -n +3 "$XYZFILE")

    # Tulis input 2-step: HF lalu CASSCF (MOREAD NoIter), CAS(4,4)
    cat > CH4_CASCI_44_SP.${i}.inp << EOF
! HF STO-3G
* xyz 0 1
${GEOM}
*

\$new_job
! CASSCF STO-3G MOREAD NoIter
%moinp "CH4_CASCI_44_SP.${i}.gbw"
%casscf
  nel  4
  norb 4
end
* xyz 0 1
${GEOM}
*
EOF

    echo "Titik $i selesai -> CH4_CASCI_44_SP.${i}.inp"
done

echo "Semua 21 input CASCI (4,4) siap dibuat!"