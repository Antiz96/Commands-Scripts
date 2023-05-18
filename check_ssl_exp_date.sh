#!/bin/bash

dir=/opt/ssl

function check_expiration() {
        date_exp=$(openssl x509 -enddate -noout -in "${1}" | cut -f2 -d "=" | awk '{print $1,$2,$4}')
        diff_date=$(( ("$(date -d "${date_exp}" +%s)"-"$(date +%s)")/86400 ))
}

for i in "${dir}"/*.{crt,cer,pem}
do
        [ -e "${i}" ] || break
        check_expiration "${i}"

        if [ "${diff_date}" -le 30 ]; then
                echo "SSL cert \"${i}\" expires in ${diff_date} days"
        fi
done
