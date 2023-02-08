#!/bin/bash
#sym link test

# Terminate already running bar instances
killall -q polybar

#int=$(iwgetid | getn 1)
int=$(iwgetid)
echo ${int}

sed -i "s/interface = .*/interface = \"$int\"/g" ~/.config/polybar/config.ini

polybar white &

echo "Bars launched..."
