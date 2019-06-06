namespace ShinGeta {
    using Gdk;

    public class Engine : Object {

        public AsyncQueue <EventKey> event_key_queue;
        public Thread <void *> main_thread;
        public signal void output_event (string str);
        public signal void quit ();

        public KeyMap keymap;

        public Engine (KeyMap keymap) {
            Object ();
            this.event_key_queue = new AsyncQueue <EventKey> ();
            this.keymap = keymap;
        }

        public void run () {
            main_thread = new Thread <void *> ("Engine thread", main_loop);
        }

        private void * main_loop () {
            EventKey  key;
            EventKey? prev = null;
            string?   out_str;

            string[]  buffer = {};
            uint      buflen = 0;

            while (true) {
                key = this.event_key_queue.pop ();

                stdout.printf ("key pressed: %u, %s\n", key.keyval, key.str);

                if (key.is_modifier != 1) {

                    if (prev != null && key.time - prev.time < 50) {
                        out_str = interpret_shift_input (prev, key);
                    } else {
                        out_str = this.keymap.neutral.get (key.str);
                    }

                    if (out_str != null) {
                        if (out_str == "BS") {
                            if (buflen > 0) {
                                buflen--;
                                buffer = buffer[0:buflen];
                            }
                        } else {
                            buffer += out_str;
                            buflen++;
                        }
                        output_event (string.joinv ("", buffer));
                    }

                    prev = key;

                }

            }
        }

        private string? interpret_shift_input (EventKey prev, EventKey key) {
            switch (prev.str) {
                case "k":
                case "d":
                    return this.keymap.shift_m.get (key.str);
                case "l":
                case "s":
                    return this.keymap.shift_r.get (key.str);
                default:
                    switch (key.str) {
                        case "k":
                        case "d":
                            return this.keymap.shift_m.get (prev.str);
                        case "l":
                        case "s":
                            return this.keymap.shift_r.get (prev.str);
                        default:
                            return this.keymap.neutral.get (key.str);
                    }
            }
        }
    }

}

