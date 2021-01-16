#!/bin/bash

id=`hostname`
ESB="tara.t-l.ch"
serial=`cat /proc/device-tree/serial-number`
TS=`date "+%s"`

Sortie="{\"CPU\":\"$(awk '{print $1}' /proc/loadavg)\""
ramtot=$(grep MemTotal /proc/meminfo | awk '{print $2}')
ramfree=$(grep MemAvailable /proc/meminfo | awk '{print $2}')
Sortie="$Sortie,\"RAM\":\"$(((ramtot-ramfree)*100/ramtot))\""
disks=$(df | grep '^/dev/' | awk '{print $1}')
for d in $disks
do
    used=$(df -h | grep "^$d" | awk '{print $5}' | grep -oE '[0-9]*')
    Sortie="$Sortie,\"$d\":\"$used\""
done
temp=$(cat /sys/class/thermal/thermal_zone0/temp | cut -c-2)
Sortie="$Sortie,\"TempCore\":\"$temp\""
Sortie="$Sortie,\"Serial\":\"$serial\""
Sortie="$Sortie,\"Time\":\"$TS\""
Sortie="$Sortie}"
mosquitto_pub --quiet -r -h $ESB -t TL/BOTER/$id/sysinfo -i $id -m "$Sortie"
