#!/bin/bash

ENABLED=$(nmcli -g WIFI g)
CONNECTED=$(nmcli -g STATE g)
SSID=$(nmcli -g ACTIVE,SSID d wifi | grep "^yes" | cut -d':' -f2)
NETWORKS=$(nmcli -g SSID,SECURITY d wifi)
NUM_OF_NETWORKS=$(nmcli -g SSID,SECURITY d wifi | wc -l)

NETWORK_LIST=""

for i in $(seq 1 $NUM_OF_NETWORKS); do
  NETWORK=$(echo "$NETWORKS" |awk "NR==$i")
  NETWORK=${NETWORK/:/" "}
  SSID_NETWORK=$(echo "$NETWORK" | awk '{ print $1; }')
  SECURITY=$(echo "$NETWORK" | awk '{ print $2; }')
  if [[ $SECURITY == *"WPA"*  ]] || [[ $SECURITY == *"WEP"* ]]; then
    SECURITY="true"
  else
    SECURITY="false"
  fi
  if [[ $i -eq 1 ]]; then
    NETWORK_LIST="{ \"ssid\": \"$SSID_NETWORK\", \"password_required\": \"$SECURITY\" }"
  else
    NETWORK_LIST="$NETWORK_LIST, { \"ssid\": \"$SSID_NETWORK\", \"password_required\": \"$SECURITY\" }"
  fi
done

case $ENABLED in
  "enabled")
    ENABLED="true"
    ;;
  "disabled")
    ENABLED="false"
    ;;
esac

case $CONNECTED in
  "connected")
    CONNECTED="true"
    ;;
  "disconnected")
    CONNECTED="false"
    ;;
esac

echo "{ \"networks\": [$NETWORK_LIST], \"connected\": $CONNECTED, \"ssid\": \"$SSID\", \"enabled\": $ENABLED }"
