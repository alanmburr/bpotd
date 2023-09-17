echo "https://www.bing.com$(/usr/lib/alanmburr/bpotd/curl.sh)" | xargs -n1 curl -o "/usr/lib/alanmburr/bpotd/images/$(date +%F).jpg"

PIC=/usr/lib/alanmburr/bpotd/$(date +%F).jpg

gsettings set org.gnome.desktop.background picture-options 'centered'
gsettings set org.gnome.desktop.background picture-uri "file://${PIC}"


