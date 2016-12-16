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

class ReminderPopover : Gtk.Popover {
    public ReminderPopover ( Gtk.Widget relative_to, Gtk.ListBox list_view ) {
        Object ( relative_to:relative_to );
        
        var layout = new Gtk.Box ( Gtk.Orientation.VERTICAL, 6 );
        layout.margin = 12;
        
        var title = new Gtk.Entry ();
        title.set_placeholder_text ("Title");
        layout.add ( title );
        
        var body = new Gtk.Entry ();
        body.set_placeholder_text ("Message");
        layout.add ( body );
        
        //FIXME: consider making this a class if it gets useful again.
        var timeentry = new Gtk.Box ( Gtk.Orientation.HORIZONTAL, 6 );
        var hours = new Gtk.SpinButton.with_range ( 0, 100, 1 );
        hours.set_orientation (Gtk.Orientation.VERTICAL);
        timeentry.add ( hours );
        
        var separator = new Gtk.Label ( "∶" );
        separator.get_style_context().add_class( "h1" );
        timeentry.add ( separator );
        
        var minutes =  new Gtk.SpinButton.with_range ( 0, 60, 1 );
        minutes.set_orientation (Gtk.Orientation.VERTICAL);
        minutes.output.connect ( ()=> {
            minutes.set_text ( "%02i".printf ( minutes.get_value_as_int () ) );
            return true;
        } );
        minutes.wrap = true;
        timeentry.add ( minutes );
        
        var separator2 = new Gtk.Label ( "∶" );
        separator2.get_style_context().add_class ( "h1" );
        timeentry.add ( separator2 );
        
        var seconds = new Gtk.SpinButton.with_range ( 0, 60, 1 );
        seconds.set_orientation (Gtk.Orientation.VERTICAL);
        seconds.wrap = true;
        seconds.output.connect ( ()=> {
            seconds.set_text ( "%02i".printf ( seconds.get_value_as_int () ) );
            return true;
        } );
        timeentry.add ( seconds );
        
        layout.add ( timeentry );
        //END: timeentry
        
        var add_timer = new Gtk.Button.with_label ( "Start" );
        add_timer.get_style_context ().add_class ( Gtk.STYLE_CLASS_SUGGESTED_ACTION );
        layout.add ( add_timer );
        add_timer.clicked.connect ( () => {
            list_view.insert ( new ReminderTimer (
                title.get_text (),
                body.get_text (),
                Utils.hms_to_double2 (
                    hours.get_value_as_int (),
                    minutes.get_value_as_int (),
                    seconds.get_value_as_int ()
                )
            ), 0 );
        } );
        
        this.add ( layout );
    }
}
