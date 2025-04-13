#!/bin/bash

domain="$1"

if [[ -z "$domain" ]]; then
  echo "Usage: $0 domain.com"
  exit 1
fi

# Ensure jq is installed
if ! command -v jq >/dev/null; then
  echo "Error: 'jq' is required but not installed."
  exit 1
fi

# Fetch RDAP data from rdap.verisign.com (works better for .com domains like google.com)
response=$(curl -s "https://rdap.verisign.com/com/v1/domain/${domain^^}")

# Extract the expiration date
expiry_date=$(echo "$response" | jq -r '.events[] | select(.eventAction == "expiration") | .eventDate')

if [[ -n "$expiry_date" && "$expiry_date" != "null" ]]; then
  expiry_timestamp=$(date -d "$expiry_date" +%s 2>/dev/null)
  if [[ -n "$expiry_timestamp" ]]; then
    days_remaining=$(( (expiry_timestamp - $(date +%s)) / 86400 ))
    echo "$days_remaining"
  else
    echo "Error: Unable to parse expiry date: $expiry_date"
  fi
else
  echo "Error: Could not find expiry date for $domain"
fi
