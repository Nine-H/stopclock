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


public class CountdownTimer : Gtk.Grid {
    private Gtk.Button pause;
    private Notify.Notification notification;
    private Gtk.Label countdown;
    private GLib.Timer timer;
    private double countdown_time;
    private enum State {
        RUNNING,
        PAUSED,
        COMPLETE
    }
    private State state;
    
    public CountdownTimer (int h, int m, int s, string name, string description) {
        Object();
        
        this.column_spacing = 6;
        this.margin_start = 12;
        this.margin_end = 12;
        this.expand = true;
        
        State state = State.RUNNING;
        timer = new GLib.Timer ();
        
        notification = new Notify.Notification (name, description, "dialog-warning");
        
        var fuggoff = new Gtk.Button.from_icon_name("process-stop-symbolic");
        fuggoff.clicked.connect ( cancel );
        attach (fuggoff, 0,0,1,2);
        fuggoff.get_style_context ().remove_class ("button");
        
        var name_label = new Gtk.Label (name);
        name_label.get_style_context().add_class("h3");
        name_label.set_halign(Gtk.Align.START);
        var description_label = new Gtk.Label (description);
        add (name_label);
        attach_next_to (description_label, name_label, Gtk.PositionType.BOTTOM);
        
        pause = new Gtk.Button.from_icon_name("media-playback-pause-symbolic");
        pause.clicked.connect (countdown_pause);
        attach (pause,2,0,1,2);
        pause.get_style_context ().remove_class ("button");
        
        countdown = new Gtk.Label ("0");
        countdown.get_style_context().add_class("h1");
        attach_next_to (countdown, pause, Gtk.PositionType.RIGHT, 1, 2);
        
        var reorder = new Gtk.Button.from_icon_name ("view-list-symbolic");
        reorder.get_style_context ().remove_class ("button");
        attach (reorder, 4, 0, 1, 2);
        
        
        this.show_all ();
        start (h, m, s);
        update ();
        Timeout.add (10, update);
    }
    
    private void start (int h, int m, int s) {
        Utils.hms_to_double (h, m, s, out countdown_time);
        timer.start ();
    }
    
    private bool update () {
        int h, m, s, ms = 0;
        double remaining = countdown_time - timer.elapsed();
        if (remaining < 0) {
            timer.stop ();
            remaining = 0;
            try {
                notification.show ();
            } catch (Error e) {
        		error ("Error: %s", e.message);
        	}
            
        }
        Utils.time_to_hms(remaining, out h, out m, out s, out ms);
        countdown.set_label ("%i\u200E∶%02i\u200E∶%02i.\u200E%02i".printf (h, m, s, ms));
        return true;
    }
    
    private void countdown_pause () {
        if (state == State.RUNNING) {
            timer.stop ();
            //pause.icon_name = "emblem-important-symbolic";
        } else {
            timer.continue ();
        }
    }
    
    private void cancel () {
        this.destroy ();
    }
}


