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
            //this.prev = null;
            string? out_str;

            while (this.running) {

                this.curr = this.event_key_queue.pop ();

                this.simultaneous = false;

                if (this.prev != null && this.prev != this.curr) {

                    out_str = this.keymap.interpret ({this.prev, this.curr});

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
            var out_str = this.keymap.interpret ({this.curr});

            Thread.usleep (25000);

            if (!this.simultaneous && out_str != null) {
                output_event (out_str);
                this.prev = null;
            }

            return null;
        }

    }

}

