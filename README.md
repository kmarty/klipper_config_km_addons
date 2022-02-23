# My klipper_config mods/addons
It is mainly adapted for RatOS which I use with Vcore3.

## Setup
### 1. Download and install
SSH into the RPi and run the following commands:
```
cd ~/klipper_config
git clone https://github.com/kmarty/klipper_config_km_addons.git km_addons
```
### 2. Include files in you printer.cfg
After lines:
```
#############################################################################################################
### USER OVERRIDES
### Anything custom you want to add, or RatOS configuration you want to override, do it here.
#############################################################################################################
```
include files from "km_addons", e.g.:
```
[include klipper_config/km_addons/flexplate.cfg]
[include klipper_config/km_addons/ZIGZAG.cfg]
```
### 3. Update Moonraker for easy updating
From Fluidd/Mainsail, edit moonraker.conf (in the same folder as your printer.cfg file) and add:
```
[update_manager KM_addons]
type: git_repo
path: ~/klipper_config/km_addons
origin: https://github.com/kmarty/klipper_config_km_addons.git
is_system_service: False
```

## flexplate.cfg ##
Management of print plates and their z-offset. Detailed description is at the beginning of the file.

## Available single extra macros
- GENERATE_BELTS_TENSION_GRAPH - create graph usefull(?) for belt equal belts tensioning
- ZIGZAG - helper for moving axis back and forth (action, the "A" parameter, can be "start" (starts moving until ZIGZAG A=stop is called) or "once" which makes move only once)
- PA_CALIBRATE - prints PA calibration pattern. Depends on START_PRINT, END_PRINT macros and firmware retractions. If flexplate.cfg is used, it will be used here as well. Numerous predefined values can be altered using parameters (details at the beginning of the file)
