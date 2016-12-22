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

class StopClockApp : Granite.Application {
    private Window window;
    
    construct {
        program_name = "StopClock";
        exec_name = "stopclock";
        app_years = "2015 - 2016";
        app_launcher = "stopclock.desktop";
        application_id = "com.github.nine-h.stopclock";
        main_url = "https://github.com/Nine-H/stopclock";
        bug_url = "https://github.com/Nine-H/stopclock/issues";
        about_authors = { "Nine H <nine.gentooman@gmail.com>" };
        about_license_type = Gtk.License.GPL_3_0;
        about_comments = "It's right TWICE a day :D";           
    }
    
    public StopClockApp () {
        Granite.Services.Logger.initialize ("StopClockApp");
        Granite.Services.Logger.DisplayLevel = Granite.Services.LogLevel.DEBUG;
    }
     
    public override void activate () {
        window = new Window ();
    }

    
    public static int main ( string [] args ) {
        Gtk.init (ref args);
        Notify.init ("StopClock");
        
        string css_file = "/usr/share/stopclock/stopclock.css";
        var css_provider = new Gtk.CssProvider ();
        
        try {
            css_provider.load_from_path (css_file);
            Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default(), css_provider, Gtk.STYLE_PROVIDER_PRIORITY_USER);
        } catch (Error e) {
            stderr.printf ("error: %s", e.message);
        }
        
        var app = new StopClockApp ();
        return app.run (args);
    }
}

