namespace ShinGeta {
    public class Engine : Object {

        public signal void output_event (string str);

        public KeyMap keymap;
        public AsyncQueue <string> event_key_queue;

        private bool running;
        private Thread <void *> main_thread;

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
            string? out_str;
            string? curr, next, back;

            while (this.running) {

                curr = this.event_key_queue.pop ();

                if (this.event_key_queue.length () < 1) {
                    Thread.usleep (20000);
                }

                next = this.event_key_queue.try_pop ();

                out_str = interpret (curr, next, out back);

                if (back != null) {
                    this.event_key_queue.push_front (back);
                }

                output_event (out_str);

            }

            return null;

        }

        private string interpret (string curr, string? next, out string back) {
            var retval = this.keymap.mapping.get (string.join ("+", curr, next));
            back = null;

            if (retval == null) {
                back = next;
                retval = this.keymap.mapping.get (curr);
            }

            return retval;

        }

    }

}

