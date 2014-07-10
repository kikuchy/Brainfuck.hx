package brainfuck;

class Tokenizer {
    var pointer : Int;
    var rawString : String;
    public function new(rawString) {
        this.rawString = rawString;
    }

    public function tokenize() {
        var buffer = [];
        for (i in 0...rawString.length) {
            var c = rawString.charAt(i);
            switch (c) {
                case '+':   buffer.push(Token.Plus);
                case '-':   buffer.push(Token.Muinus);
                case ',':   buffer.push(Token.Comma);
                case '.':   buffer.push(Token.Dot);
                case '<':   buffer.push(Token.Lt);
                case '>':   buffer.push(Token.Gt);
                case '[':   buffer.push(Token.LeftBracket);
                case ']':   buffer.push(Token.RightBracket);
                case _ :    buffer.push(Token.Other);
            }
        }
        return buffer;
    }

    public static function main() {
        var raw = "++--..,,";
        var tokenizer = new Tokenizer(raw);
        var tokenSequence = tokenizer.tokenize();
        trace(tokenSequence);
    }
}
