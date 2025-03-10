#!/bin/bash
# 2022-04-11
# created by MATSUBA Fumitaka
# 2025-03-09 Last-revised
set -ex

URL="https://www.data.jma.go.jp/yoho/data/jishin/kaisetsu_tanki_latest.pdf"
FILE="kaisetsu_tanki_latest"
FILE1=${FILE:?}_tmp.pdf  # latest
FILE2=${FILE:?}.pdf      # old

# read environmental variables for crontab
source /home/matsuba/.bashrc

### CHANGE DIRECTORY
cd ${HOME:?}/git/test/tanki

### DOWNLOAD LATEST FILE ###
wget -O ${FILE1:?} ${URL:?}

### DO LOOP ###
for ii in `seq -w 1 10`; do
    echo "TRY: TAKE ${ii:?}"
    ### CHECK TIMESTAMP ###
    if [ -f ${FILE2:?} ]; then
        if [ ${FILE1:?} -nt ${FILE2:?} ]; then
            TIMESTAMP=`date +"%Y%m%d%H%M" -r ${FILE2:?}`
            mv ${FILE2:?} ${TIMESTAMP:?}.pdf
            mv ${FILE1:?} ${FILE2:?}
            break
        else
            ### DOWNLOAD LATEST FILE ###
            wget -O ${FILE1:?} ${URL:?}
            sleep 300
        fi
    else
        break
    fi
done
exit 0
