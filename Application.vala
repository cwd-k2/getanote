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
            var engine = new Engine (keymap, 20000);

            window.key_press_event.connect ( (_, key) => {

                stdout.printf (
                    string.join ("\n\t",
                    "key pressed:",
                    "group: %u",
                    "hardware_keycode: %u",
                    "is_modifier: %u",
                    "keyval: %u",
                    "length %d",
                    "send_event: %u",
                    "state: %d",
                    "string: %s",
                    "time: %u",
                    "type: %d\n"),
                    key.group,
                    key.hardware_keycode,
                    key.is_modifier,
                    key.keyval,
                    key.length,
                    key.send_event,
                    key.state,
                    key.str,
                    key.time,
                    key.type);

                if (key.str == keymap.backspace) {
                    window.view.backspace ();
                    return true;
                }

                if (key.is_modifier != 1 && key.str in keymap.layout) {
                    engine.input_q.push (key.str);
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
