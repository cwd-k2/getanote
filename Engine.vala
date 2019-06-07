namespace ShinGeta {
    public class Engine : Object {

        public signal void output_event (string str);

        public KeyMap keymap;
        public AsyncQueue <string> event_key_queue;

        private bool simultaneous;
        private bool running;
        private Thread <void *> main_thread;
        private string? curr;
        private string? prev;

        public Engine (KeyMap keymap) {
            Object ();
            this.event_key_queue = new AsyncQueue <string> ();
            this.keymap = keymap;
        }

        public void run () {
            this.running = true;
            this.main_thread = new Thread <void *> ("Engine Thread", main_loop);
        }

        public void stop () {
            this.running = false;
            this.main_thread.join ();
        }

        private void * main_loop () {
            this.prev = null;
            string? out_str;

            while (this.running) {

                this.curr = this.event_key_queue.pop ();

                this.simultaneous = false;

                if (this.prev != null && this.prev != this.curr) {

                    out_str = interpret_shift_input (this.prev, this.curr);

                    if (out_str != null) {
                        this.simultaneous = true;
                        output_event (out_str);
                        this.prev = null;
                    }
                }

                if (!simultaneous) {
                    new Thread <void *> ("Subroutine thread", subroutine);
                    this.prev = this.curr;
                }

            }

            return null;

        }

        private void * subroutine () {
            var out_str = this.keymap.neutral.get (this.curr);

            Thread.usleep (25000);

            if (!this.simultaneous && out_str != null) {
                output_event (out_str);
                this.prev = null;
            }

            return null;
        }

        private string? interpret_shift_input (string key1, string key2) {
            switch (key1) {
                case "k":
                case "d":
                    return this.keymap.shift_m.get (key2);
                case "l":
                case "s":
                    return this.keymap.shift_r.get (key2);
                case "i":
                    return this.keymap.contr_m.get (key2);
                case "o":
                    return this.keymap.contr_r.get (key2);
                default:
                    switch (key2) {
                        case "k":
                        case "d":
                            return this.keymap.shift_m.get (key1);
                        case "l":
                        case "s":
                            return this.keymap.shift_r.get (key1);
                        case "i":
                            return this.keymap.contr_m.get (key1);
                        case "o":
                            return this.keymap.contr_r.get (key1);
                        default:
                            return null;
                    }
            }
        }
    }

}

