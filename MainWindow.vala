namespace HelloWorld {

    public class MainWindow : Gtk.ApplicationWindow {

        private Gtk.Label label;

        public MainWindow (Application app) {
            Object (
                application: app
            );

            this.label = new Gtk.Label ("");
            set_title ("Hello!");

            this.key_press_event.connect ( (w, key) => {
                stdout.printf ("key pressed: %u, %ld, %s\n", key.keyval, key.time, key.str);
                return true;
            });

            show_all ();
        }


    }
}
