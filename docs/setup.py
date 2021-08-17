#!/usr/bin/env python3
import os, requests, datetime, sys, stat
try:
    import gi
except:
    print("\033[1;91mE\033[1;97m: Please do not execute this program on Windows. Error code: %s" % sys.exc_info()[0])
    print("\033[1;91mE\033[1;97m: Por favor, no ejecute este programa en Windows. C\u00F3digo de error: %s" % sys.exc_info()[0])
    exit(127)

gi.require_version('Gtk', '3.0')
from gi.repository import Gtk

class Window(Gtk.Window):
    def __init__(self):
        Gtk.Window.__init__(self, title="Install bpotd")
        if not os.path.join("/tmp/", "bpotd.install.ico"):
            icon = requests.get("https://wackyblackie.github.io/bpotd/favicon.ico")
            with open(os.path.join("/tmp/", "bpotd.install.ico"), 'wb') as f:
                f.write(icon.content)
        Gtk.Window.set_default_icon_from_file(os.path.join("/tmp/", "bpotd.install.ico"))
		
        self.set_size_request(300, 100)
        grid = Gtk.Grid()
        grid.expand = False
        self.add(grid)

        label = Gtk.Label(label="Watch the output in terminal.")
        label.set_line_wrap(True)
        label.set_justify(Gtk.Justification.CENTER)
        label.set_max_width_chars(74)
        label.set_margin_start(6)
        label.set_margin_end(6)

        close = Gtk.Button.new_with_mnemonic("_Close")
        close.connect("clicked", Gtk.main_quit)

        begin = Gtk.Button.new_with_mnemonic("_Install")
        begin.connect("clicked", self.actions, self)

        btngrid = Gtk.Box(expand=False)
        btngrid.homogenous = False
        btngrid.expand = True

        grid.attach(label, 0, 0, 1, 1)
        grid.attach(btngrid, 0, 1, 1, 1)
        btngrid.pack_start(begin, True, True, 0)
        btngrid.pack_start(close, True, True, 0)

    def actions(self, button, lbl):
        print()
        print(
            '\033[38;5;4m%s\033[0m' % datetime.datetime.now(),
            ": Installing rev. 0.0.1-08172021ubuntu-1\n",
            "Trying to create dir:", sep='')
        try:
            os.mkdir(os.path.join("/usr/lib/wackyblackie/")) if not os.path.exists(os.path.join("/usr/lib/wackyblackie/")) else print("\033[1;94m\tI:\033[0m dir exists")
            os.mkdir(os.path.join("/usr/lib/wackyblackie/bpotd/")) if not os.path.exists(os.path.join("/usr/lib/wackyblackie/bpotd/")) else print("\033[1;94m\tI:\033[0m dir exists")
            os.mkdir(os.path.join("/etc/xdg/autostart/")) if not os.path.exists(os.path.join("/etc/xdg/autostart/")) else print("\033[1;94m\tI:\033[0m dir exists")
            print("\tSucceeded.")
        except: 
            print("\t\033[1;91mE\033[1;97m: %s" % sys.exc_info()[0])
            exit(1)

        print("Trying to download script: \033[4mbpotd\033[0m from remote: \033[4m%s\033[0m" % 'https://raw.githubusercontent.com/wackyblackie/bpotd/master/dist/bpotd')
        try:
            with open(os.path.join("/usr/lib/wackyblackie/bpotd/", "bpotd"), 'wb') as fa:
                fa.write(requests.get("https://raw.githubusercontent.com/wackyblackie/bpotd/master/dist/bpotd").content+b"\n")
            os.system("/usr/bin/chmod 0755 %s" % os.path.join("/usr/lib/wackyblackie/bpotd/", "bpotd"))
            print("\tSucceeded.")
        except:
            print("\t\033[1;91mE\033[1;97m: %s\033[0m" % sys.exc_info()[0])
            exit(1)

        print("Trying to download script: \033[4mtray\033[0m from remote: \033[4m%s\033[0m" % 'https://raw.githubusercontent.com/wackyblackie/bpotd/master/dist/tray')
        try:
            with open(os.path.join("/usr/lib/wackyblackie/bpotd/", "tray"), 'wb') as fb:
                fb.write(requests.get("https://raw.githubusercontent.com/wackyblackie/bpotd/master/dist/tray").content+b"\n")
            os.system("/usr/bin/chmod 0755 %s" % os.path.join("/usr/lib/wackyblackie/bpotd/", "tray"))
            print("\tSucceeded.")
        except:
            print("\t\033[1;91mE\033[1;97m: %s\033[0m" % sys.exc_info()[0])
            exit(1)

        print("Trying to create symlinks.")
        try:
            os.symlink(os.path.join("/usr/lib/wackyblackie/bpotd/bpotd"), os.path.join("/usr/bin/bpotd")); print("\tSuccess. Link created: \033[4m/usr/lib/wackyblackie/bpotd/tray\033[0m \u2192 \033[4m/usr/bin/bpotd-tray\033[0m") if not os.path.exists(os.path.join("/usr/bin/bpotd")) else print("\t\033[1;94mI:\033[0m Symlink \033[4m/usr/bin/bpotd\033[0m already exists.")
            os.symlink(os.path.join("/usr/lib/wackyblackie/bpotd/tray"), os.path.join("/usr/bin/bpotd-tray")); print("\tSuccess. Link created: \033[4m/usr/lib/wackyblackie/bpotd/bpotd\033[0m \u2192 \033[4m/usr/bin/bpotd\033[0m") if not os.path.exists(os.path.join("/usr/bin/bpotd")) else print("\t\033[1;94mI:\033[0m Symlink \033[4m/usr/bin/bpotd-tray\033[0m already exists.")
        except:
            print("\t\033[1;91mE\033[1;97m: %s\033[0m" % sys.exc_info()[0])
            exit(1)

        print("Trying to create \033[4m.desktop\033[0m files.")
        try:
            with open(os.path.join("/usr/share/applications", "bpotd-tray.desktop"), 'w') as fc:
                fc.write("[Desktop Entry]\nType=Application\nName=bpotd Tray\nExec=/usr/bin/bpotd-tray\nIcon=/usr/lib/wackyblackie/bpotd/icon.ico\nX-GNOME-Autostart-enabled=true")
            with open(os.path.join("/etc/xdg/autostart/", "bpotd.desktop"), 'w') as fd:
                fd.write("[Desktop Entry]\nType=Application\nName=bpotd Tray\nExec=/usr/bin/bpotd-tray\nIcon=/usr/lib/wackyblackie/bpotd/icon.ico\nX-GNOME-Autostart-enabled=true")
            with open(os.path.join("/usr/share/applications", "bpotd.desktop"), 'w') as fe:
                fe.write("[Desktop Entry]\nType=Application\nName=bpotd\nExec=/usr/bin/bpotd\nIcon=/usr/lib/wackyblackie/bpotd/icon.ico\nX-GNOME-Autostart-enabled=false")
        except:
            print("\t\033[1;91mE\033[1;97m: %s\033[0m" % sys.exc_info()[0])
            exit(1)

        Gtk.main_quit()
        
        
        
        

window = Window()
window.connect("destroy", Gtk.main_quit)
window.show_all()
Gtk.main()
