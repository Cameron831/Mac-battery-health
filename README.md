# macOS Battery Health Check
A shell script to calculate the battery health of Mac laptops

![screenshot](/screenshot.png)

## Overview
This project automates battery health checks on macOS using native operating system tools. The goal was to reduce manual steps, speed up validation, and make the process more consistent.

Instead of manually running commands, locating values, and calculating battery health by hand, the script extracts the required battery capacity data, calculates the percentage automatically, and returns a clean result.

## Goals
Battery validation was a repetitive step in a larger provisioning workflow. The manual process worked, but it required multiple steps, and unnecessary time on each device.

I built this script to:
- reduce the number of manual steps
- improve consistency of battery checks
- speed up per-device validation
- lower the chance of bad batteries being missed

## Implementation 
The shell script uses `ioreg` to read `AppleSmartBattery` data in XML format, then uses `plutil` to directly extract the battery capacity fields needed for the calculation.

Core techniques used:
- `ioreg -rc AppleSmartBattery -a` to retrieve battery data as XML
- `plutil -extract ... raw -` to pull exact battery fields cleanly
- `awk` for percentage calculation and formatting
- shell integer comparison for pass/fail threshold logic
- ANSI color codes for readable terminal output

## Results
This project showed how small workflow improvements can create meaningful operational gains when applied repeatedly.

Key takeaways:
- Reduced the process from **4 steps to 2**
- Improved single-device check time from **35 seconds to 10 seconds**
- Improved 8-device batch check time from **120 seconds to 10 seconds**
- improved reliability by standardizing the check
- demonstrated practical scripting value in a real workflow

## Try it yourself
As with any remote script, inspect it before running if you want to verify exactly what it does.

Run the script directly:
```bash 
curl -fsSL https://mbc.cameronharris.dev | bash 
```

## Takeaway
In this project I learned:
- How to parse raw command output into usable structured data
- How to use shell tools effectively
- How to evaluate automation by measuring step count and timing
- How to identify high-frequency manual work that is worth automating
