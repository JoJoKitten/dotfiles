#!/bin/sh
net_device=$(ip addr | sed -n 's/.: \([^:]*\).*state UP.*/\1/p')
time_ms=$(( $(date +%s%N) / 1000000 ))
if [ "$net_device" != "" ]; then
    bytes=$(cat "/sys/class/net/$net_device/statistics/rx_bytes")
else
    net_device='-'
    bytes='-1'
fi
echo $time_ms $bytes
