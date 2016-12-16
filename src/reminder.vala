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

public class Reminder : Gtk.Box {
    Gtk.ListBox list_view;
    
    public Reminder () {
        Object(orientation: Gtk.Orientation.VERTICAL, spacing: 0);
        
        var scrolled = new Gtk.ScrolledWindow ( null, null );
        
        list_view = new Gtk.ListBox ();
        scrolled.add ( list_view );
        this.pack_start ( scrolled, true, true, 0 );
        
        var add_timer = new Gtk.Button.from_icon_name ( "list-add-symbolic" );
        var popover = new ReminderPopover ( add_timer, list_view );
        add_timer.clicked.connect (() => {
            popover.show_all ();
            list_view.show_all ();
        } );
        this.pack_end ( add_timer, false, false, 0 );
    }
}
