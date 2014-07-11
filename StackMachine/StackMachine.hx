class ALU {
    public function new() {}
    private function takeValue(op) {
        return switch (op) {
            case Value(val): val;
            case _: null;
        }
    }
    public function add(a, b) { return Value(takeValue(a)+ takeValue(b)); }
    public function sub(a, b) { return Value(takeValue(a)- takeValue(b)); }
    public function mul(a, b) { return Value(takeValue(a)* takeValue(b)); }
}

enum Operand {
    Add;
    Mul;
    Sub;
    Store;
    Load;
    Print;
    Value(val : Int);
}

class StackMachine {
    var operandStack : Array<Operand>;
    var codeSequence : Array<Int>;
    var memory: Array<Int>;
    var pc : Int;
    var alu : ALU;
    public function new(code) {
        this.codeSequence = code;
        this.alu = new ALU();
        this.operandStack = [];
        this.memory = [];
        this.pc = 0;
    }

    public function execute() {
        while (this.pc < this.codeSequence.length) {
            var op = this.codeSequence[this.pc];
            this.executeCommand(op);
            this.pc++;
        }
    }

    private function executeCommand(op) {
        var a, b;
        switch (op) {
            case 16:    // push
                this.operandStack.push(Value(this.codeSequence[++this.pc]));
            case 18:    // store
                b = this.operandStack.pop();
                a = this.operandStack.pop();
                this.memory[takeValue(a)] = takeValue(b);
            case 19:    // load
                a = this.operandStack.pop();
                this.operandStack.push(Value(this.memory[takeValue(a)]));
            case 96:
                b = this.operandStack.pop();
                a = this.operandStack.pop();
                this.operandStack.push(this.alu.add(a, b));
            case 104:
                b = this.operandStack.pop();
                a = this.operandStack.pop();
                this.operandStack.push(this.alu.mul(a, b));
            case -48:
                trace(this.operandStack[this.operandStack.length - 1]);
            case _:
                trace("Invalied Command.");
        }
    }

    private function takeValue(op) {
        return switch (op) {
            case Value(val): val;
            case _: null;
        }
    }

    public static function main() {
        var opcode = [
            16, 0,
            16, 1,
            16, 2,
            96,
            16, 3,
            104,
            18,
            16, 2,
            16, 3,
            96,
            16, 0,
            19,
            104,
            -48
        ];
        var sm = new StackMachine(opcode);
        sm.execute();
    }
}
