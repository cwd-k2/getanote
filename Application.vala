namespace HelloWorld {
    public class Application : Gtk.Application {

        public Application () {
            Object (
                application_id: "com.github.d-flat-aug7.helloworld",
                flags: ApplicationFlags.FLAGS_NONE
            );
        }

        // Gtk.Application に特有の書き方
        protected override void activate () {
            MainWindow window = new MainWindow (this);

            add_window (window);
        }

    }
}
