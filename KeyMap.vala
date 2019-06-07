namespace ShinGeta {

    public class KeyMap : Object {

        public string[] jis_layout = {
            "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "-",
            "q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "@",
            "a", "s", "d", "f", "g", "h", "j", "k", "l", ";",
            "z", "x", "c", "v", "b", "n", "m", ",", ".", "/"
        };

        public string[] us_layout  = {
            "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "-",
            "q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "[",
            "a", "s", "d", "f", "g", "h", "j", "k", "l", ";",
            "z", "x", "c", "v", "b", "n", "m", ",", ".", "/"
        };

        public string[] shift_keys = {
            "k", "d",
            "l", "s",
            "i", "o"
        };

        public string?[] kana_neutral = {
            "１", "２", "３", "４", "５", "６", "７", "８", "９", "０", "ー",
            "ー", "に", "は", "、", "ち", "ぐ", "ば", "こ", "が", "ひ", "げ",
            "の", "と", "か", "ん", "っ", "く", "う", "い", "し", "な",
            "す", "ま", "き", "る", "つ", "て", "た", "で", "。", "ぶ"
        };

        public string?[] kana_shift_m = {
            "ぁ",   "ぃ", "ぅ", "ぇ",   "ぉ",   null,   "，", "「", "」", "；",   "＠",
            "ふぁ", "ご", "ふ", "ふぃ", "ふぇ", "うぃ", "ぱ", "よ", "み", "うぇ", "うぉ",
            "ほ",   "じ", "れ", "も",   "ゆ",   "へ",   "あ", "れ", "お", "え",
            "づ",   "ぞ", "ぼ", "む",   "ふぉ", "せ",   "ね", "べ", "ぷ", "ゔ"
        };

        public string?[] kana_shift_r = {
            "ゃ", "みゃ", "みゅ", "みょ", "ゎ",   null,   "．", "（", "）", "：",   "＊",
            "ぢ", "め",   "け",   "てぃ", "でぃ", "しぇ", "ぺ", "ど", "や", "じぇ", null,
            "を", "さ",   "お",   "り",   "ず",   "び",   "ら", "じ", "さ", "そ",
            "ぜ", "ざ",   "ぎ",   "ろ",   "ぬ",   "わ",   "だ", "ぴ", "ぽ", "ちぇ"
        };

        public string?[] kana_contr_m = {
            "ゅ",   "びゃ", "びゅ", "びょ", null,   null, null, null, null, null, null,
            "ひゅ", "しゅ", "しょ", "きゅ", "ちゅ", null, null, null, null, null, null,
            "ひょ",   null,   null, "きょ", "ちょ", null, null, null, null, null,
            "ひゃ",   null, "しゃ", "きゃ", "ちゃ", null, null, null, null, null
        };

        public string?[] kana_contr_r = {
            "ょ",   "ぴゃ", "ぴゅ", "ぴょ", null,   null, null, null, null, null, null,
            "りゅ", "じゅ", "じょ", "ぎゅ", "にゅ", null, null, null, null, null, null,
            "りょ",   null,   null, "ぎょ", "にょ", null, null, null, null, null,
            "りゃ",   null, "じゃ", "ぎゃ", "にゃ", null, null, null, null, null
        };


        public HashTable <string, string?> neutral;
        public HashTable <string, string?> shift_m;
        public HashTable <string, string?> shift_r;
        public HashTable <string, string?> contr_m;
        public HashTable <string, string?> contr_r;
        public string[] layout;
        public string   backspace;

        public KeyMap (string layout) {
            Object ();

            this.neutral = new HashTable <string, string?> (str_hash, str_equal);
            this.shift_m = new HashTable <string, string?> (str_hash, str_equal);
            this.shift_r = new HashTable <string, string?> (str_hash, str_equal);
            this.contr_m = new HashTable <string, string?> (str_hash, str_equal);
            this.contr_r = new HashTable <string, string?> (str_hash, str_equal);

            switch (layout) {
                case "JIS":
                    this.layout = jis_layout;
                    this.backspace = ":";
                    break;
                case "US":
                    this.layout = us_layout;
                    this.backspace = "'";
                    break;
                default:
                    this.layout = jis_layout;
                    break;
            }

            for (var i = 0; i < 42; i++) {
                this.neutral.insert (this.layout[i], kana_neutral[i]);
                this.shift_m.insert (this.layout[i], kana_shift_m[i]);
                this.shift_r.insert (this.layout[i], kana_shift_r[i]);
                this.contr_m.insert (this.layout[i], kana_contr_m[i]);
                this.contr_r.insert (this.layout[i], kana_contr_r[i]);
            }
        }

    }
}
