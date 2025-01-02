#!/bin/bash

POWERED=$(bluetoothctl show | grep "Powered" | awk '{ print $2; }')
CONNECTED=$(bluetoothctl info | grep "Connected" | awk '{ print $2; }')
NAME=$(bluetoothctl info | grep "Name" | awk '{ print $2; }')

echo "{ \"powered\": \"$POWERED\", \"connected\": \"$CONNECTED\", \"name\": \"$NAME\" }"
