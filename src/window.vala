/*-
 * Copyright (c) 2015 StopClock Developers (nine.gentooman@gmail.com)
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Library General Public License as published by
 * the Free Software Foundation, either version 2.1 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

using Gtk;
using GLib;


class Window : Gtk.Window {
    
    public Window () {
        this.set_position (Gtk.WindowPosition.CENTER);
        this.set_default_size (350, 500);
        this.destroy.connect (Gtk.main_quit);
        this.get_style_context ().add_class ("rounded");
        
        var view = new Gtk.Stack ();
        var stopwatch = new StopWatch(Gtk.Orientation.VERTICAL, 0);
        view.add_titled ( stopwatch, "stopwatch", "stopwatch");
        view.child_set_property (stopwatch, "icon-name", "stopclock-symbolic");
        
        var eggtimer = new EggTimer(Gtk.Orientation.VERTICAL, 0);
        view.add_titled (eggtimer, "eggtimer", "eggtimer");
        view.child_set_property (eggtimer, "icon-name", "emblem-important-symbolic");
        
        var alarm = new Alarm(Gtk.Orientation.VERTICAL, 0);
        view.add_titled (alarm, "alarm", "alarm");
        view.child_set_property (alarm, "icon-name","alarm-symbolic");
        
        var reminder = new Reminder(Gtk.Orientation.VERTICAL, 0);
        view.add_titled (reminder, "reminder", "reminder");
        view.child_set_property (reminder, "icon-name", "media-playlist-repeat-symbolic");
        
        var worldclock = new WorldClock(Gtk.Orientation.VERTICAL, 0);
        view.add_titled (worldclock, "worldclock", "worldclock");
        view.child_set_property (worldclock, "icon-name", "text-html-symbolic");
        
        var selector = new Gtk.StackSwitcher ();
        selector.stack = view;
        
        var headerbar = new Gtk.HeaderBar();
        this.set_titlebar (headerbar);
        headerbar.set_show_close_button (true);
        headerbar.set_custom_title (selector);
        
        add (view);
        
        show_all();
        Gtk.main ();
    }
}

