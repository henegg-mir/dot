#!/usr/bin/env bash

rofi -show power-menu -modi "power-menu:$1 --choices=shutdown/reboot/suspend/lockscreen/logout  --confirm=reboot/shutdown" -theme $2