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
namespace StopClock {
    namespace EggTimer {
        public class EggTimer : Gtk.Box {
            private Gtk.ListBox view;
            
            public EggTimer (Gtk.Orientation orientation, int spacing) {
                Object(orientation: orientation, spacing: spacing);
                
                int countdown_h, countdown_m, countdown_s = 0;
                string name = "test";
                string description = "a test timer";
                countdown_h = 0;
                countdown_m = 1;
                countdown_s = 0;            
                
                view = new Gtk.ListBox ();
                
                view.add ( new CountdownTimer.CountdownTimer (
                    countdown_h,
                    countdown_m,
                    countdown_s,
                    name,
                    description
                ));
                
                view.add ( new CountdownTimer.CountdownTimer (
                    6,
                    9,
                    countdown_s,
                    name,
                    description
                ));
                            
                var new_timer = new Gtk.Button.from_icon_name ("tab-new-symbolic");
                new_timer.clicked.connect ( add_timer );
                
                this.pack_start (view, true, true, 0);
                this.pack_end (new_timer, false, false, 0);
            }
            
            private void add_timer () {
                stdout.printf ("dickbutt");
                view.add ( new Gtk.Label ("dickbutt") );
            }

        }
    }
}
