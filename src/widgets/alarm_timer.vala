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

//FIXME: should not be inlined here.
class ClockView : Gtk.Box {
    public ClockView (Time time) {
        this.add (new Gtk.Label ("shitballs") );
    }
}
 
class AlarmTimer : Gtk.Grid {
    private Gtk.Label clock;
    private Time alarm_time;
    private Time current_time;
    private uint timeout_id;
    
    public AlarmTimer () {
        clock = new Gtk.Label (":D:D:D:D");
        this.add (clock);
        
        var close_button = new Gtk.Button.with_label ("dismiss");
        close_button.clicked.connect ( on_delete );
        this.add (close_button);
        
        //timeout_id = Timeout
    }
    
    private void on_delete () {
        Source.remove (timeout_id);
        this.destroy ();
    }
}
