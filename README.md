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
include files from "klipper_config_addons", e.g.:
```
[include klipper_config_km_addons/flexplate.cfg]
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

## Available single extra macros
GENERATE_BELTS_TENSION_GRAPH - create graph usefull(?) for belt equal belts tensioning
ZIGZAG - helper for moving axis back and forth (action, the "A" parameter, can be "start" (starts moving until ZIGZAG A=stop is called) or "once" which makes move only once)
