PREFIX ?= /usr
MYDIR ?= $(PREFIX)/lib/wackyblackie
INSTDIR ?= $(MYDIR)/bpotd
D ?= $(DESTDIR)$(INSTDIR)

all:
	@echo "Run \`sudo make install' to install."

install:
	@mkdir -p $(DESTDIR)$(INSTDIR)
	@mkdir -p $(DESTDIR)$(INSTDIR)/images
	@mkdir -p $$HOME/.config/autostart
	@cp -rp ** $(DESTDIR)$(INSTDIR)
	@rm $(D)/Makefile
	@rm -rf $(D)/docs
	@chmod +x $(D)/bpotd $(D)/tray $(D)/curl.sh $(D)/bg.sh
	@echo 'export PATH="$(D):$$PATH"' >> $$HOME/.bashrc
	@echo -e '#!/bin/sh\n$(D)/bg.sh' >> /etc/cron.daily/zz-bpotd
	@echo -e '[Desktop Entry]\nType=Application\nName=bpotd Tray\nExec=$(D)/tray\nIcon=$(D)/icon.ico\nX-GNOME-Autostart-enabled=true' >> $$HOME/.config/autostart/bpotd-tray.desktop
	@echo -e '[Desktop Entry]\nType=Application\nName=bpotd Background Switcher\nExec=$(D)/bg.sh\nIcon=$(D)/icon.ico\nX-GNOME-Autostart-enabled=true' >> $$HOME/.config/autostart/bpotd-bg.desktop
	@chmod +x $(D)/bpotd-*.desktop
	
remove:
	@rm -rf $(D)
