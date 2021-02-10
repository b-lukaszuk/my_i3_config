#!/bin/bash
# baraction.sh script for spectrwm status bar (now for i3)

## DISK
## RAM
mem() {
  mem=`free | awk '/Mem/ {printf "%.1f%%\n", ($3 / 1024.0) / ($2 / 1024.0) * 100 }'`
  echo -e "MEM: $mem"
}
## CPU
cpu() {
  read cpu a b c previdle rest < /proc/stat
  prevtotal=$((a+b+c+previdle))
  sleep 0.5
  read cpu a b c idle rest < /proc/stat
  total=$((a+b+c+idle))
  cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
  printf "CPU: %d%%\n" $cpu
}
# siec wi-fi
wifi_con() {
  wifi=`iwgetid -r`
  echo -e "netw: $wifi"
}
# bateria
battery() {
    bat=`acpi -b | awk --field-separator=", " '{printf "%s\n", $2}'`
    echo -e "Battery: $bat"
}

# aktualna data/gdzina
actTime() {
  curTime=`date`
  echo -e "$curTime"
}

SLEEP_SEC=3
#loops forever outputting a line every SLEEP_SEC secs
# It seems that we are limited to how many characters can be displayed via
# the baraction script output. And the the markup tags count in that limit.
# So I would love to add more functions to this script but it makes the 
# echo output too long to display correctly.
while :; do
    echo "GNU/Linux Mint   i3wm   $(mem)  |  $(cpu)  |  $(wifi_con)  |  $(battery)  |  $(actTime)"
	sleep $SLEEP_SEC
done
