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

            var keymap = new KeyMap ("JIS");

            var engine = new Engine (keymap);

            window.key_press_event.connect ( (_, key) => {

                if (key.str == keymap.backspace) {
                    window.view.backspace ();
                    return true;
                }

                if (key.is_modifier != 1 && key.str in keymap.layout) {

                    engine.event_key_queue.push (key);

                    return true;
                }

                return false;
            });

            engine.output_event.connect ( (_, str) => {
                window.buffer.insert_at_cursor (str, str.length);
            });

            engine.run ();

            add_window (window);
        }

    }
}
