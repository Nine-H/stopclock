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

class ReminderTimer : Gtk.Grid {
    private Counter display;
    private GLib.Timer timer;
    private Notify.Notification notification;
    private double interval;
    
    public ReminderTimer ( string input_title, string input_message, double timer_interval ) {
        Object ();
        this.column_spacing = 6;
        this.margin_start = 12;
        this.margin_end = 12;
        
        interval = timer_interval;
        if ( input_title == "" ) input_title = "Default Timer";
        if ( input_message == "" ) input_message = "You know what it's for :D";
        
        // maybe inline this shit :D
        var close_button = new Gtk.Button.from_icon_name (
            "process-stop-symbolic"
        );
        close_button.get_style_context ().remove_class ( "button" );
        close_button.clicked.connect ( ()=> {
            this.destroy ();
        } );
        this.attach ( close_button, 0, 0, 1, 2 );
        
        var title = new Gtk.Label ( input_title );
        title.get_style_context ().add_class ( "h3" );
        title.halign = Gtk.Align.START;
        this.attach ( title, 1, 0, 1, 1 );
        
        var message = new Gtk.Label ( input_message );
        message.halign = Gtk.Align.START;
        attach_next_to ( message, title, Gtk.PositionType.BOTTOM );
        
        display = new Counter ();
        //display.set_display ( 0 );
        display.hexpand = true;
        display.halign = Gtk.Align.END;
        this.attach ( display, 2, 0, 1, 2 );
        
        var suspend = new Gtk.Button.from_icon_name (
            "media-playback-pause-symbolic"
        );
        suspend.get_style_context ().remove_class ( "button" );
        this.attach ( suspend, 3, 0, 1, 2 );
        
        var reorder = new Gtk.Button.from_icon_name (
            "view-list-symbolic"
        );
        reorder.get_style_context ().remove_class ( "button" );
        this.attach ( reorder, 4, 0, 1, 2 );
        
        this.show_all ();
        //inline above
        
        notification = new Notify.Notification ( input_title, input_message,"dialog-warning" );
        timer = new GLib.Timer ();
        timer.start ();
        Timeout.add ( 35, update );
    }
    
    private bool update () {
        if ( timer.elapsed() > interval ) {
            try {
                notification.show ();
            } catch (Error e) {
        		error ("Error: %s", e.message);
        	}
            timer.reset();
        }
        display.set_display ( interval - timer.elapsed() );
        return true;
    }
}
