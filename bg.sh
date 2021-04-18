#!/usr/bin/env bash

# Every day, this script will run at 12:00 am OR after power-on.
# It changes the background to the picture on Bing.com

# GNOME Desktop Envireoment only

PICS="$HOME/Pictures/bpotd"
RAND=$(date +%F)
CURLURI=$(curl https://www.bing.com 2>&1 | grep -oP '"og:image".{0,100}' | grep -oP 'content=".{0,}' | cut -d '"' -f2 | cut -d '&' -f1)

# download photo-of-the-day page
curl ${CURLURI} -o ${PICS}/${RAND}.jpg

# set the desktop background
URI="file://${PICS}/${RAND}.jpg"
echo ${URI}
gsettings set org.gnome.desktop.background picture-options 'centered'
gsettings set org.gnome.desktop.background picture-uri "${URI}"