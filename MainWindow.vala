namespace GetaNote {
    public class MainWindow : Gtk.ApplicationWindow {
        private Gtk.TextView view;

        public MainWindow (Application app) {
            Object (
                application: app
            );
        }

        construct {
            var header  = new Gtk.HeaderBar ();
            header.set_show_close_button (true);
            header.set_title ("下駄ノート");

            this.view = new Gtk.TextView ();
            this.view.set_wrap_mode (Gtk.WrapMode.WORD_CHAR);

            var copy_button = new Gtk.Button ();
            copy_button.set_label ("Copy");
            copy_button.clicked.connect (() => {
                this.view.select_all (true);
                this.view.copy_clipboard ();
                this.view.select_all (false);
            });

            var vbox = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);

            vbox.pack_start (view);

            header.pack_end (copy_button);

            set_titlebar (header);
            set_position (Gtk.WindowPosition.CENTER);
            set_size_request (600, 400);

            add (vbox);

            show_all ();
        }

        public void cb_interpreter_output (string str) {
            switch (str) {
                case ".space":
                    this.view.buffer.insert_at_cursor ("　", "　".length);
                    break;
                default:
                    this.view.buffer.insert_at_cursor (str, str.length);
                    break;
            }
        }

        public void cb_interpreter_backspace () {
            this.view.backspace ();
        }

    }
}
