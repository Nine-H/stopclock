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
using GLib;

namespace StopClock {
    namespace StopWatch {
        public class StopWatch : Gtk.Box {
            //Global vars
            private Gtk.Label readout;
            private Gtk.Label miliseconds;
            private Gtk.TreeView laps;
            private Gtk.Button button_startstop;
            private GLib.Timer timer;
            private bool cleared;
            private Gtk.ListStore laplist;
            private Gtk.TreeIter iter;
            
            public StopWatch (Gtk.Orientation orientation, int spacing) {
                Object(orientation: orientation, spacing: spacing);
                
                var controls = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 12);
                controls.set_border_width (12);
                
                var readout_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 2);
                readout_box.set_halign(Gtk.Align.CENTER);
                
                readout = new Gtk.Label("");  
                readout.get_style_context().add_class("h1");
                miliseconds = new Gtk.Label("");
                miliseconds.get_style_context().add_class("h2");
                
                timer = new GLib.Timer();
                
                laplist = new Gtk.ListStore (2, typeof (string), typeof (string));
                
                laps = new Gtk.TreeView.with_model ( laplist );
                Gtk.CellRendererText cell = new Gtk.CellRendererText ();
                laps.insert_column_with_attributes (-1, "Lap", cell, "text", 0);
                laps.insert_column_with_attributes (-1, "Time", cell, "text", 0);
                
                
                button_startstop = new Gtk.Button.with_label ("Start");
                button_startstop.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);
                button_startstop.clicked.connect (start_stop);
                
                var button_lap = new Gtk.Button.with_label ("Lap");
                button_lap.clicked.connect (lap);
                
                var button_reset = new Gtk.Button.with_label ("Reset");
                button_reset.get_style_context ().add_class (Gtk.STYLE_CLASS_DESTRUCTIVE_ACTION);
                button_reset.clicked.connect (clear);
                
                readout_box.add (readout);
                readout_box.add (miliseconds);
                controls.pack_start (button_lap);
                controls.pack_start (button_reset);
                controls.pack_end (button_startstop);
                controls.set_homogeneous (true);
                this.pack_start (readout_box, false, false, 0);
                this.pack_start (laps, true, true, 0);
                this.pack_end (controls, false, false, 0);
                
                update ();
                clear ();            
                Timeout.add (10, update);
                
            }
            
            private void start_stop (Gtk.Button btn) {
                if (btn.get_label () == "Start") {
                    if (cleared == true) {
                        timer.start ();
                        cleared = false;
                    } else {
                        timer.@continue ();
                    }
                    btn.label = "Pause";
                } else {
                    timer.stop ();
                    btn.label = "Start";
                }
            }
            
            private void clear () {
                button_startstop.set_label ("Start");
                timer.reset ();
                timer.stop ();
                laplist.clear ();
                cleared = true;
                readout.set_label ("0.00");
            }
            
            private void lap () {
                int h, m, s, ms = 0;
                Utils.time_to_hms (timer.elapsed (), out h, out m, out s, out ms);
                string elapsed = @"$h:$m:$s.$ms";
                laplist.append ( out iter );
                laplist.set ( iter, 0, elapsed, 1, elapsed );
            }
            
            private bool update () {
                int h, m, s, ms = 0;
                Utils.time_to_hms (timer.elapsed (), out h, out m, out s, out ms);
                if (h != 0)
                    readout.set_label (@"$h:$m:$s.$ms");
                else
                    readout.set_label ("%i∶%02i".printf (m, s));
                miliseconds.set_label (".%02i".printf (ms));
                return true;
            }
        }
    }
}
