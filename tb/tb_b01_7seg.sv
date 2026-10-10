module b01_tb;

    reg  [3:0] ui_in;
    wire [7:0] uo_out;
    reg  [7:0] expected;
    integer i;
    integer errors;

    b01_7seg dut (
        .ui_in(ui_in),
        .uo_out(uo_out)
    );

    function [7:0] expected_output;
        input [3:0] bcd;
        begin
            case (bcd)
                4'd0: expected_output = 8'b00000001;
                4'd1: expected_output = 8'b01001111;
                4'd2: expected_output = 8'b00010010;
                4'd3: expected_output = 8'b00000110;
                4'd4: expected_output = 8'b01001100;
                4'd5: expected_output = 8'b00100100;
                4'd6: expected_output = 8'b00100000;
                4'd7: expected_output = 8'b00001111;
                4'd8: expected_output = 8'b00000000;
                4'd9: expected_output = 8'b00000100;
                default: expected_output = 8'b11111111;
            endcase
        end
    endfunction

    initial begin
        errors = 0;

        for (i = 0; i < 16; i = i + 1) begin
            ui_in = i[3:0];
            expected = expected_output(i[3:0]);
            #10;

            if (uo_out !== expected) begin
                $display("FAIL: ui_in=%b, uo_out=%b, expected=%b",
                         ui_in, uo_out, expected);
                errors = errors + 1;
            end
            else begin
                $display("PASS: ui_in=%b, uo_out=%b",
                         ui_in, uo_out);
            end
        end

        if (errors == 0)
            $display("B01 exhaustive 4-bit validation PASS");
        else
            $display("B01 validation FAIL: %0d errors", errors);

        $finish;
    end

endmodule

