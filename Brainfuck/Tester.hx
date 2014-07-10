package brainfuck;

class Tester {
    public static function main() {
        var testSeq = "+++++++++[>++++++++>+++++++++++>+++++<<<-]>.>++.+++++++..+++.>-.------------.<++++++++.--------.+++.------.--------.>+.";
        var tokenizer = new Tokenizer(testSeq);
        var parser = new Parser(tokenizer.tokenize());
        trace(parser.parseAndRun());
    }
}
