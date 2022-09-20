#!/usr/bin/env bash

DIR=/opt/ssl

function check_expiration() {
        DATE_EXP=$(openssl x509 -enddate -noout -in "${1}" | cut -f2 -d "=" | awk '{print $1,$2,$4}')
        DIFF_DATE=$(( ("$(date -d "${DATE_EXP}" +%s)"-"$(date +%s)")/86400 ))
}

for i in "${DIR}"/*.{crt,cer,pem}
do
        [ -e "${i}" ] || break
        check_expiration "${i}"

        if [ "${DIFF_DATE}" -le 30 ]; then
                echo "SSL cert \"${i}\" expires in ${DIFF_DATE} days"
        fi
done