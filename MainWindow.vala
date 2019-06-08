namespace GetaNote {
    public class MainWindow : Gtk.ApplicationWindow {

        public Gtk.Label label;
        public Gtk.TextView view;
        public Gtk.TextBuffer buffer;

        public bool pass_to_ime;

        public MainWindow (Application app) {
            Object (
                application: app
            );

            this.set_position (Gtk.WindowPosition.CENTER);
            this.set_size_request (600, 400);

            this.buffer = new Gtk.TextBuffer (null);
            this.view   = new Gtk.TextView.with_buffer (this.buffer);

            var header  = new Gtk.HeaderBar ();
            header.set_show_close_button (true);
            header.set_title ("新下駄配列");

            var copy_button = new Gtk.Button ();
            copy_button.set_label ("Copy");
            copy_button.clicked.connect (() => {
                this.view.select_all (true);
                this.view.copy_clipboard ();
                this.view.select_all (false);
            });

            var vbox = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
            var hbox = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);

            var ime_toggle = new Gtk.Switch ();
            ime_toggle.set_active (true);
            this.pass_to_ime = ime_toggle.get_active ();
            ime_toggle.state_set.connect (() => {
                this.pass_to_ime = ime_toggle.get_active ();
                return false;
            });

            hbox.pack_end (ime_toggle, false, false, 10);
            hbox.pack_end (new Gtk.Label ("新下駄IMEを有効化"), false, false, 5);

            vbox.pack_start (this.view);
            vbox.pack_end (hbox, false, false);

            header.pack_end (copy_button);

            this.set_titlebar (header);

            this.add (vbox);

            this.show_all ();
        }
    }
}
