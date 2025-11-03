#!/bin/bash

# Constants
GREEN="\033[0;32m"
RED="\033[0;31m"
NC="\033[0m"
THRESHOLD=80

echo "Starting battery check..."

# AppleSmartBattery as XML
BATTERY_XML=$(ioreg -rc AppleSmartBattery -a)

# Extract numbers using plutil
DesignCapacity=$(echo "$BATTERY_XML" | plutil -extract 0.DesignCapacity raw -)

AppleRawMaxCapacity=$(echo "$BATTERY_XML" | plutil -extract 0.AppleRawMaxCapacity raw -)

# Calculate health percentage as int
health=$(awk "BEGIN { printf \"%.2f\", ($AppleRawMaxCapacity / $DesignCapacity) * 100 }")
health_int=${health%.*}

# Compare and print with color
if (( health_int < THRESHOLD )); then
  echo -e "Battery Health: ${RED}${health}%${NC}"
else
  echo -e "Battery Health: ${GREEN}${health}%${NC}"
fi
