module ram_model(
    input clk,wr,       // wr = 0 =>RAM is writng onto bus; wr=1 => RAM is reading from the bus
    inout [7:0]bus,
    input switch        // takes address if switch = 0 else takes memory element
);

    reg [7:0] mem[0:15]; // 16 of the 8bits array acting as RAM
    reg [3:0]address;
    initial begin
        //0000 = loadA
        //0100 = LoadB
        //0010 = Add
        mem[0] = 8'b0000_1110;   //LoadA 14
        mem[1] = 8'b0100_1111;   //LoadB 15
        mem[2] = 8'b0010_1110;   //Add 14
        mem[3] = 8'b0000_1111;   //LoadA 15
        mem[4] = 8'b0100_1110;   //LoadB 14
        mem[5] = 8'b0010_1111;   //Add 15
        mem[6] = 8'b0000_1110;   //LoadA 14
        mem[7] = 8'b0100_1111;   //LoadB 15
        mem[8] = 8'b0010_1110;   //Add 14
        mem[9] = 8'b0000_1111;   //LoadA 15
        mem[10] = 8'b0100_1110;  //LoadB 14       
        mem[11] = 8'b0010_1111;  //Add 15
        mem[12] = 8'b0000_1110;  //LoadA 14       
        mem[13] = 8'b0100_1111;  //LoadB 15
        mem[14] = 8'b0000_0000;
        mem[15] = 8'b0000_0001;
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






