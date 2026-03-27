#!/bin/bash

# Constants
GREEN="\033[0;32m"
RED="\033[0;31m"
NC="\033[0m"
THRESHOLD=80

echo "Starting battery check..."
echo

# AppleSmartBattery as XML
BATTERY_XML=$(ioreg -rc AppleSmartBattery -a)

# Extract numbers using plutil
DesignCapacity=$(echo "$BATTERY_XML" | plutil -extract 0.DesignCapacity raw -)
AppleRawMaxCapacity=$(echo "$BATTERY_XML" | plutil -extract 0.AppleRawMaxCapacity raw -)

printf "%-22s %s mAh\n" "Design Capacity:" "$DesignCapacity"
printf "%-22s %s mAh\n" "Current Max Capacity:" "$AppleRawMaxCapacity"

# Calculate health percentage as int
health=$(awk "BEGIN { printf \"%.2f\", ($AppleRawMaxCapacity / $DesignCapacity) * 100 }")
health_int=${health%.*}

printf "%-22s %s%%\n" "Battery Health:" "$health"

# Compare and print with color
if (( health_int < THRESHOLD )); then
  printf "%-22s ${RED}%s${NC}\n" "Status:" "FAIL"
else
  printf "%-22s ${GREEN}%s${NC}\n" "Status:" "PASS"
fi
echo