#!/usr/bin/env python3
import gi, os
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, Gio

class Window(Gtk.Window):
    def __init__(self):
        Gtk.Window.__init__(self, title="Install bpotd")
        Gtk.Window.set_default_icon_from_file("/usr/share/icons/hicolor/16x16/actions/package-install.png")
		
        self.set_size_request(500, 250)
        grid = Gtk.Grid()
        grid.expand = True
        self.add(grid)

        btngrid = Gtk.Box(expand=True)
        btngrid.homogenous = True
        btngrid.expand = True

        textview = Gtk.TextView()
        textview.set_editable(False)
        textview.set_cursor_visible(False)
        textview.set_property("expand", True)

        close = Gtk.Button.new_with_mnemonic("_Close")
        close.connect("clicked", Gtk.main_quit)

        begin = Gtk.Button.new_with_mnemonic("_Install")
        begin.connect("clicked", self.actions)

        grid.attach(textview, 0, 0, 1, 1)
        grid.attach(btngrid, 0, 1, 1, 1)
        btngrid.pack_start(close, True, True, 0)
        btngrid.pack_start(begin, True, True, 0)
    def actions(self, button):
        print("Actions:\n1,2,3\nDone!")
        Gtk.main_quit()

window = Window()
window.connect("destroy", Gtk.main_quit)
window.show_all()
Gtk.main()
