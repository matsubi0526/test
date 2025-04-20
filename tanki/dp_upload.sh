#!/bin/bash
# 2023-02-05
# created by MATSUBA Fumitaka
set -ex

echo "$(date)"

GITDIR=/home/matsuba/git
DROPBOX_UPLOAD_SH=${GITDIR}/Dropbox-Uploader/dropbox_uploader.sh

ROOTDIR=$(cd $(dirname $0) && pwd)
cd ${ROOTDIR}

PDFLIST=($(find ./ -mtime -3 -name "*.pdf" | gawk -F/ '{print $NF}'))
for PDF in "${PDFLIST[@]}"; do
    if [ x"${PDF}" == x"kaisetsu_tanki_latest.pdf" ]; then
        ${DROPBOX_UPLOAD_SH} upload ${PDF} ${PDF}
    else
        ${DROPBOX_UPLOAD_SH} -s upload ${PDF} ${PDF}
    fi
done
exit
