#!/bin/bash

if [[ $1 == "password_required" ]]; then
  alacritty --class floating -e nmcli d wifi connect $2 --ask
else
  alacritty --class floating -e nmcli d wifi connect $1
fi
