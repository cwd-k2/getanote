namespace ShinGeta {

    namespace JIS {
        public const string[] layout = {
            "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "-",
            "q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "@",
            "a", "s", "d", "f", "g", "h", "j", "k", "l", ";", ":",
            "z", "x", "c", "v", "b", "n", "m", ",", ".", "/"
        };
    }

    namespace US {
        public const string[] layout = {
            "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "-",
            "q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "[",
            "a", "s", "d", "f", "g", "h", "j", "k", "l", ";", "'",
            "z", "x", "c", "v", "b", "n", "m", ",", ".", "/"
        };
    }

    namespace Kana {
        public const string?[] neutral = {
            "１", "２", "３", "４", "５", "６", "７", "８", "９", "０", "ー",
            "ー", "に", "は", "、", "ち", "ぐ", "ば", "こ", "が", "ひ", "げ",
            "の", "と", "か", "ん", "っ", "く", "う", "い", "し", "な", "BS",
            "す", "ま", "き", "る", "つ", "て", "た", "で", "。", "ぶ"
        };
        public const string?[] shift_m = {
            "ぁ",   "ぃ", "ぅ", "ぇ",   "ぉ",   null,   "，", "「", "」", "；",   "＠",
            "ふぁ", "ご", "ふ", "ふぃ", "ふぇ", "うぃ", "ぱ", "よ", "み", "うぇ", "うぉ",
            "ほ",   "じ", "れ", "も",   "ゆ",   "へ",   "あ", "れ", "お", "え",   null,
            "づ",   "ぞ", "ぼ", "む",   "ふぉ", "せ",   "ね", "べ", "ぷ", "ゔ"
        };
        public const string?[] shift_r = {
            "ゃ", "みゃ", "みゅ", "みょ", "ゎ",   null,   "．", "（", "）", "：",   "＊",
            "ぢ", "め",   "け",   "てぃ", "でぃ", "しぇ", "ぺ", "ど", "や", "じぇ", null,
            "を", "さ",   "お",   "り",   "ず",   "び",   "ら", "じ", "さ", "そ",   null,
            "ぜ", "ざ",   "ぎ",   "ろ",   "ぬ",   "わ",   "だ", "ぴ", "ぽ", "ちぇ"
        };
        public const string?[] contr_m = {
        };
        public const string?[] contr_r = {
        };
    }

    public class KeyMap : Object {

        public HashTable <string, string?> neutral;
        public HashTable <string, string?> shift_m;
        public HashTable <string, string?> shift_r;
        public HashTable <string, string?> contr_m;
        public HashTable <string, string?> contr_r;

        public KeyMap () {
            Object ();
            this.neutral = new HashTable <string, string?> (str_hash, str_equal);
            this.shift_m = new HashTable <string, string?> (str_hash, str_equal);
            this.shift_r = new HashTable <string, string?> (str_hash, str_equal);
            this.contr_m = new HashTable <string, string?> (str_hash, str_equal);
            this.shift_r = new HashTable <string, string?> (str_hash, str_equal);
            this.setup_for ();
        }

        private void setup_for () {
            for (var i = 0; i < 42; i++) {
                this.neutral.insert (JIS.layout[i], Kana.neutral[i]);
                this.shift_m.insert (JIS.layout[i], Kana.shift_m[i]);
                this.shift_r.insert (JIS.layout[i], Kana.shift_r[i]);
            }
        }
    }
}
