module b01_7seg (
    input  logic [3:0] ui_in,
    output logic [7:0] uo_out
);

    // uo_out = {invalid,a,b,c,d,e,f,g}
    // Common-anode: 0 = ON, 1 = OFF

    always_comb begin
        case (ui_in)
            4'd0: uo_out = 8'b00000001;
            4'd1: uo_out = 8'b01001111;
            4'd2: uo_out = 8'b00010010;
            4'd3: uo_out = 8'b00000110;
            4'd4: uo_out = 8'b01001100;
            4'd5: uo_out = 8'b00100100;
            4'd6: uo_out = 8'b00100000;
            4'd7: uo_out = 8'b00001111;
            4'd8: uo_out = 8'b00000000;
            4'd9: uo_out = 8'b00000100;
            default: uo_out = 8'b11111111;
        endcase
    end

endmodule