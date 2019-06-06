namespace ShinGeta {
    public class MainWindow : Gtk.ApplicationWindow {

        public Gtk.Label label;

        public MainWindow (Application app) {
            Object (
                application: app
            );

            this.label = new Gtk.Label ("");
            this.add (label);

            this.show_all ();
        }
    }
}
