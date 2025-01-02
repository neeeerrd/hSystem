#!/bin/bash

state=$(eww get $1)

case $state in
  true)
    eww update $1=false
    ;;
  false)
    eww update $1=true
    ;;
esac
