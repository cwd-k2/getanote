namespace ShinGeta {
    public class Application : Gtk.Application {

        public Application () {
            Object (
                application_id: "com.github.cwd-k2.shingeta_vala",
                flags: ApplicationFlags.FLAGS_NONE
            );
        }

        protected override void activate () {

            var window = new MainWindow (this);

            var keymap = new KeyMap ();

            var engine = new Engine (keymap);

            window.key_press_event.connect ( (_, key) => {
                engine.event_key_queue.push (key);
                return true;
            });

            engine.output_event.connect ( (_, str) => {
                window.label.label = str;
                window.show_all ();
            });

            engine.run ();

            add_window (window);
        }

    }
}
