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

public class ManagerView : Gtk.Box {
    public Gtk.ListBox list_view;
    public enum ManagerType {
        EGGTIMER,
        ALARMTIMER,
        REPEATTIMER,
        WORLDCLOCK
    }
    public ManagerType manager_type;
    
    public ManagerView ( ManagerType this_manager_type ) {
        Object(orientation: Gtk.Orientation.VERTICAL, spacing: 0);
        
        manager_type = this_manager_type;
        
        var scrolled = new Gtk.ScrolledWindow ( null, null );
        
        list_view = new Gtk.ListBox ();
        scrolled.add ( list_view );
        this.pack_start ( scrolled, true, true, 0 );
        
        var add_timer = new Gtk.Button.from_icon_name ( "list-add-symbolic" );
        add_timer.get_style_context (). remove_class ( "button" );
        add_timer.get_style_context (). add_class ( "manager-button" );
        
        switch ( manager_type ) {
            case ManagerType.EGGTIMER:
                var popover = new HMSPopover ( add_timer, this, list_view );
                add_timer.clicked.connect (() => { popover.show_all (); } );
                break;
                
            case ManagerType.REPEATTIMER:
                var popover = new HMSPopover ( add_timer, this, list_view );
                add_timer.clicked.connect (() => { popover.show_all (); } );
                break;
            
            default:
                add_timer.clicked.connect (() => { this.add_timer ( "", "", 0); } );
                break;
        
        }
        
        this.pack_end ( add_timer, false, false, 0 );
    }
    
    public void add_timer ( string title, string message, double timer ) {
        switch ( manager_type ) {
            case ManagerType.EGGTIMER:
                list_view.insert ( new EggTimerTimer ( title, message, timer ), 0 );
                break;
            
            case ManagerType.ALARMTIMER:
                list_view.insert ( new Gtk.Label ( "FUCK YOU ASSDOUCHE :D WAKE UP WHEN U WANT :D" ), 0 );
                break;
            
            case ManagerType.REPEATTIMER:
                list_view.insert ( new ReminderTimer ( title, message, timer ), 0 );
                break;
            
            case ManagerType.WORLDCLOCK:
                list_view.insert ( new Gtk.Label ( "I BLESSED THE RAINS DOWN IN AFRICA" ), 0 );
                break;
        }
        list_view.show_all ();
    } 
}
