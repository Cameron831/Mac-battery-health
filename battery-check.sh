#!/bin/bash

# Constants
GREEN="\033[0;32m"
RED="\033[0;31m"
NC="\033[0m"
THRESHOLD=80

echo -e "Starting battery check...\n"

# AppleSmartBattery as XML
BATTERY_XML=$(ioreg -rc AppleSmartBattery -a)

# Extract numbers using plutil
DesignCapacity=$(echo "$BATTERY_XML" | plutil -extract 0.DesignCapacity raw -)
AppleRawMaxCapacity=$(echo "$BATTERY_XML" | plutil -extract 0.AppleRawMaxCapacity raw -)

echo "Design Capacity:      ${DesignCapacity} mAh"
echo "Current Max Capacity: ${AppleRawMaxCapacity} mAh"

# Calculate health percentage as int
health=$(awk "BEGIN { printf \"%.2f\", ($AppleRawMaxCapacity / $DesignCapacity) * 100 }")
health_int=${health%.*}

echo "Battery Health:       ${health}%"

# Compare and print with color
if (( health_int < THRESHOLD )); then
  echo -e "Status:              ${RED}FAIL${NC}\n"
else
  echo -e "Status:              ${GREEN}PASS${NC}\n"
fi
