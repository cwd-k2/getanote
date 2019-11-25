namespace GetaNote {
    namespace GNProcessor {

        public class Dictionary : Object {

            private HashTable <string, string?> dictionary;

            public Dictionary (string dict_name) {
                Object ();

                this.dictionary = new HashTable <string, string?> (str_hash, str_equal);

                var dict_file = File.new_for_path ("./resources/" + dict_name + ".dict");

                if (!dict_file.query_exists ()) {
                    stderr.printf (
                        "Dictionary.vala: File %s doesn't exist.\n",
                        dict_name + ".dict");

                } else {

                    try {
                        var dis = new DataInputStream (dict_file.read ());
                        string line;
                        string[] km;

                        while ((line = dis.read_line (null)) != null) {
                            km = line.split ("\t");
                            this.dictionary.set (km[0], km[1]);
                        }

                    } catch (Error e) {
                        stderr.printf ("Cannot load dictionary file: %s\n", e.message);
                    }

                }

            }

            public List <DictionaryItem>? refer (string index) {
                var str = this.dictionary.get (index);
                if (str != null) {
                    var list = new List <DictionaryItem> ();
                    foreach (string s in str.split ("/")) {
                        list.append (new DictionaryItem (s));
                    }
                    return list;
                } else {
                    return null;
                }
            }

        }

        private string skk_okuri_str (string str) {
            switch (str.get_char(0)) {
                case 'あ':
                case 'ぁ':
                    return "a";
                case 'い':
                case 'ぃ':
                    return "i";
                case 'う':
                case 'ぅ':
                    return "u";
                case 'え':
                case 'ぇ':
                    return "e";
                case 'お':
                case 'ぉ':
                    return "o";
                case 'か':
                case 'き':
                case 'く':
                case 'け':
                case 'こ':
                    return "k";
                case 'さ':
                case 'し':
                case 'す':
                case 'せ':
                case 'そ':
                    return "s";
                case 'た':
                case 'ち':
                case 'つ':
                case 'て':
                case 'と':
                    return "t";
                case 'な':
                case 'に':
                case 'ぬ':
                case 'ね':
                case 'の':
                    return "n";
                case 'は':
                case 'ひ':
                case 'ふ':
                case 'へ':
                case 'ほ':
                    return "h";
                case 'ま':
                case 'み':
                case 'む':
                case 'め':
                case 'も':
                    return "m";
                case 'や':
                case 'ゆ':
                case 'よ':
                    return "y";
                case 'ら':
                case 'り':
                case 'る':
                case 'れ':
                case 'ろ':
                    return "r";
                case 'わ':
                case 'を':
                    return "w";
                case 'ん':
                    return "n";
                case 'っ':
                    return "c";
                case 'が':
                case 'ぎ':
                case 'ぐ':
                case 'げ':
                case 'ご':
                    return "g";
                case 'ざ':
                case 'ず':
                case 'ぜ':
                case 'ぞ':
                    return "z";
                case 'じ':
                    return "j";
                case 'だ':
                case 'ぢ':
                case 'づ':
                case 'で':
                case 'ど':
                    return "d";
                case 'ば':
                case 'び':
                case 'ぶ':
                case 'べ':
                case 'ぼ':
                    return "b";
                case 'ぱ':
                case 'ぴ':
                case 'ぷ':
                case 'ぺ':
                case 'ぽ':
                    return "p";
                default:
                    return "";
            }
        }

        public class DictionaryItem : Object {
            public string item;
            public string? comment;

            public DictionaryItem (string str) {
                Object ();
                var arr = str.split (";");
                if (arr.length >= 2) {
                    this.item    = arr[0];
                    this.comment = arr[1];
                } else {
                    this.item    = arr[0];
                    this.comment = null;
                }
            }
        }

    }
}
