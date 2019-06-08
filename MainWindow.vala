namespace GetaNote {
    public class MainWindow : Gtk.ApplicationWindow {

        public Gtk.Label label;
        public Gtk.TextView view;
        public Gtk.TextBuffer buffer;

        public MainWindow (Application app) {
            Object (
                application: app
            );

            this.buffer = new Gtk.TextBuffer (null);
            this.view   = new Gtk.TextView.with_buffer (this.buffer);

            this.add (view);

            this.show_all ();
        }
    }
}
