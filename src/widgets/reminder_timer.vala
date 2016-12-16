class ReminderTimer : Gtk.Grid {
    public ReminderTimer () {
        Object ();
        this.column_spacing = 6;
        this.margin_start = 12;
        this.margin_end = 12;
        
        var close_button = new Gtk.Button.from_icon_name (
            "process-stop-symbolic"
        );
        close_button.get_style_context ().remove_class ( "button" );
        this.attach ( close_button, 0, 0, 1, 2 );
        
        var title = new Gtk.Label ( "Title" );
        title.get_style_context ().add_class ( "h3" );
        title.halign = Gtk.Align.START;
        this.attach ( title, 1, 0, 1, 1 );
        
        var message = new Gtk.Label ( "Message" );
        message.halign = Gtk.Align.END;
        attach_next_to ( message, title, Gtk.PositionType.BOTTOM );
        
        var display = new Counter ();
        display.set_display ( 0 );
        display.hexpand = true;
        display.halign = Gtk.Align.END;
        this.attach ( display, 2, 0, 1, 2 );
        
        var suspend = new Gtk.Button.from_icon_name (
            "media-playback-pause-symbolic"
        );
        suspend.get_style_context ().remove_class ( "button" );
        this.attach ( suspend, 3, 0, 1, 2 );
        
        var reorder = new Gtk.Button.from_icon_name (
            "view-list-symbolic"
        );
        reorder.get_style_context ().remove_class ( "button" );
        this.attach ( reorder, 4, 0, 1, 2 );
        
        this.show_all ();
    }
}
