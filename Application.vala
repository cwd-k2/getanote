namespace GetaNote {
    public class Application : Gtk.Application {

        public Application () {
            Object (
                application_id: "com.github.cwd-k2.getanote",
                flags: ApplicationFlags.FLAGS_NONE
            );
        }

        ~ Application () {
        }

        protected override void activate () {

            var window = new MainWindow (this);

            var interpreter = new GNProcessor.Interpreter ("JIS", 25000);

            window.key_press_event.connect ((key) => {
                return interpreter.input (key.str);
            });

            interpreter.output.connect (window.cb_interpreter_output);
            interpreter.backspace.connect (window.cb_interpreter_backspace);

            add_window (window);
        }

    }
}

public void eventkey_detail (Gdk.EventKey key) {
    stdout.printf (
        string.join (
            "\n\t",
            "key pressed:",
            "group: %u", "hardware_keycode: %u",
            "is_modifier: %u", "keyval: %u",
            "length %d", "send_event: %u",
            "state: %d", "string: %s", "time: %u", "type: %d\n"),
            key.group, key.hardware_keycode,
            key.is_modifier, key.keyval,
            key.length, key.send_event,
            key.state, key.str, key.time, key.type);
}
