#!/bin/sh

# MIT License
# Copyright (c) 2019 Rasmus Meldgaard
# See LICENSE for full license

battery=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 )

state=$(echo "$battery" | grep state | awk '{print $2}')
pro=$(echo "$battery" | grep percentage | awk '{print $2}')

txtstate="Err"
if [ x$state = xfully-charged ]
then
  txtstate="Full"
fi
if [ x$state = xdischarging ]
then
  timeLeft=$(echo "$battery" | grep time | awk '{print $4 substr($5,1,1)}')
  txtstate="Unpluged: Time left: $timeLeft"
fi
if [ x$state = xcharging ]
then
  timeLeft=$(echo "$battery" | grep time | awk '{print $4 substr($5,1,1)}')
  txtstate="Charging: Full in: $timeLeft"
fi

echo "$txtstate/($pro)"
