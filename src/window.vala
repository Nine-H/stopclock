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

class Window : Gtk.Window {
    private Settings settings;
        
    private int window_width = 0;
    private int window_height = 0;
    private int window_x = 0;
    private int window_y = 0;
    
    public Window () {
        settings = new Settings ("com.github.nine-h.stopclock");
        window_width = settings.get_int ("window-width");
        window_height = settings.get_int ("window-height");
        this.set_default_size ( window_width, window_height );
        
        window_x = settings.get_int ("window-x");
        window_y = settings.get_int ("window-y");
        if ( settings.get_boolean ("first-run") ) {
            this.set_position ( Gtk.WindowPosition.CENTER );
            settings.set_boolean ("first-run", false);
        } else {
            this.move ( window_x, window_y );
        }
        this.destroy.connect ( Gtk.main_quit );
        this.delete_event.connect ( on_quit );
        this.get_style_context ().add_class ("rounded");
        
        var view = new Gtk.Stack ();
        view.add_named ( new StopWatch (), "stopwatch");
        view.add_named ( new ManagerView ( ManagerView.ManagerType.EGGTIMER ), "eggtimer" );
        view.add_named ( new ManagerView ( ManagerView.ManagerType.ALARMTIMER ), "alarm" );
        view.add_named ( new ManagerView ( ManagerView.ManagerType.REPEATTIMER ), "reminder" );
        view.add_named ( new ManagerView ( ManagerView.ManagerType.WORLDCLOCK ), "worldclock" );
        
        var selector = new Granite.Widgets.ModeButton ();
        selector.append_icon ("stopclock-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
        selector.append_icon ("emblem-important-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
        selector.append_icon ("alarm-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
        selector.append_icon ("media-playlist-repeat-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
        selector.append_icon ("text-html-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
        selector.mode_changed.connect ( () => {
            switch (selector.selected) {
                case 0:
                    view.set_visible_child_name ("stopwatch");
                    break;
                case 1:
                    view.set_visible_child_name ("eggtimer");
                    break;
                case 2:
                    view.set_visible_child_name ("alarm");
                    break;
                case 3:
                    view.set_visible_child_name ("reminder");
                    break;
                case 4:
                    view.set_visible_child_name ("worldclock");
                    break;
            }
                
        });
        
        var headerbar = new Gtk.HeaderBar();
        this.set_titlebar (headerbar);
        headerbar.set_show_close_button (true);
        headerbar.set_custom_title (selector);
        
        add (view);
        
        show_all();
        Gtk.main ();
    }
    
    private bool on_quit () {
        this.get_size (out window_width, out window_height);
        settings.set_int ("window-width", window_width);
        settings.set_int ("window-height", window_height);
        this.get_position (out window_x, out window_y);
        settings.set_int ("window-x", window_x);
        settings.set_int ("window-y", window_y);
        return false;
    }
}

