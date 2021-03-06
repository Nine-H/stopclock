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

class ReminderTimer : Gtk.Grid {
    private Counter display;
    private uint timeout_id;
    private GLib.Timer timer;
    private double interval;
    private enum TimerState {
        RUNNING,
        SUSPENDED
    }
    private TimerState timer_state;
    private Gtk.Image suspend_icon;
    private Gtk.Image resume_icon;
    private string title;
    private string message;
    
    public ReminderTimer ( string input_title, string input_message, double timer_interval ) {
        Object ();
        this.column_spacing = 6;
        this.margin_start = 12;
        this.margin_end = 12;
        this.get_style_context (). add_class ( "timer-box" );
        
        //precache the icons so it doesn't eat ram every suspend.
        suspend_icon = new Gtk.Image.from_icon_name (
            "media-playback-pause-symbolic", Gtk.IconSize.SMALL_TOOLBAR
        );
        resume_icon = new Gtk.Image.from_icon_name (
            "media-playback-start-symbolic", Gtk.IconSize.SMALL_TOOLBAR
        );
        
        timer_state = TimerState.RUNNING;
        
        interval = timer_interval;
        
        this.title = input_title;
        this.message = input_message;
        // this looks like a bug but I don't want to force insipid stock text
        // on the people that title their stuff.
        if (title == "") {
            title = "Default Reminder";
            message = "You know what it's for :D";
        }
        
        // maybe inline this shit :D
        var close_button = new Gtk.Button.from_icon_name (
            "process-stop-symbolic"
        );
        close_button.get_style_context ().remove_class ( "button" );
        close_button.clicked.connect ( ()=> {
            this.on_delete ();
        } );
        this.attach ( close_button, 0, 0, 1, 2 );
        
        var title = new Gtk.Label ( title );
        title.get_style_context ().add_class ( "h3" );
        title.halign = Gtk.Align.START;
        this.attach ( title, 1, 0, 1, 1 );
        
        var message = new Gtk.Label ( message );
        message.halign = Gtk.Align.START;
        attach_next_to ( message, title, Gtk.PositionType.BOTTOM );
        
        display = new Counter ();
        display.hexpand = true;
        display.halign = Gtk.Align.END;
        this.attach ( display, 2, 0, 1, 2 );
        
        var suspend = new Gtk.Button.from_icon_name (
            "media-playback-pause-symbolic"
        );
        suspend.clicked.connect ( suspend_restore );
        suspend.get_style_context ().remove_class ( "button" );
        this.attach ( suspend, 3, 0, 1, 2 );
        
        var reorder = new Gtk.Button.from_icon_name (
            "view-list-symbolic"
        );
        reorder.get_style_context ().remove_class ( "button" );
        this.attach ( reorder, 4, 0, 1, 2 );
        
        this.show_all ();
        //inline above
        
        timer = new GLib.Timer ();
        timer.start ();
        timeout_id = Timeout.add ( 35, update );
    }
    
    private void on_delete () {
        Source.remove (timeout_id);
        this.destroy ();
    }
    
    private bool update () {
        if ( timer.elapsed() > interval ) {
            var notification = new Notification ( title );
            notification.set_body ( message );
            GLib.Application.get_default ().send_notification ("stopclock.app", notification);
            timer.reset();
        }
        display.set_display ( interval - timer.elapsed() );
        return true;
    }
    
    private void suspend_restore ( Gtk.Button button ) {
        if ( timer_state == TimerState.SUSPENDED ) {
            timer.@continue ();
            timer_state = TimerState.RUNNING;
            button.set_image ( suspend_icon );
        } else {
            timer.stop ();
            timer_state = TimerState.SUSPENDED;
            button.set_image ( resume_icon );
        }
    }
}
