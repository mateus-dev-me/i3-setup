#!/bin/bash

picom -b &

feh --randomize --bg-fill ~/wallpapers/* &

nm-applet &

xautolock -time 10 -locker "i3lock -c 000000" &

systemctl --user start systemd-timesyncd.service &

xrdb -merge ~/.Xresources &
