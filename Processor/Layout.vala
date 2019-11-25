namespace GetaNote {
    namespace GNProcessor {

        public class Layout : Object {

            public string[] keys;
            public string backspace;

            public HashTable <string, string?> layout;

            public Layout (string layout_name) {
                Object ();

                this.layout = new HashTable <string, string?> (str_hash, str_equal);
                string[] keys = {};

                var layout_file = File.new_for_path (
                    "./resources/" + layout_name + ".layout");

                if (!layout_file.query_exists ()) {
                    stderr.printf (
                        "Layout.vala: File %s doesn't exist."
                        + "Fallback to JIS layout definition.\n",
                        layout_name + ".layout");
                    layout_file = File.new_for_path ("./resources/JIS.layout");
                }

                try {
                    var dis = new DataInputStream (layout_file.read ());
                    string line;
                    string[] km;

                    while ((line = dis.read_line (null)) != null) {
                        km = line.split ("\t");
                        if (km.length == 2) {
                            keys += km[0];
                            this.layout.set (km[0], km[1]);
                            if (km[1] == ".backspace") {
                                this.backspace = km[0];
                            }
                        }
                    }
                    this.keys = keys;

                } catch (Error e) {
                    stderr.printf ("Cannot load layout file: %s\n", e.message);
                }
            }

            public string? search (string key) {
                return this.layout.get (key);
            }

            public bool has (string key) {
                return (key in this.keys);
            }

        }
    }
}
