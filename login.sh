#!/bin/bash

set -xe 

cookie_file="${HOME}/.gitcookie"
username=$1
password=$2

rm -rf "${cookie_file}"

headers=$(mktemp)
echo "Storing headers into ${headers}"

curl --http1.1 -f --connect-timeout 5 --retry 3 -D "${headers}" -c ${cookie_file} -b ${cookie_file} -L 'https://login.pipeline.alpha-prosoft.com' > $(mktemp)
export location=$(cat "${headers}" | sed 's/\\r//g' | grep -i "location" | head -1 | awk '{print $2}' | sed 's/\/oauth2.*//g')
export client_id=$(cat "${headers}" | sed 's/\\r//g' | grep -i  "location" | head -1 | awk '{print $2}' | sed 's/.*client_id=//g' | sed 's/&.*//g')
export redirect_uri=$(cat "${headers}" | sed 's/\\r//g' | grep -i  "location" | head -1 | awk '{print $2}' | sed 's/.*redirect_uri=//g' | sed 's/&.*//g')
export url_state=$(cat "${headers}" | sed 's/\r//g' | grep -i  "location" | head -1 | awk '{print $2"&"}' | sed 's/.*state=//g' | sed 's/&.*//g')


echo "Location: $location"
echo "Client id: $client_id"
echo "Redirect uri: $redirect_uri"
echo "State: ${url_state}"

sed -i 's/#HttpOnly_//g' ${cookie_file}

cat ${cookie_file}

XSRF_TOKEN=$(cat ${cookie_file}  | grep 'XSRF-TOKEN' | awk '{printf $7}')


final_url="${location}/login?client_id=${client_id}&redirect_uri=${redirect_uri}&response_type=code&scope=openid&state=${url_state}"

curl --http1.1 -v -f --connect-timeout 5 --retry 3  -L -c ${cookie_file} -b ${cookie_file}  ''"${final_url}"''\
     -H "referer: ${final_url}" \
     -H 'accept-language: en-US,en;q=0.9,hr;q=0.8'  \
     -H 'csrf-state=""; csrf-state-legacy=""' \
     --data-raw '_csrf='"${XSRF_TOKEN}"'&username='"${username}"'&password='"${password}"'&signInSubmitButton=Sign+in'

result=$(curl --http1.1 -f --connect-timeout 5 -L -b ${cookie_file} https://login.pipeline.alpha-prosoft.com)

sed -i 's/#HttpOnly_//g' ${cookie_file}

cat ${cookie_file}


cat ${headers}

echo "RESULT ${result}"
