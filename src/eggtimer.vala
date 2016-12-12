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

public class EggTimer : Gtk.Box {
    private Gtk.ListBox view;
    
    public EggTimer (Gtk.Orientation orientation, int spacing) {
        Object(orientation: orientation, spacing: spacing);        
        
        view = new Gtk.ListBox ();
                    
        var new_timer = new Gtk.Button.from_icon_name ("list-add-symbolic");
        new_timer.clicked.connect ( ()=> {
            int countdown_h, countdown_m, countdown_s = 0;
            countdown_h = 0;
            countdown_m = 1;
            countdown_s = 0; 
            var pop = new Gtk.Popover (new_timer);
            //set popover content
            var poplayout = new Gtk.Box (Gtk.Orientation.VERTICAL, 6);
            poplayout.margin = 6;
            
            var title = new Gtk.Entry ();
            poplayout.add (title);
            
            var body = new Gtk.Entry ();
            poplayout.add (body);
            
            //time entry starts here :D
            
            var timeentry = new Gtk.HBox ( false, 6 );
            
            var hours = new Gtk.SpinButton.with_range ( 0, 100, 1 );
            hours.set_orientation (Gtk.Orientation.VERTICAL);
            timeentry.add ( hours );
            
            var separator = new Gtk.Label ("∶");
            separator.get_style_context().add_class( "h1" );
            timeentry.add ( separator );
            
            var minutes =  new Gtk.SpinButton.with_range ( 0, 60, 1 );
            minutes.set_orientation (Gtk.Orientation.VERTICAL);
            timeentry.add ( minutes );
            
            var seconds = new Gtk.SpinButton.with_range ( 0, 60, 1 );
            seconds.set_orientation (Gtk.Orientation.VERTICAL);
            timeentry.add ( seconds );
            
            poplayout.add ( timeentry );
            // /timeentry
            
            var popoverbutton = new Gtk.Button.with_label ("Start");
            popoverbutton.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);
            popoverbutton.clicked.connect (()=>{
                view.insert ( new CountdownTimer (
                    hours.get_value_as_int(),
                    minutes.get_value_as_int(),
                    seconds.get_value_as_int(),
                    title.get_text(),
                    body.get_text()
                ) , 0);
            } );
            poplayout.add (popoverbutton);
            
            pop.add (poplayout);
            pop.show_all ();
        } );
        
        this.pack_start (view, true, true, 0);
        this.pack_end (new_timer, false, false, 0);
    }
    
    private void add_timer () {
        int countdown_h, countdown_m, countdown_s = 0;
        string name = "test";
        string description = "a test timer";
        countdown_h = 0;
        countdown_m = 1;
        countdown_s = 0; 
        view.insert ( new CountdownTimer (
            countdown_h,
            countdown_m,
            countdown_s,
            name,
            description
        ) , 0);
    }

}

