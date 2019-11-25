namespace GetaNote {
    namespace GNProcessor {

        public class Filter : Object {

            public signal void commit (string str);
            public signal void backspace ();

            private Interpreter interpreter;

            public Filter (Interpreter interpreter) {
                Object ();
                this.interpreter = interpreter;
                this.interpreter.output.connect ((str) => {
                    if (str == ".backspace") {
                        backspace ();
                    } else if (str == ".space") {
                        commit ("　");
                    } else {
                        commit (str);
                    }
                });

            }

            ~ Filter () {
            }

            public bool filter_keypress (Gdk.EventKey key) {
                return this.interpreter.input (key.str);
            }

        }
    }
}
