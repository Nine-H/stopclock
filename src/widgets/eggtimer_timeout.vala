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
 
class EggTimerTimer : Gtk.Grid {
    private Counter display;
    private GLib.Timer timer;
    private Notify.Notification notification;
    private double countdown;
    private enum TimerState {
        RUNNING,
        SUSPENDED,
        COMPLETE
    }
    private TimerState timer_state;
    private Gtk.Image suspend_icon;
    private Gtk.Image resume_icon;
    private Gtk.Image restart_icon;
    
    public EggTimerTimer ( string input_title, string input_message, double timer_countdown ) {
        Object ();
        this.column_spacing = 6;
        this.margin_start = 12;
        this.margin_end = 12;
        this.get_style_context (). add_class ( "timer-box" );
        
        //Precache icons
        suspend_icon = new Gtk.Image.from_icon_name (
            "media-playback-pause-symbolic", Gtk.IconSize.SMALL_TOOLBAR
        );
        resume_icon = new Gtk.Image.from_icon_name (
            "media-playback-start-symbolic", Gtk.IconSize.SMALL_TOOLBAR
        );
        restart_icon = new Gtk.Image.from_icon_name (
            "view-refresh-symbolic", Gtk.IconSize.SMALL_TOOLBAR
        );
        
        timer_state = TimerState.RUNNING;
        
        countdown = timer_countdown;
        if ( input_title == "" ) input_title = "Default Timer";
        if ( input_message == "" ) input_message = "You know what it's for :D";
        
        // maybe inline this shit :D
        var close_button = new Gtk.Button.from_icon_name (
            "process-stop-symbolic"
        );
        close_button.get_style_context ().remove_class ( "button" );
        close_button.clicked.connect ( ()=> {
            this.destroy ();
        } );
        this.attach ( close_button, 0, 0, 1, 2 );
        
        var title = new Gtk.Label ( input_title );
        title.get_style_context ().add_class ( "h3" );
        title.halign = Gtk.Align.START;
        this.attach ( title, 1, 0, 1, 1 );
        
        var message = new Gtk.Label ( input_message );
        message.halign = Gtk.Align.START;
        attach_next_to ( message, title, Gtk.PositionType.BOTTOM );
        
        display = new Counter ();
        //display.set_display ( 0 );
        display.hexpand = true;
        display.halign = Gtk.Align.END;
        this.attach ( display, 2, 0, 1, 2 );
        
        var start_stop_reset = new Gtk.Button.from_icon_name (
            "media-playback-pause-symbolic"
        );
        start_stop_reset.clicked.connect ( suspend_restore_restart );
        start_stop_reset.get_style_context ().remove_class ( "button" );
        this.attach ( start_stop_reset, 3, 0, 1, 2 );
        
        var reorder = new Gtk.Button.from_icon_name (
            "view-list-symbolic"
        );
        reorder.get_style_context ().remove_class ( "button" );
        this.attach ( reorder, 4, 0, 1, 2 );
        
        this.show_all ();
        //inline above
        
        notification = new Notify.Notification ( input_title, input_message,"dialog-warning" );
        timer = new GLib.Timer ();
        timer.start ();
        Timeout.add ( 35, update );
    }
    
    //FIXME: this doesn't kill the fucking timer popping up if it's dead.
    ~EggTimerTimer () {
        timer.stop ();
    }
    
    private bool update () {
        if ( timer.elapsed () > countdown ) {
            timer_state = TimerState.COMPLETE;
            display.set_display ( 0 );
            //button.set_image ( restart_icon ); //FIXME: LAME but must rewrite button updates D:
            try {
                notification.show ();
            } catch (Error e) {
                error ("Error: %s", e.message);
            }
            return true;//FIXME; false kills the update, which we need to keep calling to reset D:
            //actually might if rebound in the switch below but I gotta go to work D:
        }
        display.set_display ( countdown - timer.elapsed() );
        return true;
    }
    
    private void suspend_restore_restart ( Gtk.Button button ) {
        switch ( timer_state ) {
            case TimerState.RUNNING:
                timer.stop ();
                button.set_image ( resume_icon );
                timer_state = TimerState.SUSPENDED;
                break;
            
            case TimerState.SUSPENDED:
                timer.@continue ();
                button.set_image ( suspend_icon );
                timer_state = TimerState.RUNNING;
                break;
            
            default:
                timer.reset ();
                timer.start ();
                button.set_image ( suspend_icon );
                timer_state = TimerState.RUNNING;
                break;
        }
    }
}
