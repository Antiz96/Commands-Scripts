#!/bin/bash

# This is a script I made to extract current Zabbix problems via the Zabbix API, class them by severity and parse the result to an html file to expose it via a dedicated URL.

output_file="/opt/scripts/zabbix-api/problems-severity-result.txt"
html_output_file="/opt/scripts/zabbix-api/problems-severity-result.html"

true > "$output_file"

declare -A severity_counts

mapfile -t problems_severity < <(curl --silent --insecure --request POST --url 'https://zabbix.home-infra.rc/api_jsonrpc.php' --header 'Content-Type: application/json-rpc' --data @/opt/scripts/zabbix-api/data.json | jq | grep "severity" | awk '{print $2}' | sed 's/"//g')

generate_html() {
        cat <<EOF
<!DOCTYPE html>
<html>
<body>
<p>
<font color="white">
$(cat "${output_file}")
</font>
</p>
</body>
</html>
EOF
}

if [ -z "${problems_severity[*]}" ]; then
    echo "No problem" >> "${output_file}"
else
    for num in "${problems_severity[@]}"; do
        case "${num}" in
            5) severity="Désastre" ;;
            4) severity="Haut" ;;
            3) severity="Moyen" ;;
            2) severity="Avertissement" ;;
            1) severity="Information" ;;
            0) severity="Non classé" ;;
        esac

        severity_counts["${severity}"]=$((severity_counts["${severity}"] + 1))
    done

    for severity in "${!severity_counts[@]}"; do
            count="${severity_counts["$severity"]}"
            echo "${severity}: ${count}<br>" >> "$output_file"
    done
fi

generate_html > "$html_output_file"
