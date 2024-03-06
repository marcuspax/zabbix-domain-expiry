#!/bin/bash

domain="$1"

# Fetch whois information using wget
whois_data=$(wget -qO- "https://www.whois.com/whois/$domain")

# Extract expiry date using grep and awk (modify if needed)
expiry_date=$(echo "$whois_data" | grep "Registrar Registration Expiration Date" | awk -F: '{print $2}' | cut -d 'T' -f1)

if [[ -n "$expiry_date" ]]; then
  # Convert expiry date to timestamp
  expiry_timestamp=$(date -d "$expiry_date" +%s)

  # Calculate number of seconds remaining
  seconds_remaining=$((expiry_timestamp - $(date +%s)))

  # Convert seconds to days
  days_remaining=$((seconds_remaining / (60*60*24)))

  echo "$days_remaining"
else
  echo "Error: Could not find expiry date."
fi
