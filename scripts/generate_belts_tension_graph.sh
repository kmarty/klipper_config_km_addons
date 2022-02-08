#!/bin/bash

NEWL=$(ls -Art /tmp/raw_data_axis=1.000,1.000_*.csv | tail -n 1)
NEWR=$(ls -Art /tmp/raw_data_axis=1.000,-1.000_*.csv | tail -n 1)
DATE=$(date +'%Y-%m-%d-%H%M%S')
DEST_DIR="/home/pi/klipper_config/input_shaper"

test -d "${DEST_DIR}" || (mkdir "${DEST_DIR}" ; chown pi:pi "${DEST_DIR}")

# If you can, always adjust by small (1/8 to 1/4 turn) increments, 
# adjust both belts, one tighter and one looser, 
# and always at least home after each adjust to even out tensions.
#
# The ideal tightness often sits between 2 and 2.5
# however this can be effected by the size of your printer,
# the squareness of the frame, the equal length requirements of the belts etc etc
#
#
# you have to imagine if you over adjust one belt, 
# even if you hit equal tension you might have skewed your frame,
# for several possible reasons, most likely of which is not exact
# number of teeth engaged on each end plus they do stretch a wee bit at this tightness

# Top belt (left motor is buzzing)
ln -sf "${NEWL}" "/tmp/data_axis=1,1_(top_belt)_${DATE}.csv"
# Bottom belt (right motor is buzzing)
ln -sf "${NEWR}" "/tmp/data_axis=1,-1_(bottom_belt)_${DATE}.csv"

~/klipper/scripts/graph_accelerometer.py -c "/tmp/data_axis=1,1_(top_belt)_${DATE}.csv" "/tmp/data_axis=1,-1_(bottom_belt)_${DATE}.csv" -o "${DEST_DIR}/belts_tension_${DATE}.png"
