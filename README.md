# My klipper_config mods/addons

## Setup
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
