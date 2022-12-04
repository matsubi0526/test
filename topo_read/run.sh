#!/bin/bash
# 2022-12-04
# created by MATSUBA Fumitaka
set -ex
ROOTDIR=$(cd $(dirname $0) && pwd)
FC=gfortran
RUBY=ruby
IWS=2

PGM=${ROOTDIR:?}/main.exe
${FC} -o ${PGM} step1_read.f90

for MDL in MSM LFM; do
    case ${MDL} in
        "MSM")
            NX=481
            NY=505
            FNAME=TOPO.MSM_5K;;
        "LFM")
            NX=1201
            NY=1261
            FNAME=TOPO.LFM_2K;;
    esac
    cat <<EOF > namelist.txt
&NAMPAR 
NX=${NX}, NY=${NY}, FNAME="${FNAME}"
&END        
EOF
    
    ### --- step 1 --- ###
    ${PGM} < namelist.txt
    
    ### --- step2 --- ###
    ${RUBY} step2_read_and_draw.rb ${IWS} ${FNAME}
    
    if [ ${IWS} -eq 2 ]; then
        mv dcl.pdf ${FNAME}.pdf
    fi
done
if [ -f ${PGM} ]; then
    rm ${PGM}
fi
exit
