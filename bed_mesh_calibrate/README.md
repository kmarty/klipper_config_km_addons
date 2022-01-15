# Dynamic BED_MESH_CALIBRATE for RatOS
Klipper mesh on print area only (RatOS adaptation)

## Credit
Complete credit goes to ChipCE (https://gist.github.com/ChipCE/95fdbd3c2f3a064397f9610f915f7d02) for the idea and sample code.\
Idea to make it as repository goes to Turge08 (https://github.com/Turge08/print_area_bed_mesh).

I only remixed it to suit my needs.

### 1. Include macro in your printer.cfg
After lines:
```
### USER OVERRIDES
# Place all your overrides here
```
add the following:
```
[include km_addons/bed_mesh_calibrate/BED_MESH_CALIBRATE.cfg]
```
### 4. Modify "START_PRINT" and "_START_PRINT_BED_MESH" macros
#### 4.1 Modify "START_PRINT"
I can't guarantee the original RatOS *START_PRINT* macro won't change, therefore following doesn't have to work in the future.
- In *printer.cfg* add following line after "[include /home/pi/Dynamic_BED_MESH_CALIBRATE/BED_MESH_CALIBRATE.cfg]":
```
[include km_addons/bed_mesh_calibrate/START_PRINT.cfg]
```
The goal is to replace line:
```
  _START_PRINT_BED_MESH
```
by:
```
  {% if params.AREA_START and params.AREA_END %}
    _START_PRINT_BED_MESH AREA_START={params.AREA_START} AREA_END={params.AREA_END}
  {% else %}
    _START_PRINT_BED_MESH
  {% endif %}
```
in macro "START_PRINT".

#### 4.2 Modify "_START_PRINT_BED_MESH"
The very same as with *START_PRINT*, no guarantee.
- In *printer.cfg* add following line after include line with "START_PRINT.cfg":
```
[include km_addons/bed_mesh_calibrate/_START_PRINT_BED_MESH.cfg]
```
The goal is to replace line:
```
    BED_MESH_CALIBRATE PROFILE=ratos
```
by:
```
    {% if params.AREA_START and params.AREA_END %}
      BED_MESH_CALIBRATE PROFILE=ratos AREA_START={params.AREA_START} AREA_END={params.AREA_END}
    {% else %}
      BED_MESH_CALIBRATE PROFILE=ratos
    {% endif %}
```
in macro "_START_PRINT_BED_MESH".

### 5. Modify your printer's start g-code in your slicer
- PrusaSlicer/SuperSlicer:
```
START_PRINT EXTRUDER_TEMP=[first_layer_temperature] BED_TEMP=[first_layer_bed_temperature] AREA_START={first_layer_print_min[0]},{first_layer_print_min[1]} AREA_END={first_layer_print_max[0]},{first_layer_print_max[1]}
```
- Cura (add this to your start gcode at the end of the START_PRINT command):
```
PRINT_MIN=%MINX%,%MINY% PRINT_MAX=%MAXX%,%MAXY%
```
*(Cura slicer plugin) To make the macro to work in Cura slicer, you need to install the post process plugin by frankbags - In cura menu Help -> Show configuration folder. - Copy the python script from the above link in to plugins folder. - Restart Cura - In cura menu Extensions -> Post processing and select Mesh Print Size.

I don't use Cura, I can't confirm the guide works.
