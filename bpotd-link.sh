echo "https://www.bing.com$(/usr/lib/wackyblackie/bpotd/curl.sh)" | xargs -n1 curl -o "/usr/lib/wackyblackie/bpotd/images/$(date +%F).jpg"

PIC=/usr/lib/wackyblackie/bpotd/$(date +%F).jpg

gsettings set org.gnome.desktop.background picture-options 'centered'
gsettings set org.gnome.desktop.background picture-uri "file://${PIC}"


