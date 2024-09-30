#!/bin/bash

domain=$1
auth_ns=$(dig NS $domain +short | head -1)

# Check if the dig command failed or if the output is empty
if [ -z "$auth_ns" ]; then
    echo "Error: No NS records for [ $domain ] could be determined."
    exit 1
fi

echo -e "\nNameserver queried: $auth_ns \n"
dig @${auth_ns} ${domain} any +noall +answer +timeout=5 +tries=3 +tcp +noquestion +noqr +nomultiline +nokeepalive +noidentify +nofail +noexpire +noadditional +noauthority +nocomments |sort -t$'\t' -k4

echo -e "\n"
