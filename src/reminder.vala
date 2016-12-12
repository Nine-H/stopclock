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
    private double interval;
    private GLib.Timer timer;
    private Notify.Notification notification;
    private Counter display;
    
    public Reminder (Gtk.Orientation orientation, int spacing) {
        Object(orientation: orientation, spacing: spacing);
        this.add (new Gtk.Label ("Hassle U bout some Shidd\n is dis builded ??\nnext hassile in aboudd"));
        
        int h = 0; int m = 20; int s = 10; //FIXME: hardcoded 20mins :D
        
        string msg = "Remember to Stretch";
        string body = "think of your back :D";
        string icon = "dialog-warning";
        notification = new Notify.Notification (msg, body, icon);
        
        timer = new GLib.Timer ();
        
        display = new Counter ( Gtk.Orientation.HORIZONTAL, 2 );
        this.add ( display );
        
        Utils.hms_to_double (h, m, s, out interval);
        timer.start ();
        
        Timeout.add (30, update);
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
        display.set_display ( interval - timer.elapsed () );
        return true;
    }
}
