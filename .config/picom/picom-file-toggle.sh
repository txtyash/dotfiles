#!/bin/bash
 
# Turn on picom if inactive
if ! pgrep -x "picom" > /dev/null; then
    `picom --experimental-backend -b --config ~/.config/picom/picom.conf`
fi

# Toggles opacity
if grep -Ewq 'transparent' "/tmp/picom.txt"; then
    cp "/home/zim/.config/picom/picom.opaq.conf" "/home/zim/.config/picom/picom.conf"
    printf '%s' "opaque" > "/tmp/picom.txt"
else
    cp "/home/zim/.config/picom/picom.trans.conf" "/home/zim/.config/picom/picom.conf"
    printf '%s' "transparent" > "/tmp/picom.txt"
fi
