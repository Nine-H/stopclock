class ReminderPopover : Gtk.Popover {
    public ReminderPopover ( Gtk.Widget relative_to, Gtk.ListBox list_view ) {
        Object ( relative_to:relative_to );
        
        var layout = new Gtk.Box ( Gtk.Orientation.VERTICAL, 6 );
        layout.margin = 12;
        
        var title = new Gtk.Entry ();
        layout.add ( title );
        
        var body = new Gtk.Entry ();
        layout.add ( body );
        
        //FIXME: consider making this a class if it gets useful again.
        var timeentry = new Gtk.Box ( Gtk.Orientation.HORIZONTAL, 6 );
        var hours = new Gtk.SpinButton.with_range ( 0, 100, 1 );
        hours.set_orientation (Gtk.Orientation.VERTICAL);
        timeentry.add ( hours );
        
        var separator = new Gtk.Label ("∶");
        separator.get_style_context().add_class( "h1" );
        timeentry.add ( separator );
        
        var minutes =  new Gtk.SpinButton.with_range ( 0, 60, 1 );
        minutes.set_orientation (Gtk.Orientation.VERTICAL);
        timeentry.add ( minutes );
        
        var separator2 = new Gtk.Label ("∶");
        separator2.get_style_context().add_class ( "h1" );
        timeentry.add ( separator2 );
        
        var seconds = new Gtk.SpinButton.with_range ( 0, 60, 1 );
        seconds.set_orientation (Gtk.Orientation.VERTICAL);
        timeentry.add ( seconds );
        
        layout.add ( timeentry );
        //END: timeentry
        
        var add_timer = new Gtk.Button.with_label ( "Start" );
        add_timer.get_style_context ().add_class ( Gtk.STYLE_CLASS_SUGGESTED_ACTION );
        layout.add ( add_timer );
        add_timer.clicked.connect ( () => {
            list_view.insert ( new ReminderTimer (), 0 );
        } );
        
        this.add ( layout );
    }
}
