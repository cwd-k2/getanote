namespace ShinGeta {

    public class KeyMap : Object {

        public string[] layout;
        public string   backspace;

        public HashTable <string, string?> mapping;

        public KeyMap (string layout_name) {
            Object ();

            this.mapping = new HashTable <string, string?> (str_hash, str_equal);
            string[] layout = {};

            var keymap_file = File.new_for_path ("./keymap_" + layout_name + ".txt");

            if (!keymap_file.query_exists ()) {
                stdout.printf (
                    "KeyMap.vala: File %s doesn't exist. Fallback to JIS layout definition.\n",
                    "keymap_" + layout_name + ".txt");
                keymap_file = File.new_for_path ("./keymap_JIS.txt");
            }

            try {
                var dis = new DataInputStream (keymap_file.read ());
                string line;
                string[] km;

                while ((line = dis.read_line (null)) != null) {
                    km = line.split ("\t");
                    switch (km.length) {
                        case 0:
                            break;
                        case 1:
                            layout += km[0];
                            break;
                        case 2:
                            this.mapping.set (km[0], km[1]);
                            break;
                        default:
                            break;
                    }
                }

                this.backspace = this.mapping.get ("backspace");
                this.layout = layout;

            } catch (Error e) {
                stderr.printf ("Cannot load keymaps... %s\n", e.message);
            }
        }

    }
}
