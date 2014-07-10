import brainfuck.Tokenizer;
import brainfuck.Parser;
import brainfuck.StdIO;
import js.Browser;

abstract CastElement(js.html.Element) {
    public function new(element: js.html.Element) {
        this = element;
    }
    @:to public function toTextAreaElement() : js.html.TextAreaElement {
        return cast(this, js.html.TextAreaElement);
    }
}

class DomIO implements StdIO {
    var elem : js.html.Element;
    public function new(elem : js.html.Element) {
        this.elem = elem;
    }

    public function getChar() {
        var c : Int = js.Browser.window.prompt("プログラムが入力を求めています。").charCodeAt(0);
        return c;
    }

    public function putChar(c) {
        this.elem.innerText += String.fromCharCode(c);
    }
}

class BFRunner {
    public static function run(io : DomIO) {
        var srcInput : js.html.TextAreaElement = new CastElement(js.Browser.document.getElementById("src"));
        var tokenizer = new Tokenizer(srcInput.value);
        var parser = new Parser(tokenizer.tokenize(), io);
        parser.parseAndRun();
    }

    public static function main() {
        var result = js.Browser.document.getElementById("result");
        var io = new DomIO(result);
        js.Browser.document.getElementById("run").onclick = function (e) {
            run(io);
        };
    }
}
