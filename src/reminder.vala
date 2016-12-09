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
    namespace Reminder {
        public class Reminder : Gtk.Box {
            private double interval;
            private GLib.Timer timer;
            private GLib.Notification notification;
            
            public Reminder (Gtk.Orientation orientation, int spacing) {
                Object(orientation: orientation, spacing: spacing);
                this.add (new Gtk.Label ("Hassle U bout some Shidd"));
                
                int h = 0; int m = 20; int s = 0; //FIXME: hardcoded 20mins :D
                
                //FIXME: should I be using Notify.Notification()???
                notification = new GLib.Notification ("Remember to Stretch");
                notification.set_body ("think of your back :D");
                //var icon = new GLib.Icon.new_for_string ("dialog-warning");
                //notification.set_icon (icon);
                //GLib.Application.get_default ().send_notification (null, notification);
              
                
                timer = new GLib.Timer ();
                
                Utils.hms_to_double (h, m, s, out interval);
                timer.start ();
                
                Timeout.add (30, update);
            }
            
            private bool update () {
                if ( timer.elapsed() > interval ) {
                    GLib.Application.get_default ().send_notification (null, notification);
                    timer.reset();
                }
                return true;
            }
        }
    }
}
