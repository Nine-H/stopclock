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
 
 class AlarmPopover : Gtk.Popover {
    public AlarmPopover ( Gtk.Widget relative_to, ManagerView manager_view, Gtk.ListBox list_view ) {
        Object ( relative_to:relative_to );
        
        var layout = new Gtk.Box ( Gtk.Orientation.VERTICAL, 6 );
        layout.margin = 12;
        
        var timepicker = new  Granite.Widgets.TimePicker ();
        
        layout.add (timepicker);
        this.add (layout);
    }
 }
