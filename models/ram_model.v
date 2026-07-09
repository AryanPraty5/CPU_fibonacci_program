module ram_model(
    input clk,wr,       // wr = 0 =>RAM is writng onto bus; wr=1 => RAM is reading from the bus
    inout [7:0]bus,
    input switch        // takes address if switch = 0 else takes memory element
);

    reg [7:0] mem[0:15]; // 16 of the 8bits array acting as RAM
    reg [3:0]address;
    initial begin
        $readmemb("D:/STUDY/COLLEGE/Skills/VerilogCodes/Codes/CPU_fibonacci/models/o_instructions.txt", mem);
    	mem[14] = 8'h00;   // Fibonacci element a
    	mem[15] = 8'h01;   // Fibonacci element b
    end

    always@(posedge clk)
        begin
            if(wr)
                begin
                    if(switch)
                        mem[address][3:0] <= bus[3:0];
                    else
                        address <= bus[3:0];
                end
        end
    
    assign bus = (!wr) ? mem[address] : 8'bz;

endmodule






