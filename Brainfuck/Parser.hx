package brainfuck;

class Parser {
    static var INIT_VALUE = 0;
    var tokenSequence : Array<Token>;
    var io : StdIO;
    public function new(tokenSequence, io) {
        this.tokenSequence = tokenSequence;
        this.io = io;
    }

    public function parseAndRun() {
        var memory = [];
        var mc = 0;     // memory current position
        var pc = 0;     // program counter
        var depth = 0;  // depth of while loop
        while (pc < this.tokenSequence.length) {
            memory[mc] |= INIT_VALUE;
            switch (this.tokenSequence[pc]) {
                case Token.Plus: memory[mc]++;
                case Token.Muinus: memory[mc]--;
                case Token.Lt:  mc--;
                case Token.Gt:  mc++;
                case Token.Dot: this.io.putChar(memory[mc]);
                case Token.Comma: memory[mc] = this.io.getChar();
                case Token.LeftBracket:
                    if (memory[mc] == 0) {
                        pc++;
                        while (depth > 0 || this.tokenSequence[pc] != Token.RightBracket) {
                            switch (this.tokenSequence[pc]) {
                                case Token.LeftBracket: depth++;
                                case Token.RightBracket: depth--;
                                case _ : depth += 0;
                            }
                            pc++;
                        }
                    }
                case Token.RightBracket:
                    pc--;
                    while (depth > 0 || this.tokenSequence[pc] != Token.LeftBracket) {
                        switch (this.tokenSequence[pc]) {
                            case Token.RightBracket: depth++;
                            case Token.LeftBracket: depth--;
                            case _ : depth += 0;
                        }
                        pc--;
                    }
                    pc--;
                case _ :trace("");
            }
            pc++;
        }
        return memory;
    }

    public static function main() {
        var tokenSeq = [Token.Plus, Token.Muinus, Token.Gt, Token.Plus];
        var parser = new Parser(tokenSeq, new TestIO());
        trace(parser.parseAndRun());
    }
}
class TestIO implements StdIO {
    public function new(){}
    public function getChar () {
        var a : Int = ("a".charCodeAt(0));
        return a;
    }
    public function putChar (c : Int) {
        trace(String.fromCharCode(c));
    }
}
