namespace ShinGeta {
    public class Engine : Object {

        public signal void output_event (string str);

        public Layout layout;
        public AsyncQueue <string> input_q;

        private uint wait;
        private bool running;
        private Thread <void *> main_thread;

        /*
         * wait: 同時押しのタイミングのズレの許容時間
         */
        public Engine (Layout layout, uint wait) {
            Object ();
            this.input_q = new AsyncQueue <string> ();
            this.layout = layout;
            this.wait = wait;
        }

        public void run () {
            this.running = true;
            this.main_thread = new Thread <void *> ("Engine Thread", main_loop);
        }

        private void * main_loop () {
            string? out_str;
            string? curr, next, back;

            while (this.running) {

                curr = this.input_q.pop ();

                // 後がつっかえてたら待たない
                if (this.input_q.length () < 1) {
                    Thread.usleep (this.wait);
                }

                // なくても取り出してみる
                next = this.input_q.try_pop ();

                out_str = interpret (curr, next, out back);

                // 同時押しがシフトと解釈できなかったら押し戻す
                if (back != null) {
                    this.input_q.push_front (back);
                }

                output_event (out_str);

            }

            return null;

        }

        private string interpret (string curr, string? next, out string back) {
            var retval = this.layout.layout.get (string.join ("+", curr, next));
            back = null;

            if (retval == null) {
                back = next;
                retval = this.layout.layout.get (curr);
            }

            return retval;

        }

    }

}

