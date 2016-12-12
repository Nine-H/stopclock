/*
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

class Counter : Gtk.Box {
    private Gtk.Label readout;
    private Gtk.Label miliseconds;
    
    public Counter (Gtk.Orientation orientation, int spacing) {
        readout = new Gtk.Label ( "" );
        readout.get_style_context().add_class( "h1" );
        miliseconds = new Gtk.Label ( "" );
        miliseconds.get_style_context().add_class( "h2" );
        this.set_halign (Gtk.Align.CENTER);
        this.add (readout);
        this.add (miliseconds);
        this.show_all ();
    }
    
    public void set_display ( double input ) {
        int h, m, s, ms = 0;
        Utils.time_to_hms ( input, out h, out m, out s, out ms );
        if (h > 0)
            readout.set_label ( "%i∶%02i∶%02i".printf (h, m, s) );
        else
            readout.set_label ( "%i∶%02i".printf (m, s) );
        miliseconds.set_label ( ".%02i".printf (ms) );
    }
}
