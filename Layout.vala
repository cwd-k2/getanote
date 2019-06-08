namespace ShinGeta {

    public class Layout : Object {

        public string[] keys;
        public string   backspace;

        public HashTable <string, string?> layout;

        public Layout (string layout_name) {
            Object ();

            this.layout = new HashTable <string, string?> (str_hash, str_equal);
            string[] keys = {};

            var layout_file = File.new_for_path ("./layout_" + layout_name + ".txt");

            if (!layout_file.query_exists ()) {
                stdout.printf (
                    "Layout.vala: File %s doesn't exist. Fallback to JIS layout definition.\n",
                    "layout_" + layout_name + ".txt");
                layout_file = File.new_for_path ("./layout_JIS.txt");
            }

            try {
                var dis = new DataInputStream (layout_file.read ());
                string line;
                string[] km;

                while ((line = dis.read_line (null)) != null) {
                    km = line.split ("\t");
                    switch (km.length) {
                        case 0:
                            break;
                        case 1:
                            keys += km[0];
                            break;
                        case 2:
                            this.layout.set (km[0], km[1]);
                            break;
                        default:
                            break;
                    }
                }

                this.backspace = this.layout.get ("backspace");
                this.keys = keys;

            } catch (Error e) {
                stderr.printf ("Cannot load layout file... %s\n", e.message);
            }
        }

    }
}
