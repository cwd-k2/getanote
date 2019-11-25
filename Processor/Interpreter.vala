namespace GetaNote {
    namespace GNProcessor {

        public class Interpreter : Object {

            public signal void output (string str);
            public signal void backspace ();

            private Layout layout;
            private AsyncQueue <string> queue;
            private uint wait;
            private Thread <void *> main_thread;

            /**
             * wait: 同時押しのタイミングのズレの許容時間 (マイクロ秒)
             */
            public Interpreter (string layout, uint wait) {
                Object ();

                this.queue  = new AsyncQueue <string> ();
                this.layout = new Layout (layout);
                this.wait   = wait;

                this.main_thread = new Thread <void *> ("Interpreter Thread", main_loop);
            }

            ~ Interpreter () {
                quit ();
            }

            public bool input (string str) {
                if (str == this.layout.backspace) {
                    backspace ();
                    return true;
                }
                if (this.layout.has (str)) {
                    this.queue.push (str);
                    return true;
                } else {
                    return false;
                }
            }

            public void quit () {
                this.queue.push (".exit");
                this.main_thread.join ();
            }

            private void * main_loop () {
                string? outstr;
                string? curr, next, back;

                while (true) {

                    curr = this.queue.pop ();

                    if (curr == ".exit") {
                        break;
                    }

                    // 後がつっかえてたら待たない
                    if (this.queue.length () < 1) {
                        Thread.usleep (this.wait);
                    }

                    // なくても取り出してみる
                    next = this.queue.try_pop ();

                    outstr = interpret (curr, next, out back);

                    // 同時押しがシフトと解釈できなかったら押し戻す
                    if (back != null) {
                        this.queue.push_front (back);
                    }

                    output (outstr);

                }

                return null;

            }

            private string interpret (string curr, string? next, out string back) {
                var retval = this.layout.search (curr + "+" + next);
                back = null;

                if (retval == null) {
                    back = next;
                    retval = this.layout.search (curr);
                }

                return retval;

            }

        }

    }
}

