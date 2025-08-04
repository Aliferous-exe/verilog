// AND Gate
module and_gate(input a, input b, output y);
    and (y, a, b);  // Primitive gate
endmodule


module or_gate(input a, input b, output y);
    or (y, a, b);
endmodule


module not_gate(input a, output y);
    not (y, a);
endmodule


module xor_gate(input a, input b, output y);
    xor (y, a, b);
endmodule


module nand_gate(input a, input b, output y);
    nand (y, a, b);
endmodule


module nor_gate(input a, input b, output y);
    nor (y, a, b);
endmodule
